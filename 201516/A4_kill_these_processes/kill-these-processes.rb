#!/usr/bin/ruby
# encoding: utf-8
#Autor: Kilian Manuel González Martín
require 'rainbow'

def check_root

	user=`whoami`
	if user != "root\n"
		puts Rainbow("El usuario no es root").color(:red)
		exit
	end
	puts Rainbow("Correcto eres root").color(:green)
end 

def listar

	file=`cat processes-black-list.txt`
	filas=file.split("\n")
	return filas
	
end

def controlar_procesos(name, action)
	comprobar = system("ps -e| grep #{name} 1>/dev/null")
	
	if(action == "kill" or action =="k" or action =="remove" or action =="r") and comprobar==true
		`killall #{name}`
		puts Rainbow("_KILL_: Proceso #{name} eliminado").color(:green)
		
	elsif(comprobar==true)
		puts Rainbow("NOTICE: Proceso #{name} en ejecución").bg(:blue)
	end
end

check_root

filas = listar

system("touch state.running")

while(File.exist?('state.running')) do
	filas.each do |linea|
		datos=linea.split(":")
		controlar_procesos(datos[0],datos[1])
	end
	sleep(5) #esperar 5 segundos antes de volver a repetir el bucle
end


