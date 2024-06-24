USE baseveromelisa;
 
-- Tabla Libros
CREATE TABLE Libros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(45),
    fecha_publicacion date,
    autor VARCHAR(45),
    estado VARCHAR(20)  DEFAULT 'disponible'
);

-- Tabla Bibliotecarios
CREATE TABLE Bibliotecarios (
    id_bibliotecario INT PRIMARY KEY,
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    email VARCHAR(45)
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(45),
    apellido VARCHAR(45),
    email VARCHAR(45),
    telefono VARCHAR(15)
);

-- Tabla Prestamos
CREATE TABLE Prestamos (
    id_prestamo INT PRIMARY KEY,
    id_libro INT,
    id_usuario INT,
    id_bibliotecario INT,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecarios(id_bibliotecario)
);

-- Tabla AuditoriaPrestamos
CREATE TABLE AuditoriaPrestamos (
    id_auditoria INT PRIMARY KEY,
    id_prestamo INT,
    accion VARCHAR(45),
    fecha DATE,
    FOREIGN KEY (id_prestamo)
        REFERENCES Prestamos (id_prestamo)
);