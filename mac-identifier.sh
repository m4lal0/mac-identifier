#!/bin/bash

# By @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Color_Off='\033[0m'     # Text Reset

# Additional colors
LGray='\033[0;37m'      # Ligth Gray
DGray='\033[0;90m'      # Dark Gray
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan

# Bold
BBlack='\033[1;30m'     # Black
BGray='\033[1;37m'		# Gray
BRed='\033[1;31m'       # Red
BGreen='\033[1;32m'     # Green
BYellow='\033[1;33m'    # Yellow
BBlue='\033[1;34m'      # Blue
BPurple='\033[1;35m'    # Purple
BCyan='\033[1;36m'      # Cyan
BWhite='\033[1;37m'     # White

# Underline
UBlack='\033[4;30m'     # Black
UGray='\033[4;37m'		# Gray
URed='\033[4;31m'       # Red
UGreen='\033[4;32m'     # Green
UYellow='\033[4;33m'    # Yellow
UBlue='\033[4;34m'      # Blue
UPurple='\033[4;35m'    # Purple
UCyan='\033[4;36m'      # Cyan
UWhite='\033[4;37m'     # White

# Background
On_Black='\033[40m'     # Black
On_Red='\033[41m'       # Red
On_Green='\033[42m'     # Green
On_Yellow='\033[43m'    # Yellow
On_Blue='\033[44m'      # Blue
On_Purple='\033[45m'    # Purple
On_Cyan='\033[46m'      # Cyan
On_White='\033[47m'     # White

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BRed}Saliendo...${Color_Off}\n"
    tput cnorm; exit 0
}

function banner(){
    echo -e "\n\t${BGray}#################################################################"
    echo -e "\t#    _   _                                ______    ____        #"
    echo -e "\t#   / \_/ \                              /\__  _\  /\  __\`\     #"
    echo -e "\t#  /\      \       __        ___         \/_/\ \/  \ \ \/\ \    #"
    echo -e "\t#  \ \ \__\ \    / __ \     / ___\          \ \ \   \ \ \ \ \   #"
    echo -e "\t#   \ \ \_/\ \  /\ \L\.\_  /\ \__/           \_\ \__ \ \ \_\ \\  #"
    echo -e "\t#    \ \_\ \ _\ \ \__/.\_\ \ \____\          /\_____\ \ \____/  #"
    echo -e "\t#     \/_/ \/_/  \/__/\/_/  \/____/          \/_____/  \/___/   #"
    echo -e "\t#\t\t\t\t\t\t${BGray}    By ${BBlue}@m4lal0 ${BGray} #"
    echo -e "\t#################################################################${Color_Off}\n"
}

function helpPanel(){
    echo -e "${BGray}Script para identificar el fabricante de una dirección MAC.${Color_Off}"
    echo -e "\n${BGray}USO: \n\t ${BGreen}./mac-identifier ${LBlue}[${BRed}opción ${LGray}<argumento>${LBlue}]${Color_Off}"
    echo -e "\n${BGray}OPCIONES:${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-m ${LGray}<MAC> ${BRed}, --mac ${LGray}<MAC>${LBlue}] \t${BPurple}Dirección MAC.${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-f ${LGray}<FILE> ${BRed}, --file ${LGray}<FILE>${LBlue}] \t${BPurple}Leer un archivo con un listado de direcciones MAC.${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-o ${LGray}<FILE> ${BRed}, --output ${LGray}<FILE>${LBlue}] \t${BPurple}Guardar el resultado en un archivo.${Color_Off}"
    echo -e "\t${LBlue}[${BRed}-u , --update${LBlue}] \t\t${BPurple}Actualizar archivo OUI.${ColorOff}"
    echo -e "\t${LBlue}[${BRed}-h , --help${LBlue}] \t\t\t${BPurple}Mostrar este panel de ayuda.${Color_Off}"
    echo -e "\n${BGray}EJEMPLOS:${Color_Off}"
    echo -e "\t${BGreen}./mac-identifier -m 00:17:09:da:1b:6a ${BGray}- Identificar el fabricante de la dirección MAC.${Color_Off}"
    echo -e "\t${BGreen}./mac-identifier -f archivo.txt -o output.txt ${BGray}- Leer un archivo con direcciones MAC y guardar el resultado en un archivo.${Color_Off}\n"
}

function update(){
    test -f oui.txt 2>/dev/null
    if [ "$(echo $?)" == "0" ]; then
        echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BYellow}Actualizando..."
        rm oui.txt && wget http://standards-oui.ieee.org/oui/oui.txt > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ]; then
            echo -e "${LBlue}[${BGreen}✔${LBlue}] ${LGreen}OUI Actualizado.${Color_Off}\n"
            exit 0
        else
            echo -e "${LBlue}[${BRed}✘${LBlue}] ${BRed}Error al descargar el archivo automáticamente, descargalo manualmente desde: ${LBlue}http://standards-oui.ieee.org/oui/oui.txt${Color_Off}\n"
            exit 1
        fi
    else
        dependencie
        exit 0
    fi
}

