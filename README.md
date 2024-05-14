# automationScripts
Useful scripts for automating processes

This repository contains bash scripts that automate simple processes for improving productivity. Each script will install a CLI command by writing a function to the $HOME/.bashrc file. If a CLI command that was installed with one of these scripts wishes to be removed, open $HOME/.bashrc and delete the function whose name corresponds to the command.


# Scripts (will be added to as more are created):

### [Itemized Directory Change Directory](itemizedCd.sh)
Outputs an itemized list of directories and gets input from the user to change into which one. Useful for long directory paths.

Run the following commands to add the cd-i command to your bash profile:

    ./install_itemizedCd.sh
    source $HOME/.bashrc

Then run the following command to use:

    cd-i

### [Project Opener](projectOpener.sh)
Runs commands that will run a list of comamnds in different workspaces. This means if those commands open programs/files, they will open into those different workspaces.


Make sure to edit the script's list of comamnds before installing. Then run the following commands to add the open-sesame command to your bash profile.

    sudo apt install wmctrl
    ./install_projectOpener.sh
    source $HOME/.bashrc

After installation, run the following command to use:

    open-sesame
