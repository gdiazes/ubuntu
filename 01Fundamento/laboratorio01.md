# Guía de Laboratorio: Inmersión en los Fundamentos de Ubuntu Server

**Objetivo:** Validar experimentalmente la arquitectura, el funcionamiento del kernel y la gestión de paquetes en una distribución Linux (Ubuntu), aplicando los conceptos de la síntesis analítica del entorno operativo.

**Entorno:** Virtual Machine (VM) con Ubuntu Server (preferiblemente 22.04 LTS o superior).

---

## Actividad 1: Identificación del Kernel y ADN del Sistema
*Referencia teórica: Diapositivas 5, 12 y 17 (El Kernel y la Interfaz de Programación).*

1.  **Identificación del Núcleo:** Ejecuta el comando `uname -a`.
    *   **Tarea:** Identifica la versión del kernel y la arquitectura del procesador. ¿Cómo se relaciona esto con la "Portabilidad Lingüística" mencionada en la diapositiva 11 (lenguaje C)?
2.  **Llamadas al Sistema (System Calls):** Instala la herramienta `strace` (`sudo apt install strace`). Ejecuta `strace ls`.
    *   **Investigación:** Observa la salida. Identifica al menos dos "system calls" (ej. `openat`, `read`, `write`). Explica brevemente cómo el kernel actúa de puente entre el comando `ls` y el hardware de almacenamiento.

## Actividad 2: Exploración de la Dualidad GNU/Linux
*Referencia teórica: Diapositivas 7 y 8 (Proyecto GNU y Nacimiento de Linux).*

1.  **Componentes de Software:** El material indica que Linux es el Kernel y GNU aporta las utilidades.
    *   **Tarea:** Ejecuta `ls --version` y `bash --version`. Verifica quién es el autor o la organización que mantiene estas herramientas básicas.
2.  **Licenciamiento en la práctica:**
    *   **Tarea:** Ve al directorio `/usr/share/doc/` de cualquier paquete instalado (ej. `bash`). Busca el archivo `copyright`.
    *   **Reflexión:** Encuentra la mención a la licencia **GPL**. Según la diapositiva 9, ¿qué derecho inalienable tienes sobre este código?

## Actividad 3: Gestión de Paquetes y Metadatos (PMS)
*Referencia teórica: Diapositiva 16 (El Sistema de Gestión de Paquetes).*

1.  **Anatomía de un paquete:** Utiliza el comando `apt show vim` (o cualquier otro editor).
    *   **Análisis:** Identifica en la salida los campos: *Version*, *Depends* y *Download-Size*.
    *   **Pregunta de investigación:** ¿Cómo ayuda el campo *Depends* a evitar que el sistema se "rompa", tal como menciona la diapositiva 16?
2.  **Actualización y Seguridad:** Ejecuta `sudo apt update`.
    *   **Tarea:** Explica qué sucede técnicamente con los "metadatos" cuando ejecutas este comando antes de un `upgrade`.

## Actividad 4: Concurrencia y Aislamiento de Procesos
*Referencia teórica: Diapositiva 13 (Concurrencia y Multitarea Aislada).*

1.  **Observación de Multitarea:** Ejecuta el comando `top` o `htop`.
    *   **Tarea:** Identifica cuántos usuarios están activos y cuántos procesos están en estado "running" vs "sleeping".
2.  **Simulación de Aislamiento:** Abre una segunda terminal (o sesión SSH) hacia la misma VM.
    *   **Experimento:** En la Terminal A, ejecuta un comando de larga duración (ej. `ping google.com`). En la Terminal B, usa `ps aux | grep ping` para localizarlo.
    *   **Reflexión:** Si "matas" el proceso de la Terminal A desde la Terminal B (`sudo kill -9 [PID]`), ¿se colapsa el resto del sistema? ¿Cómo valida esto el concepto de "Aislamiento de Procesos" de la diapositiva 13?

---

# Rúbrica de Evaluación (Nivel Universitario/Técnico)

Esta rúbrica evalúa tanto la ejecución técnica como la capacidad de síntesis del estudiante.

| Criterio | Excelente (5 pts) | Bueno (3-4 pts) | En Desarrollo (1-2 pts) | Insuficiente (0 pts) |
| :--- | :--- | :--- | :--- | :--- |
| **Identificación Técnica (Kernel/OS)** | Identifica con precisión versión de kernel y arquitectura, vinculándolos correctamente con la teoría del material. | Identifica los datos pero la vinculación con la teoría es débil o superficial. | Comete errores al identificar la versión o no comprende la salida del comando. | No realiza la actividad. |
| **Análisis de System Calls y Software** | Explica claramente la función de las llamadas al sistema y reconoce la autoría de las herramientas GNU. | Reconoce las herramientas pero no logra explicar el flujo entre aplicación-kernel-hardware. | Confunde términos de software libre y no logra identificar system calls. | No logra instalar o ejecutar las herramientas de análisis. |
| **Gestión de Paquetes (PMS)** | Analiza correctamente las dependencias y entiende el rol de los metadatos en la estabilidad del sistema. | Describe el proceso de instalación pero no profundiza en la importancia de las dependencias. | Solo ejecuta comandos mecánicamente sin entender la salida del PMS. | No comprende el funcionamiento de `apt`. |
| **Práctica de Concurrencia** | Demuestra y explica el aislamiento de procesos mediante la manipulación de PIDs en múltiples sesiones. | Realiza el experimento de concurrencia pero tiene dificultades para explicar el concepto de aislamiento. | Realiza la actividad en una sola terminal sin probar la interacción multiusuario/multitarea. | No logra identificar procesos en el sistema. |
| **Documentación y Reflexión** | El informe es técnico, usa terminología correcta y responde a todas las preguntas de investigación con pensamiento crítico. | El informe es claro pero carece de profundidad en las reflexiones teóricas. | El informe es desorganizado o faltan respuestas a las preguntas planteadas. | No entrega informe o es copia de otro compañero. |

