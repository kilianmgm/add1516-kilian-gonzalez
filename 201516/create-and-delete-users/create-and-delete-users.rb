#! /usr/bin/ruby
# encoding: utf-8
#Autor: Kilian Manuel González Martín

#No funciona correctamente. Hago pruebas de un puts de la variable
#user y al ejecutarlo con el usuario root me devuelve el valor root
#pero nunca entra en la condicion de user == "root" lo demas creo que el planteamiento
#está bien y no se si lo podría haber hecho de otra forma.


user = `whoami`


if user=="root" then
	users = `cat userslist.txt`
	userslist = users.split("/n")
	
	userslist.each do |usu|
		campo = usu.split(":")
		nombre = campo[0]
		apellido = campo[1]
		email = campo[2]
		action = campo[3]
		
		if action=="delete"
			system ("#{nombre} delete")
		end
		
		if action== "add"
			system ("#{nombre} add")
		end
	end
end
	
if user!="root" then
	puts user
	puts "** Usuario sin permiso porfavor ejecutalo como root **"

end
