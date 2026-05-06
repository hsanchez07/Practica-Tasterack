#Alessandro, Eric y Hugo
#PASO 4 tabla md_plat

USE lstate_track;

#--1  Creamos lo primero de todo, la tabla md_plat con este aspecto:
CREATE TABLE MD_plat (
  id_plat INT AUTO_INCREMENT PRIMARY KEY,
  nom_plat VARCHAR(100) NOT NULL UNIQUE,
  categoria VARCHAR(50),
  descripcio TEXT,
  preu_base DECIMAL(6,2)
);

#--2 Poblamos de platos con comandes_raw
INSERT INTO MD_plat (nom_plat, categoria, descripcio, preu_base)
SELECT DISTINCT #No repetimos platos
  TRIM(LOWER(nom_plat)) AS nom_plat,
  categoria_plat,
  NULL,
  preu
FROM comandes_raw;

#--3 Añadimos la columna id_plat en comandes_net
ALTER TABLE comandes_net
ADD COLUMN id_plat INT;

#--4 Actualizamos id_plat con JOIN nom_plat (safe update desactivado)
UPDATE comandes_net cn
JOIN MD_plat mp
  ON TRIM(LOWER(cn.nom_plat)) = mp.nom_plat #Eliminamos espacios sobrantes con TRIM y convertimos el texto en minúsculas, así tratamos todos los platos igual
SET cn.id_plat = mp.id_plat; 

#--5 Finalmente añadimos la fk id_plat
ALTER TABLE comandes_net
ADD CONSTRAINT fk_comandes_net_md_plat
FOREIGN KEY (id_plat) REFERENCES MD_plat(id_plat);











