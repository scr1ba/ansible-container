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

# Run Ansible Playbook
# "$@" allows to pass additional arguments to ansible-playbook
ansible-playbook -i /ansible/inventory.ini "$@"
