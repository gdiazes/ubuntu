#!/bin/bash

NOMBRE_ARCHIVO="archivo_5gigas.dat"
TAMANO="5G"

echo "--- Generador de archivo de 5GB ---"

# MÉTODO 1: fallocate (Instantáneo)
# Es el más eficiente porque reserva los bloques en el disco sin escribir ceros.
echo "Usando fallocate para crear $NOMBRE_ARCHIVO..."
fallocate -l $TAMANO $NOMBRE_ARCHIVO

# Verificar el resultado
if [ $? -eq 0 ]; then
    echo "¡Éxito! Archivo creado."
    ls -lh $NOMBRE_ARCHIVO
else
    echo "Error: ¿Tienes suficiente espacio en disco?"

    # MÉTODO 2: dd (Alternativa si fallocate no funciona)
    # Este método escribe ceros físicamente, tardará un poco más.
    echo "Intentando método alternativo con dd..."
    dd if=/dev/zero of=$NOMBRE_ARCHIVO bs=1G count=5
fi
