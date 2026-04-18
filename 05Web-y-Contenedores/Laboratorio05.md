# Guía de Laboratorio: Pilas Web y Despliegue de Contenedores

**Objetivo:** Configurar componentes de una pila web, diferenciar arquitecturas relacionales de dinámicas y validar la eficiencia de los contenedores frente a la virtualización tradicional.

**Entorno:** Ubuntu Server VM (con Docker y LXD preinstalados o por instalar).

---

## Actividad 1: Auditoría de Pilas Web (LAMP vs LEMP)
*Referencia teórica: Diapositivas 2, 3, 4 y 17 (Pilas Web y Comparativa).*

1.  **Detección de Motor Web:** Ejecuta `systemctl status apache2` y `systemctl status nginx`.
    *   **Tarea:** Identifica cuál de los dos servicios está activo. Según la Diapositiva 4, si buscas "Alto Rendimiento y Concurrencia", ¿cuál de estos dos motores deberías elegir?
2.  **Identificación de Lenguajes:** Ejecuta `php -v` o `python3 --version`.
    *   **Análisis:** Según la Diapositiva 17, identifica qué componente de la pila (L-A-M-P) representan estos lenguajes.

## Actividad 2: Análisis de Almacenamiento (Relacional vs NoSQL)
*Referencia teórica: Diapositivas 5 y 18 (Pila MEAN y Arquitecturas).*

1.  **Verificación de Base de Datos:** Ejecuta `dpkg -l | grep -E 'mysql|mongo'`.
    *   **Investigación:** Determina si tu sistema tiene una base de datos **Relacional** (MySQL) o **NoSQL** (MongoDB).
    *   **Reflexión:** Según la Diapositiva 18, si tuvieras que desarrollar una aplicación con un "Frontend dinámico MVC (Angular)", ¿cuál de los dos tipos de bases de datos sería el más moderno/recomendado?

## Actividad 3: Contenedores - Eficiencia y Overhead
*Referencia teórica: Diapositivas 7, 8, 9 y 19 (VMs vs Contenedores).*

1.  **Validación del Motor de Contenedores:** Ejecuta `docker version` o `lxc version`.
2.  **Prueba de Aislamiento del Kernel:**
    *   Ejecuta `uname -r` en tu VM (Host).
    *   (Si tienes Docker) Ejecuta `docker run alpine uname -r`.
    *   **Hallazgo:** Observa que ambos devuelven el **mismo kernel**. Según la Diapositiva 9, ¿por qué los contenedores no necesitan un "Guest OS" completo y cómo reduce esto la sobrecarga (overhead)? (Ver Diapositiva 19).

## Actividad 4: Orquestación y Escalabilidad (Kubernetes/LXD)
*Referencia teórica: Diapositivas 11, 14, 15 y 21 (Orquestación).*

1.  **LXD e Imágenes Inmutables:** Ejecuta `lxc image list`.
    *   **Pregunta:** Basándote en la Diapositiva 11, ¿cuál es la ventaja de crear múltiples "Instancias" a partir de una sola "Imagen Maestra"?
2.  **Conceptos de Kubernetes:** Imagina que tu VM es un nodo de un clúster masivo.
    *   **Tarea:** Según la Diapositiva 15, ¿qué función de Kubernetes se encargaría de reiniciar un contenedor automáticamente si este falla? (Término: __________).
    *   **Tarea:** ¿Qué empresa originó Kubernetes para gestionar miles de millones de contenedores semanalmente? (Ver Diapositiva 14).

---

# Rúbrica de Evaluación (Escueta y Puntual)

| Indicador | Logrado (5 pts) | En Proceso (3 pts) | No Logrado (0 pts) |
| :--- | :--- | :--- | :--- |
| **Diagnóstico de Pilas Web** | Identifica correctamente los componentes (L-A-M-P) y justifica la elección por rendimiento. | Identifica los servicios pero no diferencia entre Apache y Nginx técnicamente. | No identifica los servicios web instalados. |
| **Modelos de Datos** | Diferencia con éxito entre bases de datos relacionales y dinámicas (NoSQL). | Conoce los nombres pero no comprende cuándo usar uno u otro según la arquitectura. | Confunde MySQL con NoSQL. |
| **Arquitectura de Contenedores** | Demuestra que el contenedor comparte el kernel del host y explica el bajo overhead. | Ejecuta comandos de Docker/LXC pero no entiende la diferencia con una VM. | No logra ejecutar ni explicar el concepto de contenedor. |
| **Conocimiento de Orquestación** | Explica conceptos de auto-reparación (self-healing) y uso de imágenes inmutables. | Menciona Kubernetes o LXD pero no comprende su función en escalabilidad. | No identifica las herramientas de orquestación empresarial. |
| **Precisión de Informe** | Usa correctamente términos como Stack, Framework, Image y Pod/Instance. | Usa los términos pero confunde las capas del ecosistema (ej. confunde Docker con Kubernetes). | No utiliza terminología técnica adecuada. |

