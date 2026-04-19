
**Caso de Estudio: Auditoría y Recuperación de Infraestructura Crítica**

**Introducción al escenario**

Se describe una situación en la que un servidor Ubuntu ha quedado bajo la administración de un nuevo técnico tras la salida inesperada del responsable anterior. El sistema presenta diversas irregularidades que deben ser resueltas mediante la aplicación de comandos de administración avanzada y conocimientos de infraestructura virtual.

**Fase 1: Error de inicio en el hipervisor**

Al intentar iniciar la máquina virtual desde el software de virtualización, es reportado un error de bloqueo de archivos. Al realizar una inspección en el directorio del host Windows, se observa la existencia de carpetas con extensión .lck relacionadas con los archivos de configuración y discos virtuales. 

*Requerimiento 1:* Se solicita al estudiante que determine la acción física que debe ser ejecutada sobre estos directorios para permitir el arranque del sistema.

**Fase 2: Gestión de almacenamiento e inodos**

Una vez que el acceso al terminal es obtenido, se detecta que la capacidad del disco duro ha sido agotada casi en su totalidad. Durante la inspección del directorio de copias de seguridad, son localizados dos archivos cuyos nombres difieren, pero que comparten el mismo número de inodo. Se observa que el contador de la segunda columna en el comando ls -l muestra el valor 2 para ambos elementos. Asimismo, se visualiza un enlace simbólico que es mostrado por la interfaz en color rojo.

*Requerimiento 2:* Se requiere una explicación técnica sobre si la eliminación de solo uno de los archivos mencionados resultará en la liberación de espacio físico en el disco. Adicionalmente, se solicita la interpretación del estado del enlace resaltado en rojo y el método para identificar su destino original.

**Fase 3: Generación de archivos de prueba**

Se plantea la necesidad de crear un archivo de 4 Gigabytes con el fin de verificar el comportamiento del sistema ante un llenado controlado del volumen. El proceso debe ser realizado de manera instantánea para no comprometer el rendimiento del servidor durante la prueba.

*Requerimiento 3:* Se solicita la redacción del comando específico que permite la reserva de este espacio en el sistema de archivos sin necesidad de escribir datos físicamente.

**Fase 4: Jerarquía de permisos y acceso granular**

Es requerida la creación de un directorio de acceso restringido denominado /proyectos_especiales. Las políticas de seguridad establecidas dictan que el propietario debe poseer control total, mientras que los miembros del grupo "desarrollo" solo deben tener permisos de lectura y entrada al directorio. El resto de los usuarios del sistema debe tener el acceso completamente denegado. 

*Requerimiento 4:* Se solicita el cálculo del valor octal que debe ser aplicado mediante el comando chmod. Además, se requiere el comando para permitir que un usuario externo, que no pertenece al grupo de desarrollo, pueda leer un archivo específico dentro de dicha carpeta sin modificar la estructura de permisos existente.

**Fase 5: Auditoría de seguridad en el almacenamiento de credenciales**

Se realiza una lectura supervisada del archivo /etc/shadow para verificar la integridad de las cuentas de usuario. Durante el proceso, es identificada una cuenta administrativa cuyo hash de contraseña comienza con el prefijo $1$.

*Requerimiento 5:* Se solicita un análisis sobre el algoritmo de hashing que está siendo utilizado por dicha cuenta y una valoración técnica sobre por qué esta configuración es considerada una vulnerabilidad crítica en un entorno moderno.
