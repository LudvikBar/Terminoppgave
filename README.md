# Terminoppgave


# Ideer
Jeg har tre ideer. Jeg tenkte enten å lage en nettbutikk med forskjellige produkter, en sosiale medier side til alle på IM eller en side der jeg kan hoste Godot spillet mitt på en eller annen måte.


# Utdype ideene
På nettbutikken skal man kunne bla gjennom mange produkter med vær sin info. Produktene skal lagres i en database. Jeg tenkte kanskje også å lage en innlogging. Når man er innlogget kan man lagge en liste med favorittproduktene sine. Denne listen skal lagres til vær person/loggin.

På sosiale medier siden tenkte jeg å ha loggin med enkelt brukernavn og passord. Det skal være en åpen chatt til alle på siden og kanskje noen andre chatter. Jeg tenker også å legge in profilbilde. Jeg skal lagre brukerene i database. Når man først går på nettsiden får mann opp en knapp for å logge in og en for å registrere deg.

På Godot host nettsiden tenkte jeg enten å prøve å hoste koden rett inn med flask eller liknende eller lage en nedlasting for spillet. Da kan jeg legge in en chatt på nettsiden også for å chatte om spillet. Kanskje en spillguide og noe annet også.

# vertøy jeg skal bruke
Jeg Skal Bruke HTML og CSS på alle ideene. Jeg skal også sette opp database med mariadb på pien gjennom terminalen med ssh. Jeg trenger også logikk språk (python) til alle fordi jeg vil ha innlogging og litt annet, da må koden vite når den skal legge en ny bruker inn i tabellen. 


# Hvordan skal jeg vise kompetanse i faget?
Dokumentere godt
Variert innhold/bruk av verktøy og kompetanseområdet 
God planlegging




/nettbutikk-prosjekt
│
├── backend/
│   ├── config/
│   │   └── db_config.example.json   # Eksempel på DB-innstillinger
│   │
│   ├── controllers/                 # Logikk
│   │   ├── authController.js        # Innlogging / registrering
│   │   ├── productController.js     # Produkthåndtering
│   │   └── favoritesController.js   # Favorittliste
│   │
│   ├── models/                      # DB-modeller/tabeller
│   │   ├── userModel.js
│   │   ├── productModel.js
│   │   └── favoriteModel.js
│   │
│   ├── routes/                      # API-endepunkter
│   │   ├── authRoutes.js
│   │   ├── productRoutes.js
│   │   └── favoriteRoutes.js
│   │
│   │
│   ├── database/
│   │   ├── migrations/              # SQL-scripts
│   │   └── seed/                    # Testdata
│   │
│   ├── app.js                       # Main backend app
│   └── package.json (hvis Node)
│
├── frontend/
│   ├── assets/
│   │   ├── css/
│   │   │   └── style.css
│   │   ├── img/
│   │   └── js/
│   │       └── script.js
│   │
│   ├── pages/
│   │   ├── index.html               # Forside
│   │   ├── Register.html            # Registreringside
│   │   ├── favorites.html           # Favorittliste
│   │   └── login.html               # Innlogging
│   │
│   └── components/                  # Gjenbrukbare html-snippets
│       ├── header.html
│       └── footer.html
│
├── docs/                            # Dokumentasjon
│   ├── README.md
│   └── Logg.docx
│
├── scripts/                         # Eventuelle install/dev scripts
│   └── backup_db.sh
│
├── .env.example                     # Template env-variabler
├── README.md
└── .gitignore



