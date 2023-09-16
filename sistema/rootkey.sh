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
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
###################################################
# OBTENER LA VARIABLE CONTRASEÑA ROOT (OK)
###################################################

rootkey.sh(){
	clear  
      
    msg_ch_claves
     
    echo -ne "$(ColorAmarillo ' Escribe la contraseña para el usuario root ') despues pulsa [ENTER]:   "    

    read -s new_password_r

    #echo $new_password_r
    #sleep 3

    
    if [ -z "$new_password_r" ]
    then
        conf_pass=false
    else
        conf_pass=true
    fi
#probando

    #echo $conf_pass
    #sleep 3

    cursor_off
    if [ "$conf_pass" = true ]; then
        clear
        msg_cambiar

        echo "root:$new_password_r" | sudo chpasswd

        echo -ne '#####                     (33%)\r'
        sleep 1
        echo -ne '#############             (66%)\r'
        sleep 1
        echo -ne '#######################   (100%)\r'
        sleep 1
        echo -ne '\n'

        #modifica el archivo /etc/ssh/sshd_config
        configurando_msg
        sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
        sleep 3
        #reinicia servicio ssh
        sudo service ssh restart

        echo -ne '#####                     (33%)\r'
        sleep 1
        echo -ne '#############             (66%)\r'
        sleep 1
        echo -ne '#######################   (100%)\r'
        sleep 1
        echo -ne '\n'

        clear
        msg_cambiada

        1

    else

        clear
        msg_sincambios
        sleep 3
    
    fi
    cursor_on
    
    clear;

}

