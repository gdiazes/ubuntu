# Guía de Laboratorio: Anatomía del FHS y Gestión de Enlaces

**Objetivo:** Explorar la jerarquía estándar de archivos (FHS), auditar archivos críticos de configuración y dominar la creación y comportamiento de enlaces físicos y simbólicos.

**Entorno:** Ubuntu Server VM.


---

## Actividad 1: Navegación Estructural y FHS
*Referencia teórica: Diapositivas 5 a 13 (Estándar FHS).*

1.  **Exploración de Raíz:** Ejecuta `ls -F /`. 
    *   **Tarea:** Identifica los directorios clave mencionados en la Diapositiva 7.
2.  **Rutas Absolutas vs. Relativas:** 
    *   Desde tu directorio personal (`~`), intenta moverte a `/var/www` usando una ruta **absoluta**.
    *   Luego, regresa a tu casa usando el atajo de la **tilde** (`cd ~`).
3.  **Auditoría de Binarios:** Compara el contenido de `/bin` y `/sbin`.
    *   **Pregunta:** Según la Diapositiva 8, ¿cuál es la diferencia de privilegios entre los comandos de estas dos carpetas?

## Actividad 2: El Núcleo de Configuración (/etc)
*Referencia teórica: Diapositivas 15 y 16 (Configuración del Sistema).*

1.  **Inspección de Usuarios:** Ejecuta `cat /etc/passwd`.
    *   **Tarea:** Busca tu nombre de usuario. Según la Diapositiva 16, ¿este archivo almacena solo humanos o también servicios del sistema?
2.  **Privilegios de Superusuario:** Intenta leer el archivo `/etc/shadow` (sin sudo).
    *   **Reflexión:** El error de "Permiso denegado" valida la importancia de `/etc/sudoers` (Diapositiva 16). ¿Qué herramienta usarías para editar este último archivo de forma segura?

## Actividad 3: Introspección del Kernel en Tiempo Real (/proc)
*Referencia teórica: Diapositivas 14 y 19 (Sistemas Virtuales).*

1.  **Lectura de CPU:** Ejecuta `cat /proc/cpuinfo`.
2.  **Estado de Memoria:** Ejecuta `cat /proc/meminfo | head -n 5`.
    *   **Pregunta de SysAdmin:** Si apagas la máquina virtual, ¿estos archivos siguen existiendo en el disco duro o desaparecen? Justifica basándote en la naturaleza de la RAM (Diapositiva 14).

## Actividad 4: Gestión de Enlaces (Hard vs. Soft)
*Referencia teórica: Diapositivas 20 y 21 (Comparativa de Enlaces).*

1.  **Creación de Enlaces:**
    *   Crea un archivo base: `echo "Origen" > base.txt`.
    *   Crea un enlace duro: `ln base.txt enlace_duro`.
    *   Crea un enlace simbólico: `ln -s base.txt enlace_blando`.
2.  **Prueba de Inodos:** Ejecuta `ls -i`.
    *   **Análisis:** ¿Qué archivos comparten el mismo número de inodo? (Ver Diapositiva 20).
3.  **Prueba de Borrado:** Borra el archivo original (`rm base.txt`).
    *   **Resultado:** Intenta leer los dos enlaces creados. ¿Cuál sigue funcionando y cuál se "rompió"? ¿Por qué?

---

# Rúbrica de Evaluación (Escueta y Puntual)

| Indicador | Logrado (5 pts) | En Proceso (3 pts) | No Logrado (0 pts) |
| :--- | :--- | :--- | :--- |
| **Navegación FHS** | Diferencia correctamente rutas absolutas/relativas y el propósito de cada directorio clave. | Navega por el sistema pero no identifica la función de directorios como `/opt` o `/srv`. | No comprende la estructura de árbol invertido de Linux. |
| **Auditoría de /etc** | Identifica archivos críticos de usuarios y configuración, comprendiendo su importancia estructural. | Reconoce los archivos pero no distingue entre binarios y archivos de texto de configuración. | No logra localizar archivos de configuración base. |
| **Uso de /proc** | Extrae información del kernel en tiempo real y comprende que los datos residen en RAM. | Lee los archivos pero cree que son archivos estáticos almacenados en disco físico. | No identifica la naturaleza dinámica del sistema virtual de archivos. |
| **Gestión de Enlaces** | Crea y diferencia enlaces duros y blandos, validando el comportamiento tras el borrado del origen. | Crea los enlaces pero no comprende el concepto de Inodo ni la fragilidad del enlace simbólico. | No logra crear enlaces ni explicar su diferencia. |
| **Uso de CLI** | Emplea comandos de forma fluida (`cd`, `ls -i`, `ln`, `cat`) siguiendo la metodología SysAdmin. | Comete errores frecuentes de sintaxis o depende de la interfaz gráfica. | Incapaz de operar en el entorno de línea de comandos. |

