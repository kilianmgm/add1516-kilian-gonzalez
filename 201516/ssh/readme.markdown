#Kilian Manuel González Martín
#0. Acceso remoto SSH

##0.1 Introducción


* Vamos a necesitar las siguientes 3 MVs:
    1. Un servidor GNU/Linux OpenSUSE, con IP estática (172.18.11.53).
    1. Un cliente GNU/Linux OpenSUSE, con IP estática (172.18.11.54).
    1. Un cliente Windows7, con IP estática (172.18.11.13).
 

##0.2 Configuración de red
Para configurar la red en OpenSUSE lo más cómodo es usar el interfaz gráfico `yast`.
* Vamos a `yast -> Ajustes de red`
* En la pestaña `Vista resumen` pondremos:
    * IP estática
    * Máscara de red
    * Nombre de host
    * Pulsamos en `siguiente`.
    

* En la pestaña `Nombres de hosts` pondremos:
    * Nombre de host
    * Nombre de dominio
    * Asignar nombre a bucle local. Esto modifica el fichero `/etc/hosts` por nosotros.
    * Servidor DNS
   
* En la pestaña `Encaminamiento` pondremos:
    * La IP de l apuerta de enlace
    * Elegimos el dispositivo de red asociado a la puerta de enlace.  
    



#1. Preparativos

##1.1 Servidor SSH
* Configurar el servidor GNU/Linux con siguientes valores:
    * Nombre de usuario: kilian
    * Clave del usuario root: 43833998t
    * Nombre de equipo: ssh-server
    * Nombre de dominio: martin
    * ![1.png](./images/P1/1/1.png "")
    * ![2.png](./images/P1/1/2.png "")
    * ![3.png](./images/P1/1/3.png "")  
* Añadir en /etc/hosts los equipos ssh-client1 y ssh-client2-11 

![4.png](./images/P1/1/4.png "")

* Para comprobar los cambios ejecutamos varios comandos. Capturar imagen:
```
ip a               (Comprobar IP y máscara)
route -n           (Comprobar puerta de enlace)
host www.google.es (Comprobar el servidor DNS)
lsblk              (Comprobar particiones)
blkid              (Comprobar UUID de la instalación)
``` 
![5.png](./images/P1/1/5.png "")

![6.png](./images/P1/1/6.png "")

* Crear los siguientes usuarios en ssh-server:
    * primer-apellido-del-alumno1
    * primer-apellido-del-alumno2
    * primer-apellido-del-alumno3
    * primer-apellido-del-alumno4


![7.png](./images/P1/1/7.png "")

##1.2 Clientes GNU/Linux
* Configurar el cliente1 GNU/Linux con los siguientes valores:
    * Nombre de usuario: nombre-del-alumno
    * Clave del usuario root: DNI-del-alumno
    * Nombre de equipo: ssh-client1
    * Nombre de dominio: segundo-apellido-del-alumno
    * ![1.png](./images/P1/2/1.png "")
    * ![2.png](./images/P1/2/2.png "")
    * ![3.png](./images/P1/2/3.png "")
* Añadir en /etc/hosts el equipo ssh-server, y ssh-client2-XX.
![4.png](./images/P1/2/4.png "")
* Comprobar haciendo ping a ambos equipos. 
![5.png](./images/P1/2/5.png "")
![6.png](./images/P1/2/6.png "")

##1.3 Cliente Windows
* Instalar software cliente SSH en Windows (PuTTY)
* Configurar el cliente2 Windows con los siguientes valores:
    * Nombre de usuario: nombre-del-alumno
    * Clave del usuario administrador: DNI-del-alumno
    * Nombre de equipo: ssh-client2-XX
![1.png](./images/P1/3/1.png "")
![2.png](./images/P1/3/2.png "")
* Añadir en `C:\Windows\System32\drivers\etc\hosts` el equipo ssh-server y ssh-client1.
![3.png](./images/P1/2/3.png "")
* Comprobar haciendo ping a ambos equipos. 
![4.png](./images/P1/2/4.png "")

