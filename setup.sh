#!/bin/bash
 
echo "======================================"
echo "Terminoppgave Installasjon Script"
echo "======================================"
echo ""
 
# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No Colour
 
# Check if running as root for MariaDB installation
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}This script needs sudo privileges to install MariaDB${NC}"
    echo "Please run with: sudo ./setup-LINUX-MAC.sh"
    exit 1
fi
 
set -e  # Stop script if any command fails
 
echo ""
echo "${GREEN}=== Oppdaterer pakker ==="
apt update
echo ""
 
echo "${GREEN}=== Installerer MariaDB server og klient ==="
apt install -y mariadb-server mariadb-client
echo ""
 
echo "${GREEN}=== Starter og aktiverer MariaDB ==="
systemctl start mariadb
systemctl enable mariadb
echo ""
 
echo "${GREEN}=== Installerer Python, pip og venv ==="
apt install -y python3 python3-pip python3-venv
echo ""
 
echo "${GREEN}=== Lager virtual environment ==="
python3 -m venv venv
source venv/bin/activate
echo ""
 
echo "${GREEN}=== Installerer Flask og PyMySQL ==="
pip install flask pymysql
echo ""
 
echo "${GREEN}=== Verifiserer installasjon ==="
python -c "import flask, pymysql; print('Alt fungerer')"
echo ""
 
echo "${GREEN}=== Setter opp MariaDB ==="
 
# SQL-kommandoer som kjøres i root
mariadb <<MYSQL_SCRIPT
-- Opprett database
CREATE DATABASE IF NOT EXISTS gamebutikk;
 
-- Opprett bruker med SELECT-rettigheter
CREATE USER IF NOT EXISTS 'nettbutikk'@'localhost' IDENTIFIED BY 'termin';
GRANT SELECT ON gamebutikk.* TO 'nettbutikk'@'localhost';
FLUSH PRIVILEGES;
 
-- Bruk databasen og lag tabellen
USE gamebutikk;
 
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
 
-- Legg inn produkter
INSERT INTO items (name, price) VALUES
('physical copy x1', 40.00),
('physical copy x2', 79.00),
('physical copy x3', 115.00);
MYSQL_SCRIPT
echo ""
 
echo "${GREEN}=== Genererer SSL-sertifikat ==="
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout domain.key -out domain.crt -sha256 \
-subj "/C=NO/ST=Oslo/L=Oslo/O=Example Company/CN=example.com"
echo ""
 
echo "${GREEN}====== Ferdig! ======"
