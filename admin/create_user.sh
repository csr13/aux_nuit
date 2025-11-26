#!/bin/bash

# =============================================================================
# Secure user creation script with optional SSH key generation
# Saves private key to /root/ssh_keys/<username>/ for admin retrieval
# =============================================================================

loggit() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $*" 
}

if [[ $EUID -ne 0 ]]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] This script must be run as root"
    exit 1
fi

read -p "Enter username: " username

if [[ -z "$username" ]]; then
    loggit "Username cannot be empty"
    exit 1
fi

if id "$username" >/dev/null 2>&1; then
    loggit "User '$username' already exists. Choose another name."
    exit 1
fi

group="$username"
if ! getent group "$group" >/dev/null 2>&1; then
    loggit "Creating group $group"
    groupadd "$group"
else
    loggit "Group $group already exists"
fi

loggit "Creating user $username with home directory"
useradd -m -s /bin/bash -g "$group" "$username"

loggit "User $username created successfully"

read -p "Generate SSH key pair for $username? (yes/no): " answer
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    homedir="/home/$username"
    
    loggit "Generating SSH key pair for $username"
    
    # Create .ssh directory with correct permissions
    mkdir -p "$homedir/.ssh"
    chmod 700 "$homedir/.ssh"
    chown "$username":"$group" "$homedir/.ssh"

    # Generate key as the user (best practice)
    sudo -u "$username" ssh-keygen -f "$homedir/.ssh/id_rsa" -t rsa -b 4096 -N "" -C "$username@$(hostname)-$(date +%Y-%m-%d)"

    # Set correct permissions
    chmod 600 "$homedir/.ssh/id_rsa"
    chmod 644 "$homedir/.ssh/id_rsa.pub"
    chown "$username":"$group" "$homedir/.ssh"/id_*

    # Set up authorized_keys (append, don't overwrite)
    cat "$homedir/.ssh/id_rsa.pub" >> "$homedir/.ssh/authorized_keys"
    chmod 600 "$homedir/.ssh/authorized_keys"
    chown "$username":"$group" "$homedir/.ssh/authorized_keys"

    # Backup private key for admin retrieval
    backup_dir="/root/ssh_keys/$username"
    mkdir -p "$backup_dir"
    cp "$homedir/.ssh/id_rsa" "$backup_dir/"
    cp "$homedir/.ssh/id_rsa.pub" "$backup_dir/"
    chmod 600 "$backup_dir/id_rsa"
    loggit "Private key backed up to $backup_dir/id_rsa"

    loggit "SSH key setup complete for $username"
else
    loggit "Skipping SSH key generation for $username"
fi

loggit "User onboarding complete!"
echo
echo "To let $username log in:"
echo "   • Give them the contents of /root/ssh_keys/$username/id_rsa (if generated)"
echo "   • Or have them use their own key and add it to ~$username/.ssh/authorized_keys"
echo

exit 0
