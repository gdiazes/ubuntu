# Guía de Laboratorio: Taxonomía y Arquitectura del Ecosistema Ubuntu

**Objetivo:** Identificar las capas técnicas de una distribución, validar la arquitectura de hardware y comprender las dependencias de los entornos de escritorio y las raíces de la familia Debian.

**Entorno:** Virtual Machine (VM) con Ubuntu Server.

---

## Actividad 1: Análisis de la Capa de Hardware y Arquitectura
*Referencia teórica: Diapositivas 9, 18 (Arquitecturas de Hardware).*

1.  **Determinación de la Arquitectura:** Ejecuta el comando `lscpu`.
    *   **Tarea:** Identifica si tu sistema es **x86_64 (AMD64)** o **i386**. Según la Diapositiva 18, ¿cuál es el "Caso de Uso Común" para esta arquitectura específica?
2.  **Soporte Multi-arquitectura:** Linux permite ejecutar binarios de otras arquitecturas si se configura adecuadamente.
    *   **Comando:** `dpkg --print-architecture` y `dpkg --print-foreign-architectures`.
    *   **Reflexión:** Si tuvieras un procesador **ARM** (como una Raspberry Pi), ¿podrías instalar directamente un paquete compilado para AMD64? Justifica basándote en la diapositiva 18.

## Actividad 2: El ADN del Sistema (La Familia Debian)
*Referencia teórica: Diapositivas 8, 12 y 19 (La Familia Debian).*

1.  **Identificación de Raíces:** Ejecuta `cat /etc/os-release`.
    *   **Tarea:** Busca la línea `ID_LIKE`. ¿A qué familia pertenece Ubuntu según este archivo?
2.  **Análisis de Repositorios:** Revisa el archivo de fuentes de software con `cat /etc/apt/sources.list`.
    *   **Investigación:** Identifica si los servidores de descarga pertenecen a Canonical o a la comunidad Debian. ¿Cómo se relaciona esto con la diapositiva 8 sobre el patrocinio de Canonical?

## Actividad 3: Anatomía de un "Sabor" (Flavor) en un Servidor
*Referencia teórica: Diapositivas 2, 5, 6 y 10 (Capas de una Distro y Sabores).*

Aunque Ubuntu Server no tiene GUI, los paquetes de los "sabores" (KDE, Xfce, GNOME) están disponibles en los repositorios.

1.  **Simulación de Entorno (Metadatos):** No instalaremos el entorno completo para no saturar la VM, pero simularemos la consulta. Ejecuta:
    *   `apt show lubuntu-desktop` (Sabor ligero - LXDE/LXQt).
    *   `apt show kubuntu-desktop` (Sabor pesado - KDE).
2.  **Comparativa de Dependencias:** Observa el campo `Depends` en ambos comandos.
    *   **Tarea:** Busca menciones a "X11" o "Xserver". Según la diapositiva 3, ¿qué rol cumple el **Servidor X** en la arquitectura de estas interfaces?
    *   **Análisis de Rendimiento:** Basándote en la diapositiva 17, si tuvieras un servidor con recursos muy limitados (512MB RAM), ¿cuál de estos dos sabores sería el más apto y por qué?

## Actividad 4: Ecosistemas de Nicho y Especialización
*Referencia teórica: Diapositivas 16 y 20 (Casos de Uso).*

1.  **Investigación de Herramientas:** Ubuntu Server puede convertirse en una distro de seguridad.
    *   **Tarea:** Intenta buscar el paquete de auditoría de redes `nmap` usando `apt search nmap`.
    *   **Reflexión:** Si instalaras todas las herramientas de la diapositiva 20 (Kali Linux) sobre tu Ubuntu Server, ¿en qué categoría de "Caso de Uso" entraría tu sistema ahora?

---

# Rúbrica de Evaluación

| Criterio | Excelente (5 pts) | Bueno (3-4 pts) | En Desarrollo (1-2 pts) | Insuficiente (0 pts) |
| :--- | :--- | :--- | :--- | :--- |
| **Identificación de Arquitectura** | Identifica correctamente la arquitectura y explica su impacto en la compatibilidad de software. | Identifica la arquitectura pero no logra explicar las limitaciones de hardware. | Confunde términos de arquitectura (ej. confunde CPU con SO). | No realiza la identificación. |
| **Análisis de la Familia Linux** | Rastrea el origen de Ubuntu hasta Debian mediante archivos del sistema y fuentes de software. | Identifica la relación con Debian pero no comprende el rol de Canonical en el ecosistema. | No encuentra los archivos de configuración de la distribución. | No identifica la familia del sistema. |
| **Comprensión de "Flavors" y Capas** | Explica la diferencia técnica (recursos/dependencias) entre sabores como Lubuntu y Kubuntu usando el PMS. | Diferencia los sabores por nombre pero no comprende la capa de "Sistema de Ventanas" (X11). | No logra usar comandos de búsqueda para comparar metadatos de paquetes. | Confunde un entorno de escritorio con un núcleo. |
| **Vinculación Teórica (Nichos)** | Conecta las capacidades del servidor con los ecosistemas de nicho (Seguridad, Cloud, IoT) vistos en clase. | Identifica casos de uso pero de forma genérica, sin usar los ejemplos del material. | Menciona distros de nicho pero no sabe cómo se relacionan con el sistema actual. | No identifica casos de uso especializados. |
| **Síntesis y Metodología** | El reporte sigue una estructura lógica de investigación y usa terminología técnica precisa de las tablas comparativas. | El reporte es completo pero presenta errores menores en el uso de términos técnicos. | El reporte es una lista de comandos sin análisis ni reflexión sobre los resultados. | No entrega el reporte de laboratorio. |
