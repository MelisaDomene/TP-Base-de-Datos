-- 2.Crear procedimiento almacenado registrar_prestamo --

DELIMITER //

CREATE PROCEDURE registrar_prestamo(
    IN p_id_libro INT,
    IN p_id_usuario INT,
    IN p_fecha_prestamo DATE
)
BEGIN
    DECLARE libro_prestado BOOLEAN;

    -- Verificar si el libro ya está prestado
    SELECT COUNT(*)
    INTO libro_prestado
    FROM Prestamos
    WHERE id_libro = p_id_libro AND fecha_devolucion IS NULL;

    IF libro_prestado > 0 THEN
        -- El libro ya está prestado, lanzar un error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El libro ya está prestado y no se puede prestar de nuevo hasta que sea devuelto.';
    ELSE
        -- Insertar el nuevo préstamo
        INSERT INTO Prestamos (id_libro, id_usuario, id_bibliotecario, fecha_prestamo, fecha_devolucion)
        VALUES (p_id_libro, p_id_usuario, 1, p_fecha_prestamo, NULL);

        -- Actualizar el estado del libro a 'prestado'
        UPDATE Libros
        SET estado = 'prestado'
        WHERE id_libro = p_id_libro;

        -- Registrar la acción en AuditoriaPrestamos
        INSERT INTO AuditoriaPrestamos (id_prestamo, accion, fecha)
        VALUES (LAST_INSERT_ID(), 'prestamo', p_fecha_prestamo);
    END IF;
END //

DELIMITER ;


-- 3. Creación de vista vista_prestamos_actuales --

CREATE VIEW vista_prestamos_actuales AS
SELECT 
    p.id_prestamo,
    l.titulo AS nombre_libro,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    p.fecha_prestamo
FROM 
    prestamos p
JOIN 
    Libros l ON p.id_libro = l.id_libro
JOIN 
    Usuarios u ON p.id_usuario = u.id_usuario
WHERE 
    p.fecha_devolucion IS NULL;

-- 4. Creación del Trigger actualizar_fecha_devolucion--

DELIMITER //

CREATE TRIGGER actualizar_fecha_devolucion
BEFORE UPDATE ON prestamos
FOR EACH ROW
BEGIN
    IF NEW.fecha_devolucion IS NOT NULL AND OLD.fecha_devolucion IS NULL THEN
        SET NEW.fecha_devolucion = CURDATE();
    END IF;
END //

DELIMITER ;


-- 5.  Transacción para registrar un nuevo préstamo

START TRANSACTION;

-- Variables
SET @id_libro = 8;
SET @id_usuario = 4;
SET @id_bibliotecario = 1;
SET @fecha_prestamo = '2024-06-22';

-- Insertar el nuevo préstamo
INSERT INTO prestamos (id_libro, id_usuario, id_bibliotecario, fecha_prestamo, fecha_devolucion)
VALUES (@id_libro, @id_usuario, @id_bibliotecario, @fecha_prestamo, NULL);

-- Obtener el id del préstamo recién insertado
SET @id_prestamo = LAST_INSERT_ID();

-- Actualizar el estado del libro a 'prestado'
UPDATE Libros
SET estado = 'prestado'
WHERE id_libro = @id_libro;

-- Registrar la operación en AuditoriaPrestamos
INSERT INTO AuditoriaPrestamos (id_prestamo, accion, fecha)
VALUES (@id_prestamo, 'prestamo', CURDATE());

COMMIT;


