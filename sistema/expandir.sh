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
source /home/pi/MiSimple/scripts/funciones
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################

expandir.sh(){

    clear
    msg_expandir
    echo ""
    echo -ne " Quieres expandir el sistema de archivos (Recomendado) y pulsa [ENTER]: [$default] "
    read ex
    ex="${ex:-$default}"

    echo ""
    echo -ne " Has elegido que $ex quieres expandir el sistema de archivos"
    sleep 3
    

    if [ $ex != $default ]
        then
        conf_expand=false
        conf_expand
        else
        conf_expand=true
        # echo "$conf_network"
        sleep 3
        conf_expand
    fi

	if [ "$conf_expand" = true ]; 
        then 
        cursor_off
        clear
        msg_expandir
        msg_expandiendo

        #Ejecuta el resize de la sd de la Raspberry
        sudo raspi-config --expand-rootfs &>/dev/null
        
        clear
        msg_expandido
        msg_reboot
        cursor_on
        sleep 3
        clear

        else
        clear
        msg_sincambios
        clear
        sleep 3
        
    fi  
}

