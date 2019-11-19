#!/bin/bash
#1-Asegurar que el script lo ejecuta el superusuario
if [[ "${UID}" -eq 0 ]]
then
#2- Si el usuario no ha dado los valores necesarios dale ayuda 
	if [[ "$#" -gt 1 && "$#" -lt 3 ]]
	then
#3- El primer parametro es el nombre de usuario 
		nombre=$1
#4- El otro parametro son los comentarios 
		comentario=$2
#5- Genera la contraseña
		contra=$(openssl rand -base64 15)
#6- Crea el usuario con la contraseña
		useradd -m ${nombre} -p ${contra} -c ${comentario}
#7- Comprueba que el comando "useradd" se ha echo bien
		if [[ $? -eq 0 ]]
        then
                echo "Comprovación de que el usario se ha creado correctamente"
        else
                echo "ha ocurrido un error"
                exit 1
        fi
#8- Establece la contraseña
		echo "Establece tu contraseña"
		read -s contra2
		echo ${nombre}":"${contra2} | chpasswd

