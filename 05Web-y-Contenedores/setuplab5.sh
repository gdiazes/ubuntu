#!/bin/bash

# =================================================================
# SCRIPT DE PREPARACIÓN: Laboratorio de Pilas Web y Contenedores
# Rol: SysAdmin / Especialista en Linux
# =================================================================

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}>>> Iniciando preparación del entorno Ubuntu Server...${NC}"

# 1. Actualización de repositorios
echo -e "${GREEN}1. Actualizando índices de paquetes...${NC}"
sudo apt-get update -y

# 2. Instalación de componentes LAMP (Linux ya está, instalamos AMP)
echo -e "${GREEN}2. Instalando Apache, MySQL y PHP (Pila LAMP)...${NC}"
sudo apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql

# 3. Instalación de componentes LEMP (Instalamos Nginx)
# Nota: Apache y Nginx entrarán en conflicto por el puerto 80. 
# Los detendremos para que el estudiante elija cuál activar.
echo -e "${GREEN}3. Instalando Nginx (Pila LEMP)...${NC}"
sudo apt-get install -y nginx
sudo systemctl stop apache2
sudo systemctl stop nginx

# 4. Instalación de bases de datos NoSQL y lenguajes adicionales
echo -e "${GREEN}4. Instalando MongoDB (NoSQL) y Python...${NC}"
sudo apt-get install -y mongodb python3 python3-pip

# 5. Instalación de Motores de Contenedores (Docker y LXD)
echo -e "${GREEN}5. Instalando Docker y LXD...${NC}"
sudo apt-get install -y docker.io lxd-installer
# Iniciar docker
sudo systemctl start docker
sudo systemctl enable docker

# 6. Herramientas de auditoría para el estudiante
echo -e "${GREEN}6. Instalando herramientas de red y diagnóstico...${NC}"
sudo apt-get install -y net-tools curl htop

# 7. Configuración de permisos para el usuario actual
echo -e "${GREEN}7. Configurando permisos de grupo (Docker/LXD)...${NC}"
# Esto permite que el estudiante use docker sin 'sudo' tras reiniciar sesión
sudo usermod -aG docker $USER
sudo usermod -aG lxd $USER

echo -e "${BLUE}=====================================================${NC}"
echo -e "${BLUE}>>> ¡ENTORNO PREPARADO PARA EL LABORATORIO!${NC}"
echo -e "${BLUE}Nota: Es recomendable cerrar sesión y volver a entrar${NC}"
echo -e "${BLUE}para que los permisos de Docker/LXD se apliquen.${NC}"
echo -e "${BLUE}=====================================================${NC}"
