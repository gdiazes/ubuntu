# Guía de Laboratorio: Introspección y Arquitectura Cloud

**Objetivo:** Analizar las capacidades de virtualización del kernel, detectar el entorno del hipervisor y mapear servicios locales hacia una arquitectura de nube privada (OpenStack).

**Entorno:** Ubuntu Server VM.

---

## Actividad 1: Detección del Hipervisor (Guest Introspection)
*Referencia teórica: Diapositivas 3, 10 y 17 (Hipervisores y Abstracción).*

1.  **Identificación del Entorno:** Ejecuta el comando `systemd-detect-virt`.
    *   **Tarea:** Identifica qué hipervisor está reportando el sistema (ej. oracle, kvm, vmware). ¿Cómo se relaciona esto con el concepto de "Abstracción de recursos físicos" de la Diapositiva 17?
2.  **Huellas de Hardware Virtual:** Ejecuta `dmesg | grep -i virtual`.
    *   **Análisis:** Busca menciones a controladores de video, disco o red virtuales. Según la Diapositiva 4, ¿estas piezas pertenecen al "Hardware Físico" o al "Hardware Virtual"?

## Actividad 2: El Kernel y el Soporte de Virtualización (KVM)
*Referencia teórica: Diapositiva 9 y 18 (KVM vs VirtualBox).*

1.  **Verificación de Módulos:** Ejecuta `lsmod | grep kvm`.
    *   **Investigación:** Si el comando no devuelve nada, intenta `sudo modprobe kvm`.
    *   **Pregunta:** Si estuviéramos en un servidor físico (Host), ¿por qué es preferible usar el módulo KVM sobre VirtualBox para un servidor de base de datos intensivo? (Ver Diapositiva 18: Rendimiento).
2.  **Capacidades del CPU:** Ejecuta `grep -E 'vmx|svm' /proc/cpuinfo`.
    *   **Tarea:** Determina si el procesador virtualizado tiene activadas las extensiones VT-x (Intel) o AMD-V. Según la Diapositiva 9, ¿qué permite esta tecnología?

## Actividad 3: Simulación de Estado y "Snapshots" (Sandbox)
*Referencia teórica: Diapositiva 8 (Sandboxes y Snapshots).*

1.  **Simulación de Fallo:** 
    *   Crea un archivo importante: `echo "Datos Críticos" > /tmp/sistema.db`.
    *   Simula un error humano borrándolo: `rm /tmp/sistema.db`.
2.  **Reflexión Técnica:** En un entorno físico, este dato se perdería. 
    *   **Pregunta:** Basándote en la Diapositiva 8, si hubieras tomado un **Snapshot** antes de borrar el archivo, ¿cuál sería el procedimiento para recuperarlo y qué ventaja tiene sobre una reinstalación?

## Actividad 4: Mapeo de Servicios a la Nube (OpenStack)
*Referencia teórica: Diapositivas 16 y 21 (Nube Privada y OpenStack).*

1.  **Análisis de Roles:** Imagina que tu VM de Ubuntu es ahora un controlador de nube privada.
2.  **Tarea de Mapeo:** Completa la siguiente analogía técnica basándote en la Diapositiva 21:
    *   Si quiero gestionar el **Cálculo/CPU** de mis máquinas, usaría el servicio: __________.
    *   Si quiero entrar a un **Panel Web** para ver mis recursos, usaría: __________.
    *   Para validar mi **Identidad/Usuario**, el servicio responsable es: __________.

---

# Rúbrica de Evaluación (Escueta y Puntual)

| Indicador | Logrado (5 pts) | En Proceso (3 pts) | No Logrado (0 pts) |
| :--- | :--- | :--- | :--- |
| **Detección de VM** | Identifica el hipervisor y diferencia correctamente hardware físico de virtual. | Detecta el entorno pero no explica la relación con el hipervisor. | No logra usar comandos de detección. |
| **Análisis de KVM** | Verifica los módulos del kernel y comprende la ventaja de la virtualización nativa. | Encuentra los módulos pero confunde KVM con emulación de software. | No comprende el rol del kernel en la virtualización. |
| **Gestión de Snapshots** | Explica con precisión el ciclo de vida de una instantánea y su uso en sandboxing. | Entiende el concepto de respaldo pero no el de "revertir estado" inmediato. | Confunde un Snapshot con una copia de seguridad tradicional. |
| **Arquitectura Cloud** | Mapea correctamente los servicios de OpenStack (Nova, Horizon, Keystone) a sus funciones. | Identifica los nombres de los servicios pero no sus responsabilidades técnicas. | No logra relacionar servicios locales con la nube. |
| **Terminología Técnica** | Usa correctamente términos como IaaS, Bare-Metal, Hypervisor y VMM. | Usa los términos pero los intercambia erróneamente en el informe. | No utiliza el vocabulario técnico del material. |