function dependencie(){
    test -f oui.txt 2>/dev/null
    if [ "$(echo $?)" != "0" ]; then
        echo -e "\n${LBlue}[${BYellow}!${LBlue}] ${BGray}Archivo oui.txt no encontrado, descargando..."
        wget http://standards-oui.ieee.org/oui/oui.txt > /dev/null 2>&1
        if [ "$(echo $?)" == "0" ]; then
            echo -e "${LBlue}[${BGreen}✔${LBlue}] ${LGreen}Se ha descargado el archivo correctamente.${Color_Off}\n"
        else
            echo -e "${LBlue}[${BRed}✘${LBlue}] ${BRed}Error al descargar el archivo automáticamente, descargalo manualmente desde: ${LBlue}http://standards-oui.ieee.org/oui/oui.txt${Color_Off}\n"
            exit 1
        fi
    fi
}

function macIndentifier(){
    MAC=$(echo "$mac_address" | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)
    result=$(grep -i -A 1 ^$MAC ./oui.txt | cut -f 3)
    if [ "$result" ]; then
        echo -e "\n${BYellow}RESULTADO:${Color_Off}"
        echo -e "${BYellow}------------------------------------------------------------${Color_Off}"
        echo -e "\n\t${BGray}MAC: \t${BGreen}$mac_address${Color_Off}"
        echo -e "\t${BGray}VENDOR: ${BGreen}$result${Color_Off}\n"
        echo -e "${BYellow}------------------------------------------------------------${Color_Off}\n"
    else
        echo -e "\n\t${LBlue}[${BRed}✘${LBlue}] ${BRed}Información no encontrada.${Color_Off}\n"
        exit 1
    fi
}

function macOutput(){
    if [ "$result" ]; then
        echo "MAC: $mac_address" > $output
        echo "VENDOR: $result" >> $output
        echo -e "\n${LBlue}[${BGreen}✔${LBlue}] ${BGreen}Guardado el resultado en el archivo ${BGray}$output${Color_Off}\n"
    else
        echo "MAC: $mac_address" > $output
        echo "VENDOR: Información no encontrada." >> $output
    fi
}

function macFile(){
    echo -e "\n${BYellow}RESULTADO:${Color_Off}"
    echo -e "${BYellow}------------------------------------------------------------${Color_Off}\n"
    while IFS= read -r line
    do
        MAC=$(echo "$line" | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)
        result=$(grep -i -A 1 ^$MAC ./oui.txt | cut -f 3)
        if [ "$result" ]; then
            echo -e "\t${BGray}MAC: \t${BGreen}$line${Color_Off}"
            echo -e "\t${BGray}VENDOR: ${BGreen}$result${Color_Off}\n"
        else
            echo -e "\t${BGray}MAC: \t${BRed}$line${Color_Off}"
            echo -e "\t${BGray}VENDOR: ${BRed}Información no encontrada.${Color_Off}\n"
        fi
    done <<< $(cat $file)
}

function macOutputFile(){
    while IFS= read -r line
    do
        MAC=$(echo "$line" | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)
        result=$(grep -i -A 1 ^$MAC ./oui.txt | cut -f 3)
        if [ "$result" ]; then
            echo "MAC: $line" >> $output
            echo "VENDOR: $result" >> $output
            echo "" >> $output
        else
            echo "MAC: $line" >> $output
            echo "VENDOR: Información no encontrada." >> $output
            echo "" >> $output
        fi
    done <<< $(cat $file)
}

function identifier(){
    dependencie
    if [[ $mac_address && $file && $output ]]; then
        echo -e "\n${LBlue}[${BRed}✘${LBlue}] ${BRed}Parametros incorrectos.${Color_Off}\n"
        exit 1
    else
        if [ $output ]; then
            if [ $mac_address ]; then
                macIndentifier
                macOutput
                exit 0
            fi
            if [ $file ]; then
                macFile
                macOutputFile
                exit 0
            fi
        fi
        if [ $mac_address ]; then
            macIndentifier
            exit 0
        fi
        if [ $file ]; then
            macFile
            exit 0
        fi
    fi
}

arg=""
for arg; do
	delim=""
	case $arg in
		--help)		args="${args}-h";;
		--mac)	    args="${args}-m";;
        --file)	    args="${args}-f";;
        --update)	args="${args}-u";;
        --output)	args="${args}-o";;
        --*)        args="${args}*";;
		*) [[ "${arg:0:1}" == "-" ]] || delim="\""
        args="${args}${delim}${arg}${delim} ";;
	esac
done

eval set -- $args

declare -i parameter_counter=0; while getopts ":m:o:f:uh:" opt; do
    case $opt in
        m) mac_address=$OPTARG && let parameter_counter+=1 ;;
        o) output=$OPTARG && let parameter_counter+=1 ;;
        f) file=$OPTARG && let parameter_counter+=1 ;;
        u) update ;;
        h) helpPanel ;;
    esac
done

if [ $parameter_counter -eq 0 ]; then
    banner
    helpPanel
else
    banner
    identifier
fi