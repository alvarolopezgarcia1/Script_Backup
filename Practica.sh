#/bin/bash

#Este script crea una copia de seguridad del directorio arespaldar y borra los
#más antiguos de 30 días. Además redireccionamos la información a un .log.

#creamos el backup.log si no está creado
if [ ! -f ./backup.log ] 
  then
    echo "Backup.log no existe, se procede a su creación" >> ./backup.log 2>&1
fi
  

#comprobamos si existe el directorio a respaldar, en caso contrario finaliza el script
if [ ! -d ./arespaldar ] 
  then
    echo "El directorio arespaldar no existe" >> ./backup.log 2>&1
    exit 1 
fi

#si no exixte el directorio misbackups se crea

if [ ! -d ./misbackups ]
  then
  echo "No existía el directorio misbackups" >> ./backup.log 2>&1
  
   if mkdir ./misbackups >> ./backup.log 2>&1
   then 
     echo "Carpeta misbackups creada" >> ./backup.log 2>&1
  else
    exit 2
  fi
fi

#metemos la fecha en una variable

fecha=$(date '+%Y-%m-%d')

#avisamos de que comienza el backup 
echo "***********comenzando backup $fecha*************" >> ./backup.log 2>%

#creamos el backup con tar, confirmamos si se ha realizado con exito
#y borramos aquellos anteriores a 30 días con find.

if tar -zcvf misbackups/backup_$fecha.tar.gz arespaldar >> ./backup.log 2>&1 
  then
    find misbackups/backup* -mtime +30 -exec rm {} \;
	echo "creado backup_$fecha.tar.gz" >> ./backup.log 2>&1
  else
	echo "error backup_$fecha.tar.gz" >> ./backup.log 2>&1
fi




