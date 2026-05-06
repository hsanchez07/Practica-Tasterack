#Alessandro, Eric y Hugo
#PASO 3 carregar_comandes_net modificado (antes de hacer exportar_control)
DELIMITER $$

CREATE PROCEDURE carregar_comandes_net2(IN p_nom_fitxer VARCHAR(255))
BEGIN
  TRUNCATE TABLE comandes_net; # Evitamos llaves primarias duplicadas

#Insertamos todos los campos de raw a net
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
#Hacemos un select para acabar insertando los campos adicionales (valoracio, cap_setmana i import_total)
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
    DAYOFWEEK(cr.data_comanda) IN (1, 7), # 1 = sábado 7 = domingo
    cr.preu * cr.quantitat,
    NULL
  FROM comandes_raw AS cr;
#Insert para guardar el registro con nombre de fichero personalizado
  INSERT INTO control_carregues (nom_fitxer, files_inserides, data_carrega)
  VALUES (p_nom_fitxer, ROW_COUNT(), NOW());
END$$

DELIMITER ;