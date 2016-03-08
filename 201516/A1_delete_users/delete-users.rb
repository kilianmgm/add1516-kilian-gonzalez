#!/usr/bin/ruby
# enconding: utf-8
# create by: Kilian Manuel González Martín

usuarios = `cat userslist.txt`

listaUsuarios = usuarios.split("\n")

listaUsuarios.each do |usuario|
	system("userdel -r #{usuario}")
	puts "Se ha borrado el usuario: #{usuario}"
end
