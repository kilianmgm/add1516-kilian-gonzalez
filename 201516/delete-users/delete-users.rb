#!/usr/bin/ruby
# enconding: utf-8
# create by: Kilian Manuel González Martín

usuarios = `cat userlist.txt`

listaUsuarios = usuarios.split("\n")

listaUsuarios.each { |usu| syste("userdel -f #{usu}")}
