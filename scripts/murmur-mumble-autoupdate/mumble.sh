#!/bin/bash

#This is the variables for the build. Make sure to change them before running the script.
TEMP=/tmp/mumble
USER=mumble
DIRECTORY=/home/mumble
#Do NOT add '/', trailing slash in the end.
MUMBLE=1.2.16
MUMBLEOLD=1.2.15

function first_install()
{
	useradd ${USER}
}

#Check if directory is present and create if it is not. Next, head to the installation directory.
function folder_check_create ()
{
	if [ ! -d "${TEMP}" ]; then
	    mkdir -p "${TEMP}"
	fi

	cd ${TEMP}
}

#Preapre to install mumble.
function prepare_mumble ()
{
	if [ ! -f murmur-static_x86-${MUMBLE}.tar.bz2 ];
		then
			rm -rf murmur-static_x86-*
			wget https://github.com/mumble-voip/mumble/releases/download/1.2.16/murmur-static_x86-${MUMBLE}.tar.bz2
			tar -xvf murmur-static_x86-${MUMBLE}.tar.bz2
		fi
	}

#Install murmur
function install ()
{
	cd ${TEMP}
	mv murmur-static_x86-${MUMBLE} ${DIRECTORY}/
	cd ${DIRECTORY}
	mv murmur-static_x86-${MUMBLEOLD} oldmurmur-v${MUMBLEOLD}
	chown -R ${USER}:${USER} murmur-static_x86-${MUMBLE}
}

#Copy old config and database to new install
function migrate ()
{
	rm ${DIRECTORY}/murmur-static_x86-${MUMBLE}/murmur.ini
	cp ${DIRECTORY}/oldmurmur-v${MUMBLEOLD}/murmur.ini ${DIRECTORY}/murmur-static_x86-${MUMBLE}/murmur.ini
	cp ${DIRECTORY}/oldmurmur-v${MUMBLEOLD}/murmur.sqlite ${DIRECTORY}/murmur-static_x86-${MUMBLE}/murmur.sqlite
	chown -R ${USER}:${USER} murmur-static_x86-${MUMBLE}
}

#The variables below executes the process. Do not rename them unless you know what you are doing.

#Create user
#first_install
#Create install folder, specified in DIRECTORY variable and enter the folder.
folder_check_create
#Download and unpack murmur
prepare_mumble
#Move murmur to the DIRECTORY and set the permission.
install
#Migrate old config and db to new install
migrate
