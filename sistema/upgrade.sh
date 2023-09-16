#!/bin/bash
########################################################################
# Script: pikey.sh
# Descripcion: Configurar la clave del usuario Pi
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2022
# Version: V1.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
source /home/pi/MiSimple/sistema/funciones.sh
########################################################################
########################################################################
# FUNCION MENSAJE
########################################################################

upgrade.sh(){
	clear;
	msg_actualizar;
	sudo apt-get autoremove;
	sudo apt-get update;
	sudo apt-get upgrade;
	msg_actualizado;
	sleep 3
}
