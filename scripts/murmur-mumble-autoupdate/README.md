# MURMUR -> Autoupdate + Autoinstall [Binary]

This script is intended to automate installation up upgrade MURMUR, Mumble client for Linux GNU static. Usually, the packages' versions listed on the script are up to date. However, it may be good practice to check to ensure that you get the latest version installed.

# Documentation

Before running the script in bash or shell, ensure to change the variables. In addition, it is great practice to skim through the script before running the script.

TEMP={This is the directory where the compressed murmur is downloaded and unpacked.}

USER={This is the user that is used to run / install murmur. DO NOT LEAVE THIS AS ROOT!}

DIRECTORY={The directory where murmur will actually be installed at. Must be writable by the user running the script. i.e. root}

MUMBLE={Latest version of murmur goes here.}

MUMBLEOLD={Older murmur version: a version you are updating from}

If you want to skip a process, simply comment out the call of function in the bottom of the script.

To upgrade any packages installed, simply change the versions of variables of the outdated package(s) in the variables. It will automatically compare the version installed (directory name in the cache), and update the packages into latest version.

To run this script, simply type the following into bash or shell.

chmod +x mumble.sh && bash mumble.sh

# License

You are free to use this script in accords to your need. I don't take credit of this script, and packages that were used in the script goes to respective owners. If you wish to contribute to this code, please feel free to inform me.
