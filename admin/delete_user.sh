#!/bin/bash

# ==========================================================================
# Secure user removal script
# Safely disables → kills processes gracefully → deletes user + home + group
# ==========================================================================

set -euo pipefail

loggit() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $*"
}

validate_username() {
    local candidate="$1"
    [[ "$candidate" =~ ^[a-z_][a-z0-9_-]{0,31}$ ]]
}

safe_delete_dir() {
    local target="$1"
    local expected_prefix="$2"

    if [[ -z "$target" || "$target" = "/" || "$target" = "/home" || "$target" = "/root" ]]; then
        loggit "Refusing to delete unsafe path: '$target'"
        return 1
    fi
    if [[ "$target" != "$expected_prefix"* ]]; then
        loggit "Refusing to delete path outside expected prefix: '$target'"
        return 1
    fi
    rm -rf -- "$target"
}

if [[ $EUID -ne 0 ]]; then
    loggit "This script must be run as root"
    exit 1
fi

read -r -p "Enter username to COMPLETELY REMOVE: " username

if [[ -z "$username" || "$username" == "root" ]]; then
    loggit "Invalid or dangerous username."
    exit 1
fi

if ! validate_username "$username"; then
    loggit "Invalid username format. Use lowercase letters, numbers, '_' or '-'."
    exit 1
fi

if ! id "$username" >/dev/null 2>&1; then
    loggit "User '$username' does not exist. Nothing to do."
    exit 0
fi

home_dir="$(getent passwd "$username" | cut -d: -f6)"
if [[ -z "${home_dir:-}" ]]; then
    loggit "Could not resolve home directory for '$username'."
    exit 1
fi

echo
loggit "WARNING: This will permanently delete:"
loggit "   • User: $username"
loggit "   • Home directory: $home_dir"
loggit "   • Mail spool, cron jobs, processes"
loggit "   • Primary group: $username (if no other users)"
echo
read -r -p "Type the username '$username' to confirm deletion: " confirm

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
    safe_delete_dir "$home_dir" "/home/"
    rm -f "/var/spool/mail/$username"
fi

if getent group "$username" >/dev/null 2>&1; then
    target_gid="$(getent group "$username" | cut -d: -f3)"
    if ! getent passwd | cut -d: -f4 | awk -v gid="$target_gid" '$1 == gid { found=1 } END { exit !found }'; then
        loggit "Removing empty primary group '$username'"
        groupdel -- "$username"
    else
        loggit "Group '$username' still used by other accounts — leaving it"
    fi
fi

crontab -r -u "$username" 2>/dev/null || true
rm -f /etc/sudoers.d/"$username" 2>/dev/null

if [[ -d "/root/ssh_keys/$username" ]]; then
    loggit "Removing backed-up SSH keys in /root/ssh_keys/$username"
    safe_delete_dir "/root/ssh_keys/$username" "/root/ssh_keys/"
else
    loggit "No backed-up keys found in /root/ssh_keys/$username"
fi

loggit "User '$username' has been COMPLETELY and safely removed from the system."
echo
loggit "All traces erased. No recovery possible."

exit 0
