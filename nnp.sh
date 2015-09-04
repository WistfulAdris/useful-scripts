#!/bin/bash

#Versions of Google's Pagespeed, NAXSI, NGINX. Along with other variables.
DIRECTORY=/root/webserver
#DO NOT add / at the end.
PAGESPEED=1.9.32.6
NGINX=1.8.0
NAXSI=0.54rc3
COMPILE="--add-module=${DIRECTORY}/ngx_pagespeed-release-${PAGESPEED}-beta \
--add-module=${DIRECTORY}/naxsi-${NAXSI}/naxsi_src \
--without-mail_pop3_module \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-http_ssl_module \
--with-http_spdy_module \
--with-http_stub_status_module \
--with-http_gzip_static_module"

#Ensure dependencies of BUILD-ESSENTIAL ARE PRESENT
function dependencies ()
{
  sudo apt-get update
	sudo apt-get -y install sudo make wget build-essential zlib1g-dev libpcre3 libpcre3-dev unzip libssl-dev
}

#Create directory if it is not present, and head to directory install
function folder-check-create ()
{
	if [ ! -d "${DIRECTORY}" ]; then
	    mkdir -p "${DIRECTORY}"
	fi

	cd ${DIRECTORY}
}

#Preparation of PAGESPEED
function prepare-pagespeed ()
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

#Preparation of NAXSI
function prepare-naxsi ()
{
if [ ! -d naxsi-${NAXSI} ];
	then
		rm -rf naxsi-*;
		wget https://github.com/nbs-system/naxsi/archive/${NAXSI}.tar.gz;
		tar -xvzf ${NAXSI}.tar.gz;
		rm ${NAXSI}.tar.gz;
	fi;
}

#Preparation of NGINX
function prepare-nginx ()
{
	if [ ! -d nginx-${NGINX} ];
		then
			rm -rf nginx-*;
			wget http://nginx.org/download/nginx-${NGINX}.tar.gz;
			tar -xvzf nginx-${NGINX}.tar.gz;
			rm nginx-${NGINX}.tar.gz;
		fi;
}

function compile ()
{
	cd ${DIRECTORY}/nginx-${NGINX}
	./configure ${COMPILE}
	make;
	sudo make install
}


#Execute functions

dependencies
#Installs dependencies. Comment it out if you already have proper dependencies.
folder-check-create
#Creates install folder specified in DIRECTORY variable and enters the folder.
prepare-pagespeed
#Downloads, and unpacks NGX_PAGESPEED module
prepare-naxsi
#Downloads, and unpacks NAXSI_SRC module
prepare-nginx
#Compiles, and installs NGINX + MODULES with COMPILE
compile
