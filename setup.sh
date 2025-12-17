#!/bin/bash
set -e  # Stopper scriptet hvis noe feiler

echo "=== Oppdaterer pakker ==="
apt update

echo "=== Installerer Python, pip og venv ==="
apt install -y python3 python3-pip python3-venv

echo "=== Lager virtual environment ==="
python3 -m venv venv
source venv/bin/activate

echo "=== Installerer Flask og PyMySQL ==="
pip install flask pymysql

echo "=== Verifiserer Python-installasjon ==="
python -c "import flask, pymysql; print('Alt fungerer')"

echo "=== Installerer MariaDB server og klient ==="
apt install -y mariadb-server mariadb-client

echo "=== Starter og aktiverer MariaDB ==="
systemctl start mariadb
systemctl enable mariadb



echo "=== Setter opp database, bruker og tabell ==="
mysql -uroot -p1234 <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS gamebutikk;

CREATE USER IF NOT EXISTS 'nettbutikk'@'localhost' IDENTIFIED BY 'termin';
GRANT SELECT ON gamebutikk.* TO 'nettbutikk'@'localhost';
FLUSH PRIVILEGES;

USE gamebutikk;

CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO items (name, price) VALUES
('physical copy x1', 40.00),
('physical copy x2', 79.00),
('physical copy x3', 115.00);
MYSQL_SCRIPT

echo "=== Genererer SSL-sertifikat ==="
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout domain.key -out domain.crt -sha256 \
-subj "/C=NO/ST=Oslo/L=Oslo/O=Example Company/CN=example.com"

echo "=== SETUP FULLFØRT ==="
echo "MariaDB root-passord: 1234"
echo "DB-bruker: nettbutikk"
echo "Database: gamebutikk"
echo "Sertifikat-filene heter domain.crt og domain.key"

