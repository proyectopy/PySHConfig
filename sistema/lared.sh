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
hostname="$(cat /etc/hostname)"
addrs=( $(arp -ni eth0 | grep -o '^[0-9][^ ]*') )
default_ip="192.168.1.105"
default_gtw="192.168.1.1"
default_nmsrv="8.8.8.8"
default="Si"
default_ssid="nombre-de-tu-wifi"
default_psk="password-de-tu-wifi"
default_key="WPA-PSK"
# WPA/WPA2 TKIP/AES
ip=192.168.1.105
mask=255.255.255.0
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################

lared.sh(){
    ###################################################
    #              CONFIGURAR EL HOSTNAME             #
    ###################################################
    cursor_on
    clear
    msg_host
    echo ""
    echo -ne " Quieres Configurar el hostname [Si/No]: [$default] "
    read respuesta
    respuesta="${respuesta:-$default}"

    echo ""
    echo -ne " Has elegido que $respuesta quieres configurar el hostname"
    sleep 3
    if [ $respuesta != $default ]
        then
            conf_hostname=false
            clear
            msg_sincambios
            sleep 3
        else
            conf_hostname=true
            conf_hostname

    fi             
	if [ "$conf_hostname" = true ]; then
        clear
        msg_host
        echo " "
        echo -ne "El hostname por defecto es [$hostname] :   "
        echo " "
        echo -ne "$(ColorAmarillo 'Introduce uno nuevo si quieres cambiarlo'). Despues pulsa [ENTER]: [$hostname] "
        read nuevohost
        nuevohost="${nuevohost:-$hostname}"

        clear
        echo ""
        configurando_msg
        msg_host
        
        sleep 3
           
        sudo cp /etc/hosts /etc/hosts.old
        sudo sed -i "s/$hostname/$nuevohost/g" /etc/hosts    
        
        sudo cp /etc/hostname /etc/hostname.old
        sudo sed -i "s/$hostname/$nuevohost/g" /etc/hostname

        sleep 3    
        
        clear
        msg_host
        msg_cambiado
        msg_reboot

        sleep 3
        
    fi
    ###################################################
    #                 CONFIGURAR LA RED               #
    ###################################################
    clear
    msg_redes
    echo ""
    echo -ne " Quieres configurar la red (Recomendado) : [$default] "
    read network
    network="${network:-$default}"
    echo ""
    echo -ne " Has elegido que $network quieres configurar la red"
    sleep 3
    
    
    if [ $network != $default ]
        then

            conf_network=false

        else
        
            conf_network=true
            conf_network
    fi
    if [ "$conf_network" = true ]; then

        clear
        configurando_msg
        msg_redes

        
        ###################################################
        #            OBTENER LA VARIABLE IP               #
        ###################################################
        clear
        msg_ip
        echo ""
        echo -ne " El valor por defecto es $default_ip. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " Que IP quieres para tu Raspberry y pulsa [ENTER]: [$default_ip] "
        read ipadress
        : ${ipadress:=$default_ip}
        # echo ""
        # echo "$ipadress"
        sleep 3
        
        # echo -n "\nPara introducir la IP usa el formato xx.xx.xx.xx\nQue IP usará la Raspberry y pulsa [ENTER]: "
        # read ipadress
        #while [ "$ipadress" = "" ]
        while [ -z "$ipadress"]
        do
            clear
            msg_error
            echo ""
            echo -ne " No se puede quedar vacio"
            echo -ne " El valor por defecto es $default_ip."
            echo -ne " Usa el mismo formato para cambiarlo."
            echo -ne " Que IP quieres para tu Raspberry y pulsa [ENTER]: [$default_ip] " 
            read ipadress
        done

        ###################################################
        #          OBTENER LA VARIABLE GATEWAY            #
        ###################################################

        
        clear
        msg_gateway
        echo ""
        echo -ne " El valor por defecto es $default_gtw. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " Que Puerta de acceso usa tu Raspberry y pulsa [ENTER]: [$default_gtw] " 
        read gateway
        : ${gateway:=$default_gtw}
        # echo ""
        # echo "$gateway"

        # echo -n "\nPara el gateway usa el formato xx.xx.xx.xx\nQue Gateway usará tu Raspberry y pulsa [ENTER] "
        # read gateway
        while [ -z "$gateway" ]
        do
            clear
            msg_error
            echo ""
            echo -ne " No se puede quedar vacio"
            echo -ne " El valor por defecto es $default_gtw. \n Usa el mismo formato para cambiarlo "
            echo -ne " Que Gateway quieres para tu Raspberry: [$default_gtw] " 
            read gateway
        done

        ###################################################
        #          OBTENER LA VARIABLE NAMESERVER         #
        ###################################################

        
        clear
        msg_nmsrv
        echo ""
        echo -ne " El valor por defecto es $default_nmsrv. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " Que servidores de nombres usa tu Raspberry y pulsa [ENTER]: [$default_nmsrv] " 
        read nameservers
        : ${nameservers:=$default_nmsrv}

        # echo ""
        # echo "$nameservers"

        # echo -n "\nPara el servidores de nombres usa el formato xx.xx.xx.xx\nQue NameServers usará tu Raspberry y pulsa [ENTER]:"
        # read nameservers
        while [ -z "$nameservers"]
        do
            clear
            msg_error
            echo ""
            echo -ne " No se puede quedar vacio"
            echo -ne " El valor por defecto es $default_nmsrv. \n Usa el mismo formato para cambiarlo "
            echo -ne " Que nameserver quieres para tu Raspberry: [$default_nmsrv] " 
            read nameservers
        done
        clear
        configurando_msg
        msg_redes
        # echo ""
        # echo "$ipadress"
        # echo ""
        # echo "$gateway"
        # echo ""
        # echo "$nammeservers"
        
        #modifica el archivo /etc/dhcpcd.conf
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/dhcpcd.conf
        sudo echo "interface eth0" >> /etc/dhcpcd.conf
        sudo echo "static ip_address=$ipadress/24" >> /etc/dhcpcd.conf
        sudo echo "static routers=$gateway" >> /etc/dhcpcd.conf
        sudo echo "static domain_name_servers=$gateway $nameservers" >> /etc/dhcpcd.conf

        clear
        msg_redes_ok
        sleep 3
        
        else

        msg_sincambios
        sleep 3
    fi
    clear
    msg_redes
    echo ""
    echo -ne " Quieres Activar el WIFI de tu Raspberry: [$default] "
    read network
    network="${network:-$default}"
    echo ""
    echo -ne " Has elegido que $network quieres configurar la red"
    sleep 3

    if [ $network != $default ]
        then

            conf_wifi=false
            msg_sincambios
        else
        
            conf_wifi=true
            conf_wifi
    fi
    if [ "$conf_wifi" = true ]; then

        clear
        configurando_msg
        msg_redes

        
        ###################################################
        #            OBTENER NOMBRE DEL WIFI              #
        ###################################################
        clear
        msg_wifissid
        echo ""
        echo -ne " El valor por defecto es $default_ssid. Introduce el nombre de la red"
        echo ""
        echo -ne " Escribe el nombre de la red y pulsa [ENTER]: [$default_ssid] "
        read ssid
        : ${ssid:=$default_ssid}
        
        sleep 3

        # Comprueba que se haya introducido algun dato
        while [ "$ssid" = "" ]
        do
            # read ssid
            clear
            msg_error
            echo ""
            echo -ne " No se puede quedar vacio"
            echo ""
            echo -ne " El valor por defecto es $default_ssid."
            echo ""
            echo -ne " Introduce el nombre de tu red. y pulsa [ENTER]:"
            read ssid
        done

        ###################################################
        #              OBTENER LA CLAVE WIFI              #
        ###################################################

        
        clear
        msg_wifikey
        echo ""
        echo -ne " El valor por defecto es $default_psk. Usa el mismo formato para cambiarlo "
        echo ""
        echo -ne " Escribe la clave de tu WiFi y pulsa [ENTER]: [$default_psk] " 
        read psk
        : ${psk:=$default_psk}
        

        while [ "$psk" = "" ]
        do
            # read psk
            clear
            msg_error
            echo ""
            echo -ne " No se puede quedar vacio"
            echo ""
            echo -ne " El valor por defecto es $default_psk."
            echo ""
            echo -ne " Introduce la clave WiFi. y pulsa [ENTER]:" 
            read psk
        done
        sleep 3
        
        sleep 3
        sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bkp
        sudo chmod 777 /etc/wpa_supplicant/wpa_supplicant.conf

        #modifica el archivo /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "country=ES" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo " " >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "ssid=\"$ssid"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "scan_ssid=1" >> /etc/wpa_supplicant/wpa_supplicant.conf 
        sudo echo "psk=\"$psk"\" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "key_mgmt=$default_key" >> /etc/wpa_supplicant/wpa_supplicant.conf
        sudo echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

        sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
        
        sudo cp /etc/network/interfaces /etc/network/interfaces.bkp
        sudo chmod 777 /etc/network/interfaces

        # Modifica el archivo /etc/network/interfaces
        
        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface eth0" >> /etc/network/interfaces
        sudo echo "auto etho" >> /etc/network/interfaces
        sudo echo "iface eth0 inet static" >> /etc/network/interfaces 
        sudo echo "address $ip" >> /etc/network/interfaces
        sudo echo "netmask $mask" >> /etc/network/interfaces

        sudo echo " " >> /etc/network/interfaces
        sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/network/interfaces
        sudo echo "# Interface WiFi" >> /etc/network/interfaces
        sudo echo "etc/network/interfaces" >> /etc/network/interfaces
        sudo echo "allow-hotplug wlan0" >> /etc/network/interfaces 
        sudo echo "wpa-ssid \"$ssid"\" >> /etc/network/interfaces
        sudo echo "wpa-psk \"$psk"\" >> /etc/network/interfaces

        sudo chmod 644 /etc/network/interfaces

       clear
        msg_redes_ok
        msg_reboot
        sleep 3
        

        else

        msg_sincambios
        sleep 3
       
    fi      
}