#2 Instalación del servicio SSH

* Instalar el servicio SSH en la máquina ssh-server

    * Desde terminal `zypper install openssh`, instala el paquete OpenSSH.
    ![1.png](./images/P2/1.png "")

> * Los ficheros de configuración del servicio se guardan en /etc/ssh.


##2.1 Comprobación

* Desde el propio **ssh-server**, verificar que el servicio está en ejecución.
```
    systemctl status sshd  (Esta es la forma de comprobarlo en *systemd*) 
    ps -ef|grep sshd       (Esta es la forma de comprobarlo mirando los procesos del sistema)
```
 ![2.png](./images/P2/2.png "")


* Para poner el servicio enable: `systemctl enable sshd`, si no lo estuviera.
 ![3.png](./images/P2/3.png "")
 ![4.png](./images/P2/4.png "")
 ![5.png](./images/P2/5.png "")
* `netstat -ntap`: Comprobar que el servicio está escuchando por el puerto 22

 ![6.png](./images/P2/6.png "")


##2.2 Primera conexión SSH desde cliente

* Vamos a comprobar el funcionamiento de la conexión SSH desde cada cliente usando el usuario *gonzalez1*. 

* Desde el **ssh-client1** nos conectamos mediante `ssh gonzalez@ssh-server`. Capturar imagen del intercambio de claves que se produce en el primer proceso de conexión SSH.
![1.png](./images/2-2_3/1.png "")


* Comprobar contenido del fichero `$HOME/.ssh/known_hosts` en el equipo ssh-client1. OJO si el prompt
pone *ssh-server* están el el servidor, y si pone *ssh-client1* están el el cliente1.

![4.png](./images/2-2_3/4.png "")

* ¿Te suena la clave que aparece? Es la clave de identificación de la máquina ssh-server.
* Una vez llegados a este punto deben de funcionar correctamente las conexiones SSH desde los clientes. Seguimos.

##2.3 ¿Y si cambiamos las claves del servidor?
* Confirmar que existen los siguientes ficheros en `/etc/ssh`, 
Los ficheros `ssh_host*key` y `ssh_host*key.pub`, son ficheros de clave pública/privada
que identifican a nuestro servidor frente a nuestros clientes:

```
-rw-r--r-- 1 root root 136156 ago 24  2012 moduli
-rw-r--r-- 1 root root   1667 sep 12  2012 ssh_config
-rw-r--r-- 1 root root   2487 dic 27  2013 sshd_config
-rw------- 1 root root    672 dic 27  2013 ssh_host_dsa_key
-rw-r--r-- 1 root root    601 dic 27  2013 ssh_host_dsa_key.pub
-rw------- 1 root root    227 dic 27  2013 ssh_host_ecdsa_key
-rw-r--r-- 1 root root    173 dic 27  2013 ssh_host_ecdsa_key.pub
-rw------- 1 root root    528 dic 27  2013 ssh_host_key
-rw-r--r-- 1 root root    333 dic 27  2013 ssh_host_key.pub
-rw------- 1 root root   1675 dic 27  2013 ssh_host_rsa_key
-rw-r--r-- 1 root root    393 dic 27  2013 ssh_host_rsa_key.pub
```

![5.png](./images/2-2_3/5.png "")

* Modificar el fichero de configuración SSH (`/etc/ssh/sshd_config`) para dejar una única línea: 
`HostKey /etc/ssh/ssh_host_rsa_key`. Comentar el resto de líneas con configuración HostKey. 
Este parámetro define los ficheros de clave publica/privada que van a identificar a nuestro
servidor. Con este cambio decimos que sólo vamos a usar las claves del tipo RSA.
![6.png](./images/2-2_3/6.png "")

