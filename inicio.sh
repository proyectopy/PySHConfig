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
. import/app_imp.sh
. inport/info_imp.sh
. imports/scripts_imp.sh
. import/serv_imp.sh
. import/sist_imp.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
###################################################
#FUNCIONES DEL SCRIPT
###################################################
menu_principal(){

clear

echo -e "
Elegir una opcion:
1 - Configuracion inicial
2 - Instalar Servidor
3 - Instalar Aplicaciones 
0 - Salir
===============================
"
read opcion

case $opcion in

    # Performs the function with the name of the variable passed
    0) clear; exit;;
    1) clear; config_info,.sh; sleep 6; upgrade.sh; pikey.sh; rootkey.sh; timezone.sh; timezone.sh; expandir.sh; lared.sh; ready;;
    #1) clear; config_info,sh; sleep 6; ready;;
    #2) upgrade.sh; curl.sh; git.sh; node.sh; chromium.sh; docker.sh; vscode.sh; ready;;
    2) sudo chmod +x apps.sh ; source apps.sh;;
    #3) upgrade.sh; ready;;
    *) menu_principal;;

esac
}
menu_principal
