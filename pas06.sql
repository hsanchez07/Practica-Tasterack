-- Eric Mitjavila, Alessandro Bucovanu, Hugo Sánchez
USE lstaste_track;

DROP TABLE IF EXISTS auditoria_comandes;
DROP TABLE IF EXISTS auditoria_plats;

CREATE TABLE auditoria_comandes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operacio VARCHAR(20),
    id_comanda INT,
    usuari VARCHAR(100),
    data_operacio DATETIME,
    detall TEXT
);

CREATE TABLE auditoria_plats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operacio VARCHAR(20),
    id_plat INT,
    usuari VARCHAR(100),
    data_operacio DATETIME,
    detall TEXT
);

DELIMITER $$

DROP TRIGGER IF EXISTS trg_insert_comandes $$
CREATE TRIGGER trg_insert_comandes
AFTER INSERT ON comandes_net
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_comandes
    VALUES (NULL, 'INSERT', NEW.id_comanda, CURRENT_USER(), NOW(),
            CONCAT('Insert comanda amb plat ', NEW.nom_plat));
END $$

DROP TRIGGER IF EXISTS trg_update_plats $$
CREATE TRIGGER trg_update_plats
AFTER UPDATE ON md_plat
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_plats
    VALUES (NULL, 'UPDATE', OLD.id_plat, CURRENT_USER(), NOW(),
            CONCAT('Nom antic: ', OLD.nom_plat, ' Nom nou: ', NEW.nom_plat));
END $$

DROP TRIGGER IF EXISTS trg_delete_plats $$
CREATE TRIGGER trg_delete_plats
AFTER DELETE ON md_plat
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_plats
    VALUES (NULL, 'DELETE', OLD.id_plat, CURRENT_USER(), NOW(),
            CONCAT('Plat eliminat: ', OLD.nom_plat));
END $$