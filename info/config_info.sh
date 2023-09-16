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

###################################################
# OBTENER MENSAJE INFORMACION
###################################################
config_info.sh(){
    msg_info
    echo -e "
        Al elegir esta opción se va a proceder a:
            1 - Actualizar el sistema haciendo un update & upgrade del mismo.
            2 - Asignar una contraseña al usuario pi.
            3 - Asignar una contraseña al usuario root y configurar su acceso.
            4 - Ajustes de zona horaria e idioma.
            5 - Expandir el sistema de archivos para ocupar el 100% del disco o SD.
            6 - Configurar el hostname una IP fija y la red WIFI

        "
while true; do

    read -p "Desea Continuar S/N? " -t 5 yn

    if [ -z "$yn" ]
    then
        echo -e "\n...Procedemos a continuar con la ejecución. !";
        break 1
    fi

    case $yn in
        [Ss]* ) logInfo "Continua la Ejecución. !"; break;;
        [Nn]* ) logError "Finaliza la Ejecución. !"; exit;;
        * ) logWarn "Seleccione Si o No.";;
    esac
done    
}

