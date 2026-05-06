-- Eric Mitjavila, Alessandro Bucovanu, Hugo Sánchez

CREATE DATABASE IF NOT EXISTS lstate_track_backup;

USE lstate_track;

DELIMITER $$

DROP PROCEDURE IF EXISTS fer_backup $$

CREATE PROCEDURE fer_backup()
BEGIN
    DECLARE v_taula VARCHAR(100);
    DECLARE acabat INT DEFAULT 0;
    DECLARE v_data VARCHAR(20);

    DECLARE cursor_taules CURSOR FOR
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'lstate_track'
        AND table_name IN ('comandes_raw', 'comandes_net', 'md_plat', 'control_carregues');

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET acabat = 1;

    SET v_data = DATE_FORMAT(CURDATE(), '%Y%m%d');

    OPEN cursor_taules;

    bucle: LOOP
        FETCH cursor_taules INTO v_taula;

        IF acabat = 1 THEN
            LEAVE bucle;
        END IF;

        SET @v_sql = CONCAT(
            'CREATE TABLE lstate_track_backup.',
            v_taula, '_', v_data,
            ' AS SELECT * FROM lstate_track.',
            v_taula
        );

        PREPARE stmt FROM @v_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

    END LOOP;

    CLOSE cursor_taules;
END $$

DROP EVENT IF EXISTS backup_setmanal $$

CREATE EVENT backup_setmanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2026-05-03 23:00:00'
ENDS '2026-12-31 23:00:00'
DO
BEGIN
    CALL fer_backup();
END $$

DELIMITER ;