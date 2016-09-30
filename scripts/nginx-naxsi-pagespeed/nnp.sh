#!/bin/bash

#This is the variables for the build. Make sure to change them before running the script.
DIRECTORY=/root/webserver
#Do NOT add '/', trailing slash in the end.
PAGESPEED=1.11.33.4
NGINX=1.11.1
NAXSI=0.55.1
COMPILE="--add-module=${DIRECTORY}/ngx_pagespeed-release-${PAGESPEED}-beta \
--add-module=${DIRECTORY}/naxsi-${NAXSI}/naxsi_src \
--without-mail_pop3_module \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_stub_status_module \
--with-http_gzip_static_module"

#Ensure dependencies are PRESENT (Debuan / Ubuntu).
function dependencies_debian ()
{
	sudo apt-get update
	sudo apt-get -y install sudo make wget build-essential zlib1g-dev libpcre3 libpcre3-dev unzip libssl-dev
}

#Check if directory is present and create if it is not. Next, head to the installation directory.
function folder_check_create ()
{
	if [ ! -d "${DIRECTORY}" ]; then
	    mkdir -p "${DIRECTORY}"
	fi

	cd ${DIRECTORY}
}

#Preapre to build PAGESPEED.
function prepare_pagespeed ()
{
	if [ ! -d ngx_pagespeed-release-${PAGESPEED}-beta ];
		then
			rm -rf ngx_pagespeed-release-*-beta
			wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${PAGESPEED}-beta.zip
			unzip release-${PAGESPEED}-beta.zip
			rm release-${PAGESPEED}-beta.zip

			cd ngx_pagespeed-release-${PAGESPEED}-beta/
			wget https://dl.google.com/dl/page-speed/psol/${PAGESPEED}.tar.gz
			tar -xzvf ${PAGESPEED}.tar.gz
			rm ${PAGESPEED}.tar.gz
		fi

		#Go to install directory
		cd ${DIRECTORY}
	}

#Prepare to build NAXSI.
function prepare_naxsi ()
{
	if [ ! -d naxsi-${NAXSI} ];
		then
			rm -rf naxsi-*;
			wget https://github.com/nbs-system/naxsi/archive/${NAXSI}.tar.gz;
			tar -xvzf ${NAXSI}.tar.gz;
			rm ${NAXSI}.tar.gz;
		fi;
}

#Prepare to build NGINX.
function prepare_nginx ()
{
	if [ ! -d nginx-${NGINX} ];
		then
			rm -rf nginx-*;
			wget http://nginx.org/download/nginx-${NGINX}.tar.gz;
			tar -xvzf nginx-${NGINX}.tar.gz;
			rm nginx-${NGINX}.tar.gz;
		fi;
}

#Finally, compile and install.
function compile ()
{
	cd ${DIRECTORY}/nginx-${NGINX}
	./configure ${COMPILE}
	make;
	sudo make install
}


#The variables below executes the process. Do not rename them unless you know what you are doing.

#Install dependencies.
#Comment it out if you already have proper dependencies installed or on another system other than Debian or Ubuntu based system.
dependencies_debian
#Create install folder, specified in DIRECTORY variable and enter the folder.
folder_check_create
#Download, unpack NGX_PAGESPEED.
prepare_pagespeed
#Download, unpack NAXSI_SRC.
prepare_naxsi
#Download, unpack NGINX.
prepare_nginx
#Compile and install NGINX + MODULES.
compile
