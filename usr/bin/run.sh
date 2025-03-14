#!/bin/bash

# Obtiene la ubicación del script
DIR="$(dirname "$(readlink -f "$0")")"

# Define la ruta a la carpeta data dentro del AppImage
DATA_DIR="$DIR/usr/share/data"

# Crea un enlace simbólico a la carpeta data en el directorio del ejecutable
if [ -d "$DATA_DIR" ]; then
  ln -sf "$DATA_DIR" "$DIR/data"
else
  echo "Error: la carpeta data no existe en $DATA_DIR"
  exit 1
fi

# Ejecuta doukutsu-rs.elf
if [ -f "$DIR/doukutsu-rs.elf" ]; then
  "$DIR/doukutsu-rs.elf"
  EXIT_CODE=$?
else
  echo "Error: doukutsu-rs.elf no se encuentra en $DIR"
  exit 1
fi

# Elimina el enlace simbólico al salir
if [ -L "$DIR/data" ]; then
  rm "$DIR/data"
fi

exit $EXIT_CODE
