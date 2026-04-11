# Guía de Laboratorio: Auditoría de Arquitectura y Almacenamiento

**Objetivo:** Evaluar la configuración de hardware, el esquema de particionamiento y la gestión de memoria virtual (Swap) de un servidor Ubuntu activo, contrastándolo con los estándares corporativos.

**Entorno:** Ubuntu Server VM.

---

## Actividad 1: Validación de Requisitos Mínimos
*Referencia teórica: Diapositivas 2, 3 y 17 (Requisitos de Hardware).*

1.  **Auditoría de CPU y RAM:** Ejecuta `lscpu` y `free -m`.
    *   **Tarea:** Compara tus resultados con la Diapositiva 17. ¿Tu VM cumple con los requisitos para "Modo Textual" o para "Productividad Recomendada"?
2.  **Verificación de Integridad:** El material menciona la verificación ISO (Diapositiva 6).
    *   **Pregunta:** Si tuvieras el archivo `.iso` original en el servidor, ¿qué comando usarías para calcular su checksum y asegurar que no fue alterado?

## Actividad 2: Análisis del Mapa de Particiones
*Referencia teórica: Diapositivas 7, 8 y 11 (Conceptos de Partición).*

1.  **Mapeo de Dispositivos:** Ejecuta `lsblk`.
    *   **Tarea:** Identifica el nombre del dispositivo principal (ej. `sda` o `vda`) y sus particiones (ej. `sda1`, `sda2`).
2.  **Identificación de Puntos de Montaje:** Ejecuta `df -h`.
    *   **Análisis:** ¿Tu sistema usó **Particionamiento Guiado** (todo en `/`) o **Manual** (directorios separados)? Justifica observando si `/home` o `/var` tienen particiones propias según la Diapositiva 18.

## Actividad 3: Evaluación de la Partición Swap
*Referencia teórica: Diapositivas 13 y 20 (La Partición Swap).*

1.  **Estado de la Memoria Virtual:** Ejecuta `swapon --show`.
    *   **Tarea:** Determina el tamaño de tu Swap.
2.  **Cálculo de Regla de Dimensionamiento:** 
    *   **Ejercicio:** Según la "Regla de Oro" de la Diapositiva 13 (1 a 2 veces la RAM física), ¿cuál debería ser el tamaño ideal de tu Swap basado en la RAM que identificaste en la Actividad 1?

## Actividad 4: Puntos Críticos y Estrategia (/boot y /var)
*Referencia teórica: Diapositivas 14, 15 y 21 (Particiones específicas).*

1.  **Análisis de /boot:** Ejecuta `ls -lh /boot`.
    *   **Reflexión:** Observa el tamaño de los archivos del kernel (`vmlinuz`). Según la Diapositiva 14, ¿por qué es estratégico que este directorio esté aislado en entornos RAID?
2.  **Dinámica de /var:** Revisa el tamaño de los logs con `du -sh /var/log`.
    *   **Pregunta:** Si este directorio se llenara al 100% por un ataque de logs, y **no** estuviera en una partición aislada, ¿qué le sucedería a la partición Raíz (`/`)? (Ver Diapositiva 12: Seguridad y Contención).

---

# Rúbrica de Evaluación (Puntual y Escueta)

| Indicador | Logrado (5 pts) | En Proceso (3 pts) | No Logrado (0 pts) |
| :--- | :--- | :--- | :--- |
| **Diagnóstico de Hardware** | Identifica CPU/RAM y los categoriza correctamente según el material. | Identifica los datos pero no los compara con los requisitos mínimos. | No identifica los recursos del sistema. |
| **Análisis de Particiones** | Diferencia con éxito entre esquema guiado y manual usando `lsblk/df`. | Confunde puntos de montaje con particiones físicas. | No logra listar la estructura de disco. |
| **Gestión de Swap** | Calcula el tamaño ideal según la regla técnica y justifica su función. | Encuentra la Swap pero no sabe calcular el tamaño recomendado. | Ignora la existencia o función de la memoria virtual. |
| **Justificación de Aislamiento** | Explica la importancia de aislar `/var`, `/boot` o `/home` basada en riesgos. | Menciona los directorios pero no explica la ventaja técnica de su aislamiento. | No comprende el concepto de punto de montaje aislado. |
| **Precisión Técnica** | Usa comandos correctos y terminología del material (SATA, SCSI, MBR). | Usa comandos pero confunde términos técnicos en el informe. | Errores graves en comandos y conceptos básicos. |

