-- Eric Mitjavila, Alessandro Bucovanu, Hugo Sánchez
USE lstate_track;

DELIMITER $$

DROP PROCEDURE IF EXISTS sincronitzar_cataleg $$

CREATE PROCEDURE sincronitzar_cataleg()
BEGIN
    INSERT INTO md_plat (nom_plat, categoria, descripcio, preu_base)
    SELECT DISTINCT LOWER(TRIM(nom_plat)), IFNULL(categoria_plat, 'sense categoria'),
           'Descripció pendent', preu
    FROM comandes_raw
    WHERE LOWER(TRIM(nom_plat)) NOT IN (
        SELECT LOWER(TRIM(nom_plat)) FROM md_plat
    );

    UPDATE md_plat
    SET categoria = 'sense categoria'
    WHERE categoria IS NULL OR categoria = '';

    UPDATE md_plat
    SET descripcio = 'Descripció pendent'
    WHERE descripcio IS NULL OR descripcio = '';
END $$

DELIMITER ;