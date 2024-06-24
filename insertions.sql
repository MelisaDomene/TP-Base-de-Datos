USE baseveromelisa;

-- Insertar libros
INSERT INTO libros (id_libro, titulo, fecha_publicacion, autor, estado) VALUES
(1, 'Cien Años de Soledad', '1967-06-05', 'Gabriel Garcia Marquez', 'disponible'),
(2, 'Don Quijote de la Mancha', '1605-01-16', 'Miguel de Cervantes', 'prestado'),
(3, '1984', '1949-06-08', 'George Orwell', 'disponible'),
(4, 'El Principito', '1943-04-06', 'Antoine de Saint-Exupery', 'disponible'),
(5, 'La Divina Comedia', '1472-06-08', 'Dante Alighieri', 'prestado'),
(6, 'Orgullo y Prejuicio', '1813-01-28', 'Jane Austen', 'disponible'),
(7, 'Moby Dick', '1851-10-18', 'Herman Melville', 'disponible'),
(8, 'Hamlet', '1600-01-01', 'William Shakespeare', 'disponible'),
(9, 'Ulises', '1922-02-02', 'James Joyce', 'prestado'),
(10, 'En busca del tiempo perdido', '1913-11-14', 'Marcel Proust', 'disponible');

-- Insertar bibliotecarios
INSERT INTO bibliotecarios (id_bibliotecario, nombre, apellido, email) VALUES
(1, 'Ana', 'Perez', 'ana.perez@biblioteca.com'),
(2, 'Juan', 'Martinez', 'juan.martinez@biblioteca.com'),
(3, 'Lucia', 'Garcia', 'lucia.garcia@biblioteca.com');

-- Insertar usuarios
INSERT INTO usuarios (id_usuario, nombre, apellido, email, telefono) VALUES
(1, 'Carlos', 'Gonzalez', 'carlos.gonzalez@usuario.com', '555-1234'),actualizar_fecha_devolucion
(2, 'Maria', 'Lopez', 'maria.lopez@usuario.com', '555-5678'),
(3, 'Jose', 'Hernandez', 'jose.hernandez@usuario.com', '555-9101'),
(4, 'Laura', 'Fernandez', 'laura.fernandez@usuario.com', '555-1122');

-- Insertar prestamos
INSERT INTO prestamos (id_prestamo, id_libro, id_usuario, id_bibliotecario, fecha_prestamo, fecha_devolucion) VALUES
(1, 2, 1, 1, '2024-06-01', '2024-06-15'),
(2, 5, 2, 2, '2024-06-05', '2024-06-19'),
(3, 9, 3, 3, '2024-06-10', NULL);

-- Insertar auditoria prestamos
INSERT INTO AuditoriaPrestamos (id_auditoria, id_prestamo, accion, fecha) VALUES
(1, 1, 'prestamo', '2024-06-01'),
(2, 2, 'prestamo', '2024-06-05');

