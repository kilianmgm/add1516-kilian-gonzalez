<center>***Kilian Manuel Gonz�lez Mart�n - 2� ASIR***</center> 



#Tareas programadas

#1. SO OpenSUSE

##1.1 Configuraci�n de la m�quina

Configurar el equipo GNU/Linux OpenSUSE 13.2 con:
* IP: 172.18.11.51 
* M�scara de red: 255.255.0.0
* Gateway: 172.18.0.1
* Servidor DNS: 8.8.4.4
* Nombre de equipo: gonzalez3
* Nombre de dominio: martin


Adem�s tambi�n:
* Instalar openssh-server para que el profesor pueda acceder de forma remota.
![](./1.png)

Capturar im�gen de la configuraci�n del equipo:

    uname -a
    hostname -a
    hostname -d
    ip a
    route -n
    blkid
    
![](./2.png)

##1.2 Tarea diferida

* Vamos a programar una tarea diferida (comando `at`) para apagar el equipo.
* Compruebo que at est� en funcionamiento
![](./3.png)
* El comando para apagar el sistema es `shutdown`.

![](./4.png)

> * Si el usuario no tuviera permisos para ejecutar at, consultar los ficheros:
>     * `/etc/at.deny`
>     * `/etc/at.allow`

##1.3 Tarea peri�dica

* Antes de usar cron comprobamos que est� instalado.
![](./5.png)
* Programar una tarea peri�dica (crontab) que nos mostrar� un mensaje en pantalla.
* Para programar una tarea peri�dica tenemos estas formas:
    * Los usuarios usan el comando `crontab`  para programar sus tareas.
    * El usuario root usa el fichero `/etc/crontab` para programar las tareas del sistema. 
* Ejemplo de script que muestra un mensaje de aviso:

```
    #!/bin/sh
    # Mostrar mensaje en pantalla
    DISPLAY=:0
    export DISPLAY
    zenity --info --text="�Que la fuerza te acompa�e!"
```
* Instalo el zenity
 ![](./6.png)
* Para la ejecuci�n de la tarea cada minuto introducimos en /var/spool/cron/tabs/aitor los par�metos para que sea interpretado y la ruta donde est� ubicado el script.
![](./7.png)

* Comprobaci�n del contenido del script y la tarea en funcionamiento.
![](./8.png)

> * NOTA: para poder llevar a cabo esta tarea hay que instalar zenity previamente.

##1.4 Tarea as�ncrona

* Vamos a programar una tarea as�ncrona para realizar una copia de backup.
* Podemos usar el comando `tar` dentro de un script para realizar la 
  copia de los ficheros del usuario en una zona de backup.
    * Directorio de datos `/home/nombre-alumno1`.
    * Directorio para guardar el backup `/var/backup-XX/nombre-alumno1`.
   

* Primero que nada, comprobamos el contenido del script y lo ejecutamos.
![] ![](./9.png)
 ![](./10.png)
 ![](./11.png)

* Seguidamente nos vamos al directorio donde guardaremos el backup y observamos que ha funcionado.
![](./12.png)

> Para definir una tarea as�ncrona ponemos el script de ejecuci�n en alguno 
de los directorios siguientes:
> * /etc/cron.hourly

> * /etc/cron.daily
![](./13.png)
> * /etc/cron.weekly
> * /etc/cron.monthly



#2. Windows7

##2.1 Configuraci�n de la m�quina

Configurar m�quina *Windows 7 Professional* con:
* IP: 172.18.11.11 


![](./14.png)


##2.2 Tarea diferida

* Vamos a programar una tarea diferida para que nos muestre un mensaje 
de �nimo en pantalla.
* En Windows 7 para abrir el programador de tareas hacemos 
`Panel de control -> Herramientas administrativas -> Programador de tareas`.

* Creamos la tarea b�sica de tipo mostrar un mensaje.
![](./15.png)
* Comprobaci�n de la realizaci�n de la tarea:
![](./16.png)

##2.3 Tarea peri�dica

* Vamos a programar una tarea peri�dica para apagar el equipo.
* El comando para apagar el sistema es `shutdown`.

> * `shutdown /?`: Muestra la ayuda del comando.
> * `shutdown /s`: Programar un apagado.

* Creamos la tarea b�sica de tipo iniciar un programa.
![](./17.png)
* Comprobaci�n de la realizaci�n de la tarea:
![](./18.png)

##2.4 Tarea as�ncrona

* Vamos a programar una tarea as�ncrona para realizar una copia de backup.
* Como ejemplo podemos crear un fichero `backup.bat` con comandos del tipo `xcopy`,
para copiar los documentos del usuario en una zona de backup.
    * Directorio de datos `c:\Users\nombre-alumno1\`.
    * Directorio para guardar el backup `c:\backup-XX\nombre-alumno1`.
    ![](./19.png)
    


* Comprobaci�n de la realizaci�n de la tarea:
![](./20.png)
![](./21.png)

