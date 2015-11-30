

#2. SO OpenSUSE

Vamos a necesitar 2 máquinas GNU/Linux:

* MV OpenSUSE, donde instalamos el servicio NFS (directorios compartidos por red)
    * Como nombre de esta máquina usar `nfs-server-XX`. Modificar el fichero /etc/hostname, 
    para establecer el nombre de máquina, y el fichero /etc/hosts.
    * IP estática 172.18.XX.52
    * VirtualBox Red en Modo Puente
    
    ![](./suse/2.1/3.png)
* MV OpenSUSE, donde instalaremos el cliente NFS.
    * Como nombre de esta máquina usar `nfs-client-XX`
    * IP estática 172.18.XX.62
    * VirtualBox Red en Modo Puente
    
    ![](./suse/2.1/6.png)

> * /ETC/HOSTS: Por comodidad podemos configurar el fichero /etc/hosts del cliente y servidor, 
añadiendo estas líneas:
> ```
> 172.18.XX.52 nfs-server-XX.apellido-alumno   nfs-server-XX
> ```
![](./suse/2.1/1.png)
> ```
> 172.18.XX.62 nfs-client-XX.apellido-alumno   nfs-client-XX
> ```
![](./suse/2.1/4.png)
>
>* La configuración de los interfaces de red, servidores de nombres, etc. la podemos hacer en YAST.

##2.1 Servidor NFS


* Instalar servidor NFS por Yast.
![](./suse/2.2/1.png)
![](./suse/2.2/2.png)
![](./suse/2.2/3.png)
![](./suse/2.2/6.png)

* Crear las siguientes carpetas/permisos:
    * `/var/export/public`, usuario y grupo propietario `nobody:nogroup`
    * `/var/export/private`, usuario y grupo propietario `nobody:nogroup`, permisos 770
    ![](./suse/2.2/4.png)
* Vamos configurar el servidor NFS de la siguiente forma:
    * La carpeta `/var/export/public`, será accesible desde toda la red en modo lectura/escritura.
    * La carpeta `/var/export/private`, sea accesible sólo desde la IP del cliente, sólo en modo lectura.
* Para ello usaremos o Yast o modificamos el fichero `/etc/exports` añadiendo las siguientes líneas:
```
    ...
    /var/export/public *(rw,sync,subtree_check)
    /var/export/private ip-del-cliente/32(ro,sync,subtree_check)
    ...
```
![](./suse/2.2/7.png)
![](./suse/2.2/8.png)
> OJO: NO debe haber espacios entre la IP y abrir paréntesis.

* Para iniciar y parar el servicio NFS, usaremos Yast o `systemctl`. Si al iniciar 
el servicio aparecen mensaje de error o advertencias, debemos resolverlas. 
Consultar los mensajes de error del servicio.

> [Enlace de interés](http://www.unixmen.com/setup-nfs-server-on-opensuse-42-1/)

* Para comprobarlo, `showmount -e localhost`. Muestra la lista de recursos exportados por el servidor NFS.    

    ![](./suse/2.3/6.png)

##2.2 Cliente NFS
En esta parte, vamos a comprobar que las carpetas del servidor son accesibles desde el cliente. 
Normalmente el software cliente NFS ya viene preinstalado pero si tuviéramos que instalarlo en 
OpenSUSE `zypper in nfs-common`.

Comprobar conectividad desde cliente al servidor:
* `ping ip-del-servidor`: Comprobar la conectividad del cliente con el servidor. Si falla hay que revisar las configuraciones de red.

    ![](./suse/2.3/1.png)
* `nmap ip-del-servidor -Pn`: nmap sirve para escanear equipos remotos, y averiguar que servicios están ofreciendo al exterior. Hay que instalar el paquete nmap, porque normalemente no viene preinstalado.
![](./suse/2.3/6.png)
    
* `showmount -e ip-del-servidor`: Muestra la lista de recursos exportados por el servidor NFS.

    ![](./suse/2.3/5.png)

En el cliente vamos a montar y usar cada recurso compartido. Veamos ejemplo con public.
* Crear la carpeta /mnt/remoto/public
* `mount.nfs ip-del-servidor:/var/export/public /mnt/remoto/public` montar el recurso
* `df -hT`, y veremos que los recursos remotos están montados en nuestras carpetas locales.

![](./suse/2.3/10.png)

> Para montar los recursos NFS del servidor Windows haremos: 
> * `showmount -e ip-del-servidor`: Para consultar los recursos que exporta el servidor.
> * `mount.nfs ip-del-servidor:/public /mnt/remoto/windows`: Para montar el recurso public del servidor.
>
> Otro ejemplo:
> * `mount.nfs ip-servidor-nfs-windows:/C/export/public /mnt/remoto/windows`
>
> Para comprobar si el recurso está montado usaremos: `df -hT` o `mount`.
>![](./suse/1.png)

* Ahora "podemos crear carpetas/ficheros dentro del recurso public, 
pero sólo podremos leer lo que aparezca en private". Comprobarlo.

--No es posible comprobarlo ya que no dispongo de permisos debido a un problema en la parte de windows. 

*    ![](./suse/2.3/11.png)

##2.3. Montaje automático
> Acabamos de acceder a recursos remotos, realizando un montaje de forma manual (comandos mount/umount). 
Si reiniciamos el equipo cliente, podremos ver que los montajes realizados de forma manual 
ya no están. Si queremos volver a acceder a los recursos remotos debemos repetir el proceso, 
a no ser que hagamos una configuración permanente o automática.

Para configurar acciones de montaje autoḿaticos cada vez que se inicie el equipo en
OpenSUSE usamos Yast o bien modificamos la configuración del fichero `/etc/fstab`. Comprobarlo.

* Incluir contenido del fichero `/etc/fstab` en la entrega.
![](./suse/2.3/13.png)

#3. Preguntas

* Nuestro cliente GNU/Linux NFS puede acceder al servidor Windows NFS? Comprobarlo.
* Si, ![](./suse/1.png)
* ¿Nuestro cliente Windows NFS podría acceder al servidor GNU/Linux NFS? Comprobarlo.


* Fijarse en los valores de usuarios propietario y grupo propietario de los ficheros que se guardan en el servidor, cuando los creamos desde una conexión cliente NFS.
![](./suse/2.3/12.png)

