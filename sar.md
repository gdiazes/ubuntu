# 📊 Manual Completo de Referencia: System Activity Reporter (sar) en Ubuntu

Este manual ha sido estructurado como una guía visual y práctica de nivel profesional, optimizada para copiar y pegar comandos directamente en la terminal. Es ideal como material de apoyo o presentación interactiva en clases de administración de sistemas y telemetría.

---

## 📋 Tabla de Contenido
- [1. ¿Qué es `sar` y por qué es vital para un Sysadmin?](#1-qué-es-sar-y-por-qué-es-vital-para-un-sysadmin)
- [2. Paso 1: Proceso de Instalación en Ubuntu](#2-paso-1-proceso-de-instalación-en-ubuntu)
- [3. Paso 2: Configuración del Demonio y Telemetría Histórica](#3-paso-2-configuración-del-demonio-y-telemetría-histórica)
- [4. Paso 3: Guía de Uso para Monitoreo en Tiempo Real](#4-paso-3-guía-de-uso-para-monitoreo-en-tiempo-real)
- [5. Paso 4: Viaje en el Tiempo (Auditoría de Incidentes del Pasado)](#5-paso-4-viaje-en-el-tiempo-auditoría-de-incidentes-del-pasado)
- [6. Tabla Resumen de Banderas y Parámetros](#6-tabla-resumen-de-banderas-y-parámetros)

---

## 1. ¿Qué es `sar` y por qué es vital para un Sysadmin?

El comando `sar` (*System Activity Reporter*) es la herramienta estándar más potente en Linux para recopilar, reportar y guardar métricas de rendimiento del sistema a lo largo del tiempo. Forma parte de la suite de utilidades **`sysstat`**.

> [!TIP]
> **La gran diferencia con `top` o `htop`:**
> *   **`top` es Reactivo:** Solo muestra lo que ocurre en el instante exacto en que miras la pantalla. Si el servidor se cuelga a las 3:00 AM y se reinicia, `top` no te dará pistas de la causa del fallo.
> *   **`sar` es Proactivo e Histórico:** Corre silenciosamente como servicio de fondo (daemon) guardando instantáneas de la CPU, RAM, discos y red en logs binarios persistentes. Es la "máquina del tiempo" del Sysadmin.

---

## 2. Paso 1: Proceso de Instalación en Ubuntu

Dado que `sar` no siempre viene instalado por defecto en distribuciones Linux mínimas, procedemos con su instalación rápida desde los repositorios de paquetes oficiales:

```bash
# 1. Actualizar la base de datos de paquetes locales
sudo apt update

# 2. Instalar el paquete sysstat de forma desatendida
sudo apt install sysstat -y
```

---

## 3. Paso 2: Configuración del Demonio y Telemetría Histórica

En distribuciones basadas en Debian/Ubuntu, la recolección automática en segundo plano viene desactivada por defecto por razones de economía de almacenamiento. Es obligatorio habilitarla manualmente:

### Paso 2.1: Habilitar la recolección
Edita el archivo de configuración global `/etc/default/sysstat`:

```bash
# Opción A (Recomendada): Cambio inmediato de 'false' a 'true' sin abrir editores
sudo sed -i 's/ENABLED="false"/ENABLED="true"/g' /etc/default/sysstat
```

Si prefieres editarlo manualmente usando un editor interactivo en consola:
```bash
sudo nano /etc/default/sysstat
# Busca ENABLED="false" y cámbialo a ENABLED="true"
```

### Paso 2.2: Habilitar e Iniciar el Servicio con Systemd
Debes arrancar el servicio de recolección y habilitarlo para que se ejecute de forma automática al iniciar el host:

```bash
# Activar e iniciar el servicio inmediatamente
sudo systemctl enable sysstat --now

# Reiniciar para asegurar la correcta lectura de la configuración
sudo systemctl restart sysstat
```

### Paso 2.3: Verificar el estado del recolector
```bash
# Validar que el daemon esté corriendo de forma activa
sudo systemctl status sysstat
```

---

## 4. Paso 3: Guía de Uso para Monitoreo en Tiempo Real

Para realizar un diagnóstico en vivo en el servidor, usamos la siguiente sintaxis:
`sar [opciones] [intervalo_en_segundos] [número_de_muestras]`

### A) Monitoreo de CPU General (`-u`)
Excelente para medir la carga de procesamiento y descartar problemas relacionados a cuellos de botella de discos a través de la métrica de tiempo de espera (`%iowait`).
```bash
# Medir la CPU cada 1 segundo, un total de 5 veces
sar -u 1 5
```

### B) Monitoreo de Carga por Núcleos Individuales (`-P`)
Te permite ver si tienes procesos monohilo saturando un hilo específico de CPU mientras los otros núcleos duermen.
```bash
# Monitorear todos los cores por separado (1 seg / 3 veces)
sar -P ALL 1 3
```

### C) Monitoreo de Memoria RAM Física (`-r`) y Swap (`-S`)
Permite descartar problemas de saturación de memoria real o problemas de swapping que ralentizan el sistema.
```bash
# Monitoreo de memoria RAM física
sar -r 1 3

# Monitoreo del uso del área de intercambio (Swap)
sar -S 1 3
```

### D) Monitoreo de Discos y Almacenamiento (`-d -p`)
Calcula lecturas, escrituras y el tiempo de respuesta de las peticiones (`await`). La bandera `-p` traduce los códigos raw del sistema a nombres legibles por el humano (ej: `sda` en lugar de `dev8-0`).
```bash
# Monitoreo de rendimiento de discos duros en vivo
sar -d -p 1 3
```

### E) Monitoreo de Tráfico de Red (`-n DEV`)
Ideal para verificar la tasa de transferencia en vivo a través de tus interfaces activas (como `eth0`, `ens33` o `wlan0`).
```bash
# Ver KB/s recibidos y transmitidos por segundo en vivo
sar -n DEV 1 3
```

---

## 5. Paso 4: Viaje en el Tiempo (Auditoría de Incidentes del Pasado)

El daemon de `sysstat` toma métricas automáticamente en segundo plano (normalmente cada 10 minutos) y las almacena en formato binario en la siguiente ruta:
📂 `/var/log/sysstat/saDD` (o `/var/log/sa/saDD` en otras distros), donde `DD` es el día actual del mes.

### Caso 1: Un cliente reporta que el servidor colapsó hoy por la mañana
Puedes ver la carga promedio acumulada de la CPU durante las últimas 24 horas ejecutando:
```bash
# Muestra el histórico completo de CPU de hoy desde la medianoche
sar -u
```

### Caso 2: Analizar el uso de Memoria RAM de un día específico del pasado
Por ejemplo, si deseas ver el comportamiento de la RAM el día 25 del mes en curso:
```bash
# Leer el log binario correspondiente al día 25
sar -r -f /var/log/sysstat/sa25
```

### Caso 3: Auditar la CPU de un día anterior en una hora sumamente específica
Si un servicio se cayó ayer (día 26) entre las 14:00 y las 14:30, puedes aislar ese periodo de tiempo exacto para tu análisis:
```bash
# Filtrar registros del día 26 por rango de horas exactas (inicio -s, fin -e)
sar -u -f /var/log/sysstat/sa26 -s 14:00:00 -e 14:30:00
```

---

## 6. Tabla Resumen de Banderas y Parámetros

| Bandera | Componente Monitoreado | Métrica de Interés Clave |
| :--- | :--- | :--- |
| **`-u`** | CPU Principal | `%usr` (Uso de usuario), `%iowait` (Espera de disco) |
| **`-P`** | CPU por Núcleos | Balanceo y carga por núcleo individual |
| **`-r`** | Memoria RAM física | `%memused` (Porcentaje de RAM física utilizada) |
| **`-S`** | Memoria de Intercambio | `%swpused` (Porcentaje de Swap utilizado) |
| **`-d -p`** | Discos Físicos | `await` (Latencia promedio de E/S en milisegundos) |
| **`-n DEV`** | Interfaces de Red | `rxkB/s` (Descarga) y `txkB/s` (Subida) |
| **`-q`** | Load Average | `ldavg-1`, `ldavg-5`, `ldavg-15` (Cargas de trabajo) |
| **`-f`** | Entrada de archivo | Ruta del archivo binario histórico a auditar |
| **`-s` / `-e`**| Start / End time | Filtro de rangos de horas específicas (`HH:MM:SS`) |

---
*Manual redactado con fines educativos y profesionales. ¡Listo para usar en consola y exposiciones! 🚀*
