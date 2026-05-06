#Alessandro, Eric y Hugo 
#PASO 3 "exportar_control"
DELIMITER $$
CREATE PROCEDURE exportar_control(IN p_ruta VARCHAR(500))
BEGIN
   #Usamos senténcia dinámica para convertir a texto literal el parámetro p_ruta, si no lo hacemos así da error el procedure y no deja crearlo
  SET @aux = CONCAT(
    "SELECT id, nom_fitxer, files_inserides, data_carrega ",
    "FROM control_carregues ",
    "INTO OUTFILE '", REPLACE(p_ruta, "'", "\\'"), "' ",
    "FIELDS TERMINATED BY ',' ",
    "ENCLOSED BY '\"' ",
    "LINES TERMINATED BY '\n'"
  );

  PREPARE stmt FROM @aux;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$

DELIMITER ;