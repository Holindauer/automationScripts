#!/bin/bash

# Script to add 'open-sesame' function to the .bashrc

# Define the user's shell configuration file
BASH_PROFILE="$HOME/.bashrc"

# Function to check and install wmctrl if not present
check_and_install_wmctrl() {
    if ! command -v wmctrl &> /dev/null; then
        echo "wmctrl could not be found, attempting to install..."
        sudo apt-get update && sudo apt-get install wmctrl -y
    else
        echo "wmctrl is already installed."
    fi
}

# Check if running as a regular user (not root, since we're modifying a user's personal config)
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root" >&2
    exit 1
fi

# Install wmctrl if not already installed
check_and_install_wmctrl

# Append the open-sesame function to the user's .bashrc file if it doesn't already exist
if ! grep -q 'function open-sesame()' "$BASH_PROFILE"; then
    cat >> "$BASH_PROFILE" << 'EOF'

# Function to open various programs in different workspaces
function open-sesame() {
    # Declare an array of commands to run in different workspaces
    declare -a commands=(
        "gnome-terminal -- bash -c 'cd ~/Projects/C-Compiler && code . && exec bash'"
        "brave --new-window https://chatgpt.com/?model=gpt-4&oai-dm=1"
        "brave --new-window https://www.github.com"
    )

    # Open each command in a new workspace
    for i in "${!commands[@]}"; do
        workspace_number=$i
        eval ${commands[$i]} &
        sleep 2
        window_id=$(wmctrl -l | tail -1 | awk '{print $1}')
        wmctrl -i -r "$window_id" -t $workspace_number
    done
}
EOF
    echo "open-sesame function added to $BASH_PROFILE"
else
    echo "open-sesame function is already in $BASH_PROFILE"
fi

# Inform the user to source their .bashrc file to apply changes
echo "Please run 'source $BASH_PROFILE' to activate the open-sesame function."
