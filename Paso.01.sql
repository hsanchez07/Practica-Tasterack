-- Alessandro, Eric Mitjavila i Hugo

DROP DATABASE IF EXISTS lstaste_track;
CREATE DATABASE lstaste_track
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE lstaste_track;

DROP TABLE IF EXISTS comandes_raw;
CREATE TABLE comandes_raw (
    id_comanda      INT             NOT NULL,
    id_taula        INT             NOT NULL,
    data_comanda    DATE            NOT NULL,
    hora_comanda    TIME            NOT NULL,
    nom_plat        VARCHAR(150)    NOT NULL,
    categoria_plat  VARCHAR(50)     NOT NULL,
    preu            DECIMAL(6,2)    NOT NULL,
    quantitat       INT             NOT NULL,
    id_cambrer      INT             NOT NULL,
    valoracio       INT             NULL,
    PRIMARY KEY (id_comanda)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


LOAD DATA INFILE 'C:/laragon/data/mysql-8.4/lstaste_track/comandes.csv'
INTO TABLE comandes_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    id_comanda,
    id_taula,
    data_comanda,
    hora_comanda,
    nom_plat,
    categoria_plat,
    preu,
    quantitat,
    id_cambrer,
    valoracio

);


SELECT * FROM comandes_raw LIMIT 5;
SELECT COUNT(*) AS total_registres FROM comandes_raw;