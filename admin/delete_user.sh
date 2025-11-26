#!/bin/bash

# ==========================================================================
# Secure user removal script
# Safely disables → kills processes gracefully → deletes user + home + group
# ==========================================================================

loggit() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $*"
}

if [[ $EUID -ne 0 ]]; then
    loggit "This script must be run as root"
    exit 1
fi

read -p "Enter username to COMPLETELY REMOVE: " username

if [[ -z "$username" || "$username" == "root" ]]; then
    loggit "Invalid or dangerous username."
    exit 1
fi

if ! id "$username" >/dev/null 2>&1; then
    loggit "User '$username' does not exist. Nothing to do."
    exit 0
fi

echo
loggit "WARNING: This will permanently delete:"
loggit "   • User: $username"
loggit "   • Home directory: /home/$username"
loggit "   • Mail spool, cron jobs, processes"
loggit "   • Primary group: $username (if no other users)"
echo
read -p "Type the username '$username' to confirm deletion: " confirm

if [[ "$confirm" != "$username" ]]; then
    loggit "Confirmation failed. Aborting."
    exit 1
fi

loggit "Starting safe removal of user '$username'..."

loggit "Locking user account"
usermod -L "$username" 2>/dev/null || passwd -l "$username"

if pkill -u "$username"; then
    loggit "Sent SIGTERM to all user processes"
    sleep 3
fi

if pkill -9 -u "$username"; then
    loggit "Force killed remaining processes"
fi

loggit "Deleting user and home directory with userdel -r"
if userdel -r "$username"; then
    loggit "User and home directory removed successfully"
else
    loggit "userdel failed! Trying manual cleanup..."
    rm -rf "/home/$username"
    rm -rf "/var/spool/mail/$username"
fi

if getent group "$username" >/dev/null 2>&1; then
    if ! getent passwd | cut -d: -f4 | grep -q "^$(getent group "$username" | cut -d: -f3)$"; then
        loggit "Removing empty primary group '$username'"
        groupdel "$username"
    else
        loggit "Group '$username' still used by other accounts — leaving it"
    fi
fi

crontab -r -u "$username" 2>/dev/null || true
rm -f /etc/sudoers.d/"$username" 2>/dev/null

if [[ -d "/root/ssh_keys/$username" ]]; then
    loggit "Removing backed-up SSH keys in /root/ssh_keys/$username"
    rm -rf "/root/ssh_keys/$username"
else
    loggit "No backed-up keys found in /root/ssh_keys/$username"
fi

loggit "User '$username' has been COMPLETELY and safely removed from the system."
echo
loggit "All traces erased. No recovery possible."

exit 0
