#!/usr/bin/ruby
# encoding: utf-8

user=`whoami`

if user != "root\n"
	puts "El usuario no es root"
	exit
end

file=`cat software-list.txt`
filas=file.split("\n")

system("apt-get update")
puts "----Se ha actualizado----"

filas.each do |linea|
	datos=linea.split(":")
	comprobar = system("dpkg -l #{datos[0]}|grep ii")
		
	if (datos[1] == "remove" or datos[1] == "r") and comprobar==true
		
		system("apt-get purge -y #{datos[0]}")
		puts "Se ha desinstalado: #{datos[0]}"
		
	elsif datos[1] == "install" or datos[1] =="i" and comprobar==false
			
		system("apt-get install -y #{datos[0]}")
		puts "Se ha instalado: #{datos[0]}"
			
	end
	
end