* Generar nuevas claves de equipo en **ssh-server**. Como usuario root ejecutamos: 
`ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key`. Estamos cambiando o volviendo a 
generar nuevas claves públicas/privadas para la identificación de nuestro servidor.

![7.png](./images/2-2_3/7.png "")

* Reiniciar el servicio SSH: `systemctl restart sshd`.
![8.png](./images/2-2_3/8.png "")

* Comprobar qué sucede al volver a conectarnos desde los dos clientes, usando los 
usuarios 1er-apellido-alumno2 y 1er-apellido-alumno1. ¿Qué sucede?
![9.png](./images/2-2_3/9.png "")
-
![10.png](./images/2-2_3/10.png "")
-
![11.png](./images/2-2_3/11.png "")
-
![12.png](./images/2-2_3/12.png "")
-
![13.png](./images/2-2_3/13.png "")


#3. Personalización del prompt Bash
    Personalizar Bash según la documentación, para cambiar el color cuando tenemos activa una sesión SSH.

    Por ejemplo, podemos añadir las siguientes líneas al fichero de configuración del usuario1 en la máquina servidor (Fichero /home/1er-apellido-alumno1/.bashrc)


#Cambia el prompt al conectarse vía SSH

if [ -n "$SSH_CLIENT" ]; then
  PS1="AccesoRemoto_\e[32;40m\u@\h: \w\a\$"
else
  PS1="\[$(ppwd)\]\u@\h:\w>"
fi

![14.png](./images/2-2_3/14.png "")
```

* Comprobar funcionamiento de la conexión SSH desde cada cliente.
```
![15.png](./images/2-2_3/15.png "")
![16.png](./images/2-2_3/16.png "")
![17.png](./images/2-2_3/17.png "")
```
#4. Autenticación mediante claves públicas



El objetivo de este apartado es el de configurar SSH para poder acceder desde el cliente1,
usando el usuario4 sin poner password, pero usando claves pública/privada.

Vamos a configurar la autenticación mediante clave pública para acceder con 
nuestro usuario personal desde el equipo cliente al servidor con el 
usuario 1er-apellido-alumno4.

* Vamos a la máquina cliente1. 
* ¡OJO! No usar el usuario root.

Capturar imágenes de los siguientes pasos:
* Iniciamos sesión con nuestro usuario *nombre-alumno* de la máquina ssh-client1.
* Ejecutamos `ssh-keygen -t rsa` para generar un nuevo par de claves para el 
usuario en `/home/nuestro-usuario/.ssh/id_rsa` y `/home/nuestro-usuario/.ssh/id_rsa.pub`.
```
![1.png](./images/P4/1.png "")

* Ahora vamos a copiar la clave pública (id_rsa.pub) del usuario (nombre-de-alumno)de la máquina cliente, 
al fichero "authorized_keys" del usuario *remoteuser4* en el servidor. Hay dos formas de hacerlo: 
    * Modo 1. Usando un comando específico para ello `ssh-copy-id remoteuser4@ssh-server`
    
    ![3.png](./images/P4/3.png "")
   
* Comprobar que ahora podremos acceder remotamente, sin escribir el password desde el cliente1.
     ![5.png](./images/P4/5.png "")

#5. Uso de SSH como túnel para X



* Instalar en el servidor una aplicación de entorno gráfico (APP1) que no esté en los clientes. 
Por ejemplo Geany. Si estuviera en el cliente entonces buscar otra aplicación o desinstalarla en el cliente.

![1.png](./images/P5/1.png "")


* Modificar servidor SSH para permitir la ejecución de aplicaciones gráficas, desde los clientes. 
Consultar fichero de configuración `/etc/ssh/sshd_config` (Opción `X11Forwarding yes`)

