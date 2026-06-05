-- =============================================================
-- TIFOSI - Création du schéma de la base de données
-- =============================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur et attribution des droits
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi2024!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- Sélection de la base de données
USE tifosi;

-- =============================================================
-- TABLE : ingredient
-- =============================================================
CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT          NOT NULL AUTO_INCREMENT,
    nom           VARCHAR(50)  NOT NULL UNIQUE,
    PRIMARY KEY (id_ingredient)
);

-- =============================================================
-- TABLE : marque
-- =============================================================
CREATE TABLE IF NOT EXISTS marque (
    id_marque INT         NOT NULL AUTO_INCREMENT,
    nom       VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_marque)
);

-- =============================================================
-- TABLE : boisson
-- =============================================================
CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT         NOT NULL AUTO_INCREMENT,
    nom        VARCHAR(50) NOT NULL UNIQUE,
    id_marque  INT         NOT NULL,
    PRIMARY KEY (id_boisson),
    CONSTRAINT fk_boisson_marque
        FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================================================
-- TABLE : foccacia
-- =============================================================
CREATE TABLE IF NOT EXISTS foccacia (
    id_focaccia INT           NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)   NOT NULL UNIQUE,
    prix        DECIMAL(5, 2) NOT NULL CHECK (prix > 0),
    PRIMARY KEY (id_focaccia)
);

-- =============================================================
-- TABLE : comprend  (liaison foccacia <-> ingredient)
-- =============================================================
CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia   INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite      INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_comprend_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES foccacia(id_focaccia)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comprend_ingredient
        FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================================================
-- TABLE : Client
-- =============================================================
CREATE TABLE IF NOT EXISTS client (
    id_client   INT          NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)  NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT          NOT NULL,
    PRIMARY KEY (id_client)
);

-- =============================================================
-- TABLE : menu
-- =============================================================
CREATE TABLE IF NOT EXISTS menu (
    id_menu INT           NOT NULL AUTO_INCREMENT,
    nom     VARCHAR(50)   NOT NULL UNIQUE,
    prix    DECIMAL(5, 2) NOT NULL CHECK (prix > 0),
    PRIMARY KEY (id_menu)
);

-- =============================================================
-- TABLE : contient  (liaison menu <-> boisson)
-- =============================================================
CREATE TABLE IF NOT EXISTS contient (
    id_menu    INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contient_boisson
        FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================================================
-- TABLE : est_constitue  (liaison menu <-> foccacia)
-- =============================================================
CREATE TABLE IF NOT EXISTS est_constitue (
    id_menu     INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu, id_focaccia),
    CONSTRAINT fk_est_constitue_menu
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_est_constitue_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES foccacia(id_focaccia)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================================================
-- TABLE : achete  (liaison client <-> menu)
-- =============================================================
CREATE TABLE IF NOT EXISTS achete (
    id_client  INT  NOT NULL,
    id_menu    INT  NOT NULL,
    date_achat DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achete_client
        FOREIGN KEY (id_client) REFERENCES client(id_client)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_achete_menu
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE RESTRICT ON UPDATE CASCADE
);