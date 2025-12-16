#!/bin/bash
set -e  # Stop script if any command fails

echo "=== Oppdaterer pakker ==="
sudo apt update

echo "=== Installerer MariaDB server og klient ==="
sudo apt install -y mariadb-server mariadb-client

echo "=== Starter og aktiverer MariaDB ==="
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo "=== Installerer Python, pip og venv ==="
sudo apt install -y python3 python3-pip python3-venv

echo "=== Lager virtual environment ==="
python3 -m venv venv
source venv/bin/activate

echo "=== Installerer Flask og PyMySQL ==="
pip install flask pymysql

echo "=== Verifiserer installasjon ==="
python -c "import flask, pymysql; print('Alt fungerer')"

echo "=== Setter opp MariaDB ==="

# SQL-kommandoer som kjøres i root
sudo mariadb <<MYSQL_SCRIPT
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

echo "=== Genererer SSL-sertifikat ==="
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout domain.key -out domain.crt -sha256 \
-subj "/C=NO/ST=Oslo/L=Oslo/O=Example Company/CN=example.com"

echo "====== Ferdig! ======"
