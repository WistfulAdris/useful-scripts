#!/bin/bash

#This is the variables for the build. Make sure to change them before running the script.
DIRECTORY=/root/webserver
#Do NOT add '/', trailing slash in the end.
NGINX=1.27.0
NAXSI=1.6
COMPILE="--add-dynamic-module=${DIRECTORY}/naxsi-${NAXSI}/naxsi_src \
--without-mail_pop3_module \
--without-mail_imap_module \
--without-mail_smtp_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-http_realip_module \
--with-stream"
JOBS=3 #Adjust to CPU core +1

#Ensure dependencies are PRESENT (Debuan / Ubuntu).
function dependencies_debian ()
{
	sudo apt-get update
	sudo apt-get -y install sudo make wget build-essential zlib1g-dev libpcre3 libpcre3-dev unzip libssl-dev uuid-dev pkg-config
}

#Check if directory is present and create if it is not. Next, head to the installation directory.
function folder_check_create ()
{
	if [ ! -d "${DIRECTORY}" ]; then
	    mkdir -p "${DIRECTORY}"
	fi

	cd ${DIRECTORY}
}

#Prepare to build NAXSI.
function prepare_naxsi ()
{
	if [ ! -d naxsi-${NAXSI} ];
		then
			rm -rf naxsi-*;
      			mkdir naxsi-${NAXSI} && cd naxsi-${NAXSI};
   			wget https://github.com/wargio/naxsi/releases/download/${NAXSI}/naxsi-${NAXSI}-src-with-deps.tar.gz;
			tar -xvzf naxsi-${NAXSI}-src-with-deps.tar.gz;
   			rm naxsi-${NAXSI}-src-with-deps.tar.gz;
   			cd ..
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
	make -j${JOBS};
	sudo make install
}


#The variables below executes the process. Do not rename them unless you know what you are doing.

#Install dependencies.
#Comment it out if you already have proper dependencies installed or on another system other than Debian or Ubuntu based system.
dependencies_debian
#Create install folder, specified in DIRECTORY variable and enter the folder.
folder_check_create
#Download, unpack NAXSI_SRC.
prepare_naxsi
#Download, unpack NGINX.
prepare_nginx
#Compile and install NGINX + MODULES.
compile
