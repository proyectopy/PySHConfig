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
. scripts/import.sh
. sistema/import.sh
. servidor/import.sh
. apps/import.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################

###################################################
# FUNCIONES DEL  SCRIPT
###################################################
welcome(){

clear
echo -e "
${txtblu}
===================================

        AutoInstall SH
Created by Rafael Corrêa Gomes

===================================

${txtrst}Options:

${Red}########## sistema${txtrst}
 "
for file in $(ls ./sistema)
do
    if [ $file != import.sh ]
    then
        echo $file
    fi

done;
echo -e "

${Yellow}########## SERVIDOR
${txtrst} "

for file in $(ls ./servidor)
do
    if [ $file != import.sh ]
    then
        echo $file
    fi

done;
echo -e "

${Purple}########## APLICACIONES
${txtrst} "
for file in $(ls ./apps)
do
    if [ $file != import.sh ] && [ $file != files ]
    then
        echo $file
    fi

done;
echo -e "


e - Exit

==================================

Enter an option:
"
    read program

case $program in

    # Performs the function with the name of the variable passed
    e) clear; exit;;
    $program) $program; ready;;
    *) welcome;;

esac
}

welcome
