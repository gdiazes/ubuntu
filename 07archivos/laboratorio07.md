
#  LABORATORIO 07: ADMINISTRACIÓN, SEGURIDAD Y SISTEMAS DE ARCHIVOS EN LINUX

## I. EL ENTORNO VIRTUAL (VMware Specialist View)
Antes de entrar al sistema operativo, debemos entender los archivos que lo sostienen en el hipervisor.

*   **Archivos `.lck` (Bloqueos):** Indican que la VM está encendida. **Cuándo usar:** Para diagnosticar por qué una VM no arranca (si están presentes con la VM apagada, hay que borrarlos).
*   **Archivos `.vmdk`:** El disco duro virtual. Si es "Split", verás varios archivos `-s00X.vmdk`. **Cuándo usar:** Para migraciones de almacenamiento.
*   **Archivo `.vmx`:** La configuración de hardware. **Cuándo usar:** Para editar manualmente parámetros no disponibles en la interfaz gráfica.
*   **Archivo `.vmsd`:** El historial de Snapshots.

---

## II. SISTEMA DE ARCHIVOS Y ENLACES (Deep Dive)
Linux no solo guarda nombres, guarda **Inodos** (punteros a sectores físicos).

### 1. Enlaces Duros (Hard Links) vs Blandos (Soft Links)
*   **Enlace Duro (`ln`):** Apunta al mismo sector del disco. Si el original muere, los datos sobreviven.
*   **Enlace Blando (`ln -s`):** Es un acceso directo (8 bytes de texto con la ruta). Si el original muere, el enlace se pone **rojo** (roto).
*   **Segunda columna de `ls -l`:** Indica el número de enlaces duros. En directorios, es `2 + número de subcarpetas`.

### 2. Comandos de Rastreo
*   **`ls -i`:** Muestra el número de inodo. **Cuándo usar:** Para verificar si dos archivos son realmente el mismo dato físico.
*   **`find . -inum [ID]`:** Busca todos los nombres que apuntan a ese dato. **Cuándo usar:** Para saber cuántos "alias" tiene un archivo antes de borrarlo.

---

## III. CREACIÓN DE ARCHIVOS DE GRAN TAMAÑO (Scripting)
Para pruebas de estrés o cuotas de disco, usamos el comando `fallocate` (rápido) o `dd` (físico).

**Script recomendado:**
```bash
#!/bin/bash
# Crear un archivo de 5GB instantáneamente
fallocate -l 5G archivo_test.dat
```
*   **Cuándo usar `fallocate`:** Para reservar espacio inmediato sin carga de CPU.
*   **Cuándo usar `dd`:** Para probar la velocidad de escritura real del disco.

---

## IV. SEGURIDAD Y HASHING (`/etc/shadow`)
Linux no guarda contraseñas, guarda "huellas digitales" matemáticas (Hashes).

*   **Identificadores de Algoritmo:**
    *   **`$y$` (Yescrypt):** Estándar moderno (Ubuntu 22.04+). Resistente a ataques por GPU.
    *   **`$6$` (SHA-512):** Estándar clásico robusto.
*   **Cuándo revisar:** Durante auditorías de seguridad para asegurar que no existan usuarios con algoritmos antiguos como `$1$` (MD5).

---

## V. GESTIÓN AVANZADA DE ACCESOS (El Corazón de la Guía)

### 1. Permisos Octales (El método 4-2-1)
Basado en la suma de valores: **4 (Read), 2 (Write), 1 (Execute)**.

| Valor | Texto | Uso recomendado |
| :--- | :--- | :--- |
| **755** | `rwxr-xr-x` | **Scripts y carpetas públicas.** El dueño hace todo, otros solo leen/entran. |
| **644** | `rw-r--r--` | **Documentos estándar.** Nadie ejecuta, solo el dueño edita. |
| **600** | `rw-------` | **Archivos sensibles (ej: llaves SSH).** Privacidad total. |
| **777** | `rwxrwxrwx` | **¡PROHIBIDO!** Excepto para pruebas temporales de permisos. |

*   **Cuándo usar `chmod [num]`:** Cuando quieres aplicar una política de seguridad rápida y estándar.

### 2. Grupos y Propiedad
*   **`groupadd` / `usermod -aG`:** Para crear equipos de trabajo.
*   **`chown` / `chgrp`:** Para cambiar quién es el dueño legal del archivo.
*   **Cuándo usar:** En entornos colaborativos donde varios usuarios necesitan editar el mismo proyecto.

### 3. ACL (Access Control Lists)
Es la excepción a la regla. Permite dar permisos a un usuario extra sin cambiar el dueño ni el grupo.
*   **Comando:** `setfacl -m u:usuario:rwx archivo`
*   **Indicador visual:** Un símbolo **`+`** al final de los permisos en `ls -l`.
*   **Cuándo usar:** Cuando la estructura de grupos es demasiado rígida y necesitas dar un permiso "especial" a una sola persona.

---

## VI. EDITORES DE TEXTO: ¿CUÁL ELEGIR?

1.  **Nano:** Simple, atajos visibles (`Ctrl+O`). **Cuándo usar:** Ediciones rápidas y sencillas de configuración.
2.  **Vim:** Profesional, 3 modos (Comando, Inserción, Última línea). **Cuándo usar:** Programación avanzada y administración remota masiva (es extremadamente rápido una vez dominado).

---

###  RESUMEN DE DECISIÓN PARA EL ADMINISTRADOR:

| Si necesitas... | Usa el comando... | Énfasis técnico |
| :--- | :--- | :--- |
| **Cambiar permisos básicos** | `chmod` | Usa el formato octal para mayor rapidez. |
| **Dar permiso a un tercero** | `setfacl` | No ensucies la estructura de grupos, usa ACL. |
| **Crear un equipo de trabajo** | `groupadd` | Combínalo con permisos `660` o `770`. |
| **Rastrear un archivo borrado** | `find -inum` | Los enlaces duros mantienen los sectores vivos. |
| **Verificar seguridad** | `cat /etc/shadow` | Busca el `$y$` para garantizar hashing moderno. |

