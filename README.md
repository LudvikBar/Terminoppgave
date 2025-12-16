# Terminoppgave
I dette prosjektet hoster jeg mitt eget Godot spill med en tilhørende nettbutikk med flask på Raspberry Pi. Dette prosjektet er satt opp på Raspberry Pi med Ubuntu. 



## Brukerveiledning



### Automatisk setup
Kjør kommandoene en etter en
<pre>
git clone https://github.com/LudvikBar/Terminoppgave.git
cd Termonoppgave
chmod +x setup.sh
./setup.sh   
</pre>






### Manuel setup
På Raspberry Pi terminalen eller gjennom ssh installer mariadb, flask og pymysql. Jeg anbefaler og også installere og sette opp venv, det gjør så ting du installerer inni ikke tuller med resten av systemen. Alt du installerer der, installeres bare der.

Bare det som står i grått er kommandoer som skal kjøres.


🔹 1. Først last ned prosjektet. 
> git clone https://github.com/LudvikBar/Terminoppgave.git


🔹 1.1 Gå in i mappen. 
> cd Terminoppgave


🔹 2. Installer MariaDB

Installer både server og klient:

> sudo apt install mariadb-server mariadb-client


🔹 2.1 Start og aktiver MariaDB:

> sudo systemctl start mariadb

> sudo systemctl enable mariadb


🔹 3. Installer Python, pip og venv
> sudo apt install python3 python3-pip python3-venv

🔹 4. Opprett virtual environment (venv)
> python3 -m venv venv

> source venv/bin/activate

🔹 5. Installer Flask og PyMySQL
> pip install flask pymysql

🔹 6. Verifiser installasjonen
> python -c "import flask, pymysql; print('Alt fungerer')"




# Mariadb setup

🔹 7. Gå inn i MariaDB for første gang

Kjør MariaDB som root-bruker:

> sudo mariadb


Du skal nå se noe liknende:
MariaDB [(none)]>

🔹 8. Opprett en ny database

Bytt ut eks_database med navnet du vil ha på databasen:

> CREATE DATABASE eks_database;


Sjekk at databasen ble laget:

> SHOW DATABASES;

🔹 9. Opprett en ny bruker

Bytt ut:

eksempelbruker → ønsket brukernavn

eksempel_passord → et sikkert passord

> CREATE USER 'eksempelbruker'@'localhost' IDENTIFIED BY 'eksempel_passord';

🔹 10. Gi brukeren kun SELECT-rettigheter

Dette gjør at brukeren kun kan lese data, ikke endre, slette eller legge til noe.
Igjen bytt ut eksempelbruker og eks_database

> GRANT SELECT ON eks_database.* TO 'eksempelbruker'@'localhost';


Aktiver rettighetene:

> FLUSH PRIVILEGES;

🔹 11. Velg databasen

Bytt ut eks_database med riktig databasenavn:

> USE eks_database;



🔹 12. Opprett tabellen

Bytt ut eksemepl med ønsket table navn

> CREATE TABLE eksempel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


🔹 13.  Legg inn data, navn på produktet og pris. prisen må skrives som vist med to tall foran og etter punktum.
Navnene under er eksempel. For å legge til eller fjerne ett til produkt, fjern eller legg til elementet innenfor prantesene (inkludert parantesene) og legg til eller fjern et komma.

> INSERT INTO eksempel (name, price) 
VALUES 
    ('Energidrikk', 29.90),
    ('Vannflaske', 19.50),
    ('Sukkerfri sjokolade', 15.75);


🔹 14. Avslutt MariaDB
> EXIT;

eller
> \q



# Siste endringer


🔹 15. Generer sertifikat
For at Godot spillet skal fungere må vi bruke https, og får å gjøre det er den letteste måten å generere ett sertifikat. kjør kommandoen under i samme mappe/ samme sted som app.py.
> openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout domain.key -out domain.crt -sha256 -subj "/C=NO/ST=Oslo/L=Oslo/O=Example Company/CN=example.com"


🔹 16. Endre app.py.

Gå in i app.py med "nano app.py".
Bytt user, password og database med de navnene du lagde ista.

<pre>
def get_db():
  return pymysql.connect(
  host="localhost", 
  user="nettbutikk", 
  password="termin", 
  database="gamebutikk" 
  ) 
 </pre>





