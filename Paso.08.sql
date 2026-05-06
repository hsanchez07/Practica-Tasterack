-- Alessandro, Eric Mitjavila i Hugo

DROP USER IF EXISTS 'tt_data_loader'@'localhost';
DROP USER IF EXISTS 'tt_user'@'localhost';
DROP USER IF EXISTS 'tt_backup'@'localhost';
DROP USER IF EXISTS 'tt_auditor'@'localhost';
DROP USER IF EXISTS 'tt_admin'@'localhost';

CREATE USER 'tt_data_loader'@'localhost' IDENTIFIED BY 'Loader@1234';

GRANT FILE ON *.* TO 'tt_data_loader'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE
    ON lstaste_track.comandes_raw
    TO 'tt_data_loader'@'localhost';

CREATE USER 'tt_user'@'localhost' IDENTIFIED BY 'User@1234';

GRANT FILE ON *.* TO 'tt_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE
    ON lstaste_track.*
    TO 'tt_user'@'localhost';
GRANT EXECUTE
    ON lstaste_track.*
    TO 'tt_user'@'localhost';

CREATE USER 'tt_backup'@'localhost' IDENTIFIED BY 'Backup@1234';

GRANT SELECT
    ON lstaste_track.*
    TO 'tt_backup'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, EXECUTE
    ON lstaste_track_backup.*
    TO 'tt_backup'@'localhost';

CREATE USER 'tt_auditor'@'localhost' IDENTIFIED BY 'Auditor@1234';

GRANT SELECT
    ON lstaste_track.*
    TO 'tt_auditor'@'localhost';
GRANT SELECT
    ON lstaste_track_backup.*
    TO 'tt_auditor'@'localhost';

CREATE USER 'tt_admin'@'localhost' IDENTIFIED BY 'Admin@1234';

GRANT ALL PRIVILEGES
    ON lstaste_track.*
    TO 'tt_admin'@'localhost';
GRANT ALL PRIVILEGES
    ON lstaste_track_backup.*
    TO 'tt_admin'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'tt_data_loader'@'localhost';
SHOW GRANTS FOR 'tt_user'@'localhost';
SHOW GRANTS FOR 'tt_backup'@'localhost';
SHOW GRANTS FOR 'tt_auditor'@'localhost';
SHOW GRANTS FOR 'tt_admin'@'localhost';



-- Comprovaciones

-- tt_data_loader:

-- CONCEDIDO
-- SELECT * FROM lstaste_track.comandes_raw LIMIT 3;

-- DENEGADO
-- CREATE TABLE lstaste_track.prova (id INT);

-- tt_user:

-- CONCEDIDO
-- SELECT * FROM lstaste_track.comandes_raw LIMIT 3;

-- DENEGADO
-- CREATE TABLE lstaste_track.prova (id INT);

-- tt_backup:

-- CONCEDIDO
-- SELECT * FROM lstaste_track.comandes_raw LIMIT 3;

-- DENEGADO
-- INSERT INTO lstaste_track.comandes_raw (id_comanda, id_taula, data_comanda, hora_comanda, nom_plat, categoria_plat, preu, quantitat, id_cambrer) VALUES (999, 1, '2024-01-01', '13:00', 'Test', 'beguda', 3.00, 1, 1);

-- tt_auditor:

-- CONCEDIDO
-- SELECT * FROM lstaste_track.comandes_raw LIMIT 3;

-- DELETE FROM lstaste_track.comandes_raw WHERE id_comanda = 1;

-- tt_admin:

-- CONCEDIDO
-- SELECT * FROM lstaste_track.comandes_raw LIMIT 3;

-- DENEGAT
-- GRANT SELECT ON lstaste_track.* TO 'tt_auditor'@'localhost';
