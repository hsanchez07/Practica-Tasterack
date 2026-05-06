#Alessandro, Eric y Hugo
#PASO 2 creación carregar_comandes_net
DELIMITER $$

DROP PROCEDURE IF EXISTS carregar_comandes_net $$

CREATE PROCEDURE carregar_comandes_net()
BEGIN
  INSERT INTO comandes_net(
    id_comanda,
    id_taula,
    data_comanda,
    hora_comanda,
    nom_plat,
    categoria_plat,
    preu,
    quantitat,
    id_cambrer,
    valoracio,
    es_cap_de_setmana,
    import_total,
    id_plat
  )
  SELECT
    cr.id_comanda,
    cr.id_taula,
    cr.data_comanda,
    cr.hora_comanda,
    cr.nom_plat,
    cr.categoria_plat,
    cr.preu,
    cr.quantitat,
    cr.id_cambrer,
    IF(cr.valoracio IS NULL, 0, cr.valoracio),
    DAYOFWEEK(cr.data_comanda) IN (1, 7),
    cr.preu * cr.quantitat,
    NULL
  FROM comandes_raw AS cr;
END $$

DELIMITER ;