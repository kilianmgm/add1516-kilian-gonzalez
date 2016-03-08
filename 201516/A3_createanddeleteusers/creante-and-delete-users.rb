#!/usr/bin/ruby
# encoding: utf-8
#Autor: Kilian Manuel González Martín

user=`whoami`

if user != "root\n"
	puts "** Usuario sin permiso porfavor ejecuta como root **"
	exit
end

file=`cat userslist.txt`
filas=file.split("\n")

filas.each do |linea|
	datos=linea.split(":")
	if datos[2] == ""
		puts "El usuario #{datos[0]} tiene el campo email vacío"
	else
		if datos[4] == "add"
			system("useradd -m -s /bin/bash #{datos[0]}")
			puts "Se ha creado el usuario #{datos[0]}"
		else if datos[4] == "delete"
			system("userdel -r #{datos[0]}")
			puts "Se ha eliminado el usuario #{datos[0]}"
		end
	end
	end
end
