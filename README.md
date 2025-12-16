# Terminoppgave
I dette prosjektet hoster jeg mitt eget Godot spill med en tilhørende nettbutikk med flask på Raspberry Pi. Dette prosjektet er satt opp på Raspberry Pi med Ubuntu. 



# Brukerveiledning


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
> python -c "import flask, pymysql; print('Alt fungerer!')"

🔹 7. Test MariaDB
> sudo mariadb
