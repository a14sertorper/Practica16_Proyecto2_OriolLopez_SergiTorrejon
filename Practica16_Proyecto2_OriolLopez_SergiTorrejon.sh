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
#9- Comprueba que el comando "passwd" se ha echo bien 
        if [[ $? -eq 0 ]]
        then
                echo "Comprovación de que la contraseña se le ha dado correctamente"
        else
                echo "ha ocurrido un error"
                exit 1
        fi
#10- Fuerza a cambiar la contraseña en el primer LogIn 
        echo "En el primer Sign In se te obliga a cambiar la contraseña, porfavor introduzca la contraseña otra vez"
        read -s contra3
        passwd -e ${nombre}
        echo ${nombre}":"${contra3} | chpasswd
#11- Muestra el nombre, la contraseña y el host desde donde se ha creado el usuario 
        echo "El resumen final es:"
        echo "- El usuario es: "${nombre}
        echo "- La contraseña es: "${contra3}
        echo "- El Host desde donde se ha creado es: "${HOSTNAME}
	else
		echo "El numero de valores no son correctos, son dos valores, el primero sera el nombre de usuario y el segundo el comentario"
	fi
else
        echo "No puedes ejecutar este script, intentalo mas tarde con el usuario root"
fi