![3.png](./images/P5/3.png "")
* Comprobar funcionamiento de APP1 desde cliente1.
Por ejemplo, con el comando `ssh -X remoteuser1@ssh-server`, podemos conectarnos de forma 
remota al servidor, y ahora ejecutamos APP1 de forma remota.
> **OJO**: El parámetro es `-X` en mayúsculas, no minúsculas
![2.png](./images/P5/2.png "")
#6. Aplicaciones Windows nativas

Podemos tener aplicaciones Windows nativas instaladas en ssh-server mediante el emulador WINE.
* Instalar emulador Wine en el ssh-server.
![1.png](./images/P6/1.png "")
* Ahora podríamos instalar alguna aplicación (APP2) de Windows en el servidor SSH 
usando el emulador Wine. O podemos usar el Block de Notas que viene con Wine: wine notepad.

* Comprobar el funcionamiento de APP2 en ssh-server.

![2.png](./images/P6/2.png "")
![3.png](./images/P6/3.png "")
* Comprobar funcionamiento de APP2, accediendo desde ssh-client1.
![4.png](./images/P6/4.png "")
![5.png](./images/P6/5.png "")
> En este caso hemos conseguido implementar una solución similar a RemoteApps usando SSH.

#7. Restricciones de uso
Vamos a modificar los usuarios del servidor SSH para añadir algunas restricciones de uso del servicio.

##7.1 Sin restricción (tipo 1)
Usuario sin restricciones:

* El usuario 1er-apellido-alumno1, podrá conectarse vía SSH sin restricciones.
* En principio no es necesario tocar nada.

##7.2 Restricción total (tipo 2)
Vamos a crear una restricción de uso del SSH para un usuario:

* En el servidor tenemos el usuario remoteuser2. Desde local en el servidor podemos usar 
sin problemas el usuario.
* Vamos a modificar SSH de modo que al usar el usuario por ssh desde los clientes tendremos permiso denegado.

Capturar imagen de los siguientes pasos:
* Consultar/modificar fichero de configuración del servidor SSH (`/etc/ssh/sshd_config`) para 
restringir el acceso a determinados usuarios. Consultar las opciones `AllowUsers`, `DenyUsers`. 

![1.png](./images/P7/1.png "")
Más información en: `man sshd_config` y en el Anexo de este enunciado.
* Comprobarlo la restricción al acceder desde los clientes.
![2.png](./images/P7/2.png "")
##7.3 Restricción en las máquinas (tipo 3)
Vamos a crear una restricción para que sólo las máquinas clientes con las IP's 
autorizadas puedan acceder a nuestro servidor.

* Consultar los ficheros de configuración /etc/hosts.allow y /etc/hosts.deny

**No funciona**
```
# /etc/hosts.allow
# Permitir acceso a las IP's conocidas
sshd : 172.19.255.53/255.255.255.0 : ALLOW
```

```
# /etc/hosts.deny
# Denegar acceso al servicio SSH a todas las IP's 
sshd : ALL EXCEPT LOCAL
```

* Modificar configuración en el servidor para denegar accesos de todas las máquinas, excepto nuestros clientes.
* Comprobar su funcionamiento.

##7.4 Restricción sobre aplicaciones (tipo 4)
Vamos a crear una restricción de permisos sobre determinadas aplicaciones.

* Usaremos el usuario remoteuser4
* Crear grupo remoteapps
* Incluir al usuario en el grupo.
![8.png](./images/P7/8.png "")
* Localizar el programa APP1. Posiblemente tenga permisos 755.

![8.png](./images/P7/9.png "")
* Poner al programa APP1 el grupo propietario a remoteapps
![8.png](./images/P7/10.png "")
* Poner los permisos del ejecutable de APP1 a 750. Para impedir que los que no pertenezcan al grupo puedan ejecutar el programa.

![8.png](./images/P7/11.png "")
* Comprobamos el funcionamiento en el servidor.
![8.png](./images/P7/12.png "")
* Comprobamos el funcionamiento desde el cliente.
![8.png](./images/P7/13.png "")


