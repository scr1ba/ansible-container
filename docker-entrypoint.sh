#!/bin/sh

# Check if the TARGET_HOSTS environment variable is set
if [ -z "$TARGET_HOSTS" ]; then
    echo "Error: TARGET_HOSTS environment variable is not set."
    exit 1
fi

# Generate the inventory file
echo "[vm_inv]" > /ansible/inventory.ini

# Split TARGET_HOSTS into hosts and add them to the inventory
OLD_IFS="$IFS"
IFS=','
for HOST in $TARGET_HOSTS; do
    echo $HOST >> /ansible/inventory.ini
done
IFS="$OLD_IFS"

echo "Inventory generated at /ansible/inventory.ini with hosts: $TARGET_HOSTS"

# Check if the SSH_KEY_PATH environment variable is set
if [ -z "$SSH_KEY_PATH" ]; then
    echo "Error: SSH_KEY_PATH environment variable is not set."
    exit 1
fi

# Debugging: Check if SSH_KEY_PATH is a file, directory, or non-existent
echo "Checking if $SSH_KEY_PATH is a file, a directory, or non-existent"
if [ -f "$SSH_KEY_PATH" ]; then
    echo "$SSH_KEY_PATH is a regular file."
    echo "SSH key found at $SSH_KEY_PATH, setting correct permissions..."
    chmod 600 "$SSH_KEY_PATH"
elif [ -d "$SSH_KEY_PATH" ]; then
    echo "$SSH_KEY_PATH is a directory."
else
    echo "$SSH_KEY_PATH does not exist."
fi

# Additional Debugging: List /root/.ssh directory and SSH_KEY_PATH
echo "Listing /root/.ssh directory:"
ls -lha /root/.ssh

echo "Listing $SSH_KEY_PATH:"
ls -lha $SSH_KEY_PATH

# Run Ansible Playbook
# "$@" allows to pass additional arguments to ansible-playbook
ansible-playbook -i /ansible/inventory.ini "$@"
