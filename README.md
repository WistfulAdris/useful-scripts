# nginx-naxsi-pagespeed

This script is intended to automate installation & compilation of nginx, naxsi, and ngx_pagespeed. In addition, it allows you to update nginx, naxsi, and ngx_pagespeed just by changing the variables' version. Usually, the packages' versions listed on the script are up to date. However, it may be good practice to check to ensure that you get the lastest version installed.

# Documentation

Before running the script in bash or shell, ensure to change the variables. In addition, it is great practice to skim through the script before running the script.

DIRECTORY=(This is the directory where it will use to download the packages and compile them)

PAGESPEED=(pagespeed version goes here. Obtain one from https://github.com/pagespeed/ngx_pagespeed/releases)

NGINX=(nginx version goes here. Obtain one from http://wiki.nginx.org/Install)

NAXSI=(naxsi version goes here. Obtain one from https://github.com/nbs-system/naxsi/releases)
COMPILE=(arguments that are used to compile NGINX goes here. Ensure that you modify this to your preference.)

If you want to skip a process, (ex: skip installation of dependencies, or skip installation of naxsi), simply comment out the call of function in the bottom of the script.

To upgrade any packages installed, simply change the versions of variables of the outdated packages in the variables. It will automatically compare the version installed (directory name in the cache), and update the packages into latest version.

To run this script, simply type the following into bash or shell.

chmod +x nnp.sh && bash nnp.sh

# License

You are free to use this script in accords to your need. I don't take credit of this script, and packages that were used in the script goes to respective owners. (Google, NGINX, NAXSI) If you wish to contribute to this code, please feel free to inform me.
