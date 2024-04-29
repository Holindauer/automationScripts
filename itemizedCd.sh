#!/bin/bash

# Script to add 'cd-i' function to the .bashrc or .bash_profile globally or locally

# Define the user's shell configuration file
BASH_PROFILE="$HOME/.bashrc"

# Check if running as a regular user (not root, since we're modifying a user's personal config)
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root" >&2
    exit 1
fi

# Append the cd-i function to the user's .bashrc file if it doesn't already exist
if ! grep -q 'function cd-i()' "$BASH_PROFILE"; then
    cat >> "$BASH_PROFILE" << 'EOF'

# Function to change directories interactively
function cd-i() {
    local PS3="Enter the number of the directory you want to cd into (or 'q' to quit): "
    local dirs=(*/)
    local index=1
    local choice

    echo "Available directories:"
    for dir in "${dirs[@]}"; do
        echo "$index: $dir"
        ((index++))
    done

    read -p "$PS3" choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#dirs[@]} )); then
        cd "${dirs[$choice-1]}" && pwd
    elif [[ "$choice" =~ ^[qQ]$ ]]; then
        echo "Exiting..."
    else
        echo "Invalid option. Try another one."
    fi
}
EOF
    echo "cd-i function added to $BASH_PROFILE"
else
    echo "cd-i function is already in $BASH_PROFILE"
fi

# Inform the user to source their .bashrc file to apply changes
echo "Please run 'source $BASH_PROFILE' to activate the cd-i function."
