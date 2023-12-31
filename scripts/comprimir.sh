#!/bin/bash

# Realiza las verificaciones de los archivos si existen o si estan vacios.

if [ ! -d ../imagenes ] || [ -z ../imagenes ]; then 
   echo "Todavia no generaste imagenes o la carpeta se encuentra vacia"

elif [ ! -d ./imagenes ] || [ -z ./imagenes ] ; then
   echo "Todavia no Descomprimiste los archivos o la carpeta se encuentra vacia"

elif [ ! -d ../imagenes_reducidas ] ; then
   echo "Todavia no procesaste las imagenes"

else
   
   NOMBRES=$(ls "./imagenes")
   if [ -e nom_img.txt ] ;then
     rm nom_img.txt
     touch nom_img.txt
   else
     touch nom_img.txt
   fi

   # Crea un archivo y guarda todos los nombres de las imagenes que se generaron.
   for IMG in $NOMBRES; do
     NOMBRE_ARCH=$(basename "$IMG")
     echo "${NOMBRE_ARCH%.*}" >> nom_img.txt
   done

   if [ -e nom_val.txt ] ;then
     rm nom_val.txt
     touch nom_val.txt
   else
     touch nom_val.txt
   fi
    
   # Crea un archivo y guarda los nombres validos.
   egrep  ^[A-Z][a-z]+,?[0-9]* nom_img.txt >> nom_val.txt

   if [ -e nom_a.txt ] ;then
     rm nom_a.txt
     touch nom_a.txt
   else
     touch nom_a.txt
   fi
   
   # Crea un archivo y guarda los nombres que terminen con "a".
   egrep  a,?[0-9]*$ nom_img.txt >> nom_a.txt
   
   # Comprime los archivos nom_img.txt, nom_val.txt, nom_a.txt y los directorios imagenes y imagenes_reducidas. Todo esto guardado en el archivo resultado_final.tar.gz. El archivo comprimido con gzip.
   tar zcvf resulado_final.tar.gz "./imagenes" "./nom_img.txt" "./nom_val.txt" "./nom_a.txt" "../imagenes_reducidas"
   echo "los archivos fueron procesados"
fi
exit 0
