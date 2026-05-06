#Alessandro, Eric, Hugo
#TABLA Y BBDD

#BBDD 
CREATE DATABASE lstaste_track;
USE lstaste_track;

#TABLAS
CREATE TABLE MD_plat (
id_plat INT PRIMARY KEY,
nom_plat VARCHAR(100) NOT NULL,
categoria VARCHAR(50),
descripcio VARCHAR(255),
preu_base DECIMAL(8,2) NOT NULL
);

CREATE TABLE comandes_raw (
id_comanda INT PRIMARY KEY,
id_taula INT NOT NULL,
data_comanda DATE NOT NULL,
hora_comanda TIME NOT NULL,
nom_plat VARCHAR(100) NOT NULL,
preu DECIMAL(8,2) NOT NULL,
quantitat INT NOT NULL,
id_cambrer INT NOT NULL,
valoracio TINYINT
);

CREATE TABLE comandes_net (
id_comanda INT PRIMARY KEY,
id_taula INT NOT NULL,
data_comanda DATE NOT NULL,
hora_comanda TIME NOT NULL,
nom_plat VARCHAR(100) NOT NULL,
preu DECIMAL(8,2) NOT NULL,
quantitat INT NOT NULL,
id_cambrer INT NOT NULL,
valoracio TINYINT,
cap_setmana CHAR(1),
import_total DECIMAL(10,2),
id_plat INT,
CONSTRAINT fk_comandes_net_raw
FOREIGN KEY (id_comanda) REFERENCES comandes_raw(id_comanda),
CONSTRAINT fk_comandes_net_plat
FOREIGN KEY (id_plat) REFERENCES MD_plat(id_plat)
);

CREATE TABLE auditoria_comandes (
id_audit_c INT PRIMARY KEY,
canvi VARCHAR(50) NOT NULL,
id_comanda INT NOT NULL,
usuari VARCHAR(50) NOT NULL,
data_operacio DATETIME NOT NULL,
detalls VARCHAR(255),
CONSTRAINT fk_aud_comanda
FOREIGN KEY (id_comanda) REFERENCES comandes_net(id_comanda)
);

CREATE TABLE auditoria_plats (
id_audit_p INT PRIMARY KEY,
canvi VARCHAR(50) NOT NULL,
id_plat INT NOT NULL,
usuari VARCHAR(50) NOT NULL,
data_operacio DATETIME NOT NULL,
detalls VARCHAR(255),
CONSTRAINT fk_aud_plat
FOREIGN KEY (id_plat) REFERENCES MD_plat(id_plat)
);

CREATE TABLE control_carrega (
id_control INT PRIMARY KEY,
nom_csv VARCHAR(255) NOT NULL,
files_inserides INT NOT NULL,
data_carrega DATETIME NOT NULL
);