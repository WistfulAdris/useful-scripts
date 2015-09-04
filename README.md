# nginx-naxsi-pagespeed

This script automates installation & compilation of nginx, naxsi, and ngx_pagespeed. In addition, it allows you to update nginx, naxsi, and ngx_pagespeed just by changing the variables' version.

# Documentation

All you have to do is edit the following.

DIRECTORY=(add path to directory where you want temporary installation files to be stored)
PAGESPEED=(pagespeed version goes here. Obtain one from https://github.com/pagespeed/ngx_pagespeed/releases)
NGINX=(nginx version goes here. Obtain one from http://wiki.nginx.org/Install)
NAXSI=(naxsi version goes here. Obtain one from https://github.com/nbs-system/naxsi/releases)
COMPILE=(arguments that are used to compile NGINX goes here. Ensure that you modify this to your preference.)

If you want to skip a process, (ex: skip installation of dependencies, or skip installation of naxsi), simply comment the call of function out in the bottom of the script.

# License

You are free to use this script in accords to your need. I don't take credit of this script, and packages that were used in the script goes to respective owners.
