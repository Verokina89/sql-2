/* Relación tipo 1:1 One-to-One */
-- PASO 1
--Tu código aquí
CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY, --Clave primaria que se incrementa automáticamente con cada nueva entrada o registro (fila)y el Primary key no prmite valores nulos, .
nombre VARCHAR(50) NOT NULL, --Campos de texto con restriccion de no ser nulo y con un maximo de caracteres.
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
edad INT NOT NULL --campo numerico
);

INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);


-- PASO 2
--Tu código aquí
CREATE TABLE roles (
id_rol INT AUTO_INCREMENT PRIMARY KEY,  --clave primaria sirve para relacionar diferentes tablas entre clavs foraneas
nombre_rol VARCHAR(50) NOT NULL --campo d texto q no puede ser nulo
);

INSERT INTO roles (nombre_rol) VALUES  --inserta datos en la tabla roles.
('Bronce'),
('Plata'),
('Oro'),
('Platino');


-- PASO 3
-- Tu código aquí
/*Añadir(alterar) columna id_rol a usuarios y establecer clave foránea */
ALTER TABLE usuarios ADD COLUMN id_rol INT;  --agrega (crea dentro tambien) la columna id_rol a la tabla usuarios. Si agregamos un `NOT NULL` da error ya que no puede estar vacia
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);  --establece la CLAVE FORANEA, es decir que la hace intelignte. mejor crearla antes por esta razon de evitar registros herfanos

--actualiza la columna id_rol en la tabla usuarios
UPDATE usuarios SET id_rol = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);
UPDATE usuarios SET id_rol = 2 WHERE id_usuario IN (2, 6, 10, 14, 18);
UPDATE usuarios SET id_rol = 3 WHERE id_usuario IN (3, 7, 11, 15, 19);
UPDATE usuarios SET id_rol = 4 WHERE id_usuario IN (4, 8, 12, 16, 20);

-- PASO 4
-- Tu código aquí
/*Se usa JOIN para combinar los datos de las tablas usuarios y roles */
SELECT 
    usuarios.id_usuario, 
    usuarios.nombre, 
    usuarios.apellido, 
    usuarios.email, 
    usuarios.edad, 
    roles.nombre_rol
FROM statements.usuarios
JOIN roles ON statements.usuarios.id_rol = roles.id_rol;


-- Relación tipo 1:N (One-to-Many)
-- PASO 1
-- Tu código aquí
SELECT * FROM statements.categorias;

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES   --inserta datos en l tabla categorias
('Electronicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

-- PASO 2
-- Tu código aquí
--Se añade en la tabla `usuarios` la columna `id_categorias`
SELECT * FROM statements.usuarios; --poder visulizar y comprobar cada paso
SELECT * FROM statements.categorias; 

ALTER TABLE statements.usuarios ADD COLUMN id_categoria INT;

-- PASO 3
-- Tu código aquí
/*Asina a cada usuario la categoria*/
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (2, 6, 10, 14, 18);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (3, 7, 11, 15, 19);
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (4, 8, 12, 16, 20);

-- PASO 4
-- Tu código aquí
--combinar los datos de `roles y categorias`
SELECT * FROM statements.categorias; 

SELECT 
	usuarios.id_usuario, 
    usuarios.nombre, 
    usuarios.apellido, 
    usuarios.email, 
    usuarios.edad, 
    roles.nombre_rol, 
    categorias.nombre_categoria
FROM statements.usuarios
JOIN roles ON statements.usuarios.id_rol = roles.id_rol
JOIN categorias ON statements.usuarios.id_categoria = categorias.id_categoria;

ALTER TABLE categorias ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);  --Se altera la clave ususarios, establece la CLAVE FORANEA, es decir que la hace intelignte. mejor crearla antes por esta razon de evitar registros herfanos

/* Relación tipo N:M (Many-to-Many)*/
-- PASO 1
-- Tu código aquí 
/*Crear tabla intermedia `usuarios_categorias`*/
SELECT * FROM statements.usuarios_categorias;

CREATE TABLE statements.usuarios_categorias (
    id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_categoria INT,
    --id_usuario_categoria PRIMARY KEY,  --se estable en la que tiene que facilitar la identificacion. Esta estructura es recomndada (se quita de la de la linea 144)
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- PASO 2
-- Tu código aquí
/*asocia usuaios a categria*/
SELECT * FROM statements.usuarios_categorias;

INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),(3, 6), 
(3, 7),(4, 8), (4, 9), 
(4, 10);

-- PASO 3
-- Tu código aquí
/*JOIN de las tablas roles, categorias y con la tabla intermedia*/
SELECT * FROM statements.usuarios_categorias;

SELECT 
    usuarios.id_usuario, 
    usuarios.nombre, 
    usuarios.apellido, 
    usuarios.email, 
    usuarios.edad,
    roles.nombre_rol, 
    categorias.nombre_categoria   
FROM statements.usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol
JOIN usuarios_categorias ON usuarios.id_usuario = usuarios_categorias.id_usuario
JOIN categorias ON usuarios_categorias.id_categoria = categorias.id_categoria 
ORDER BY id_usuario ASC;  --ordenar por id_usuarios


/*
SELECT 
    usuarios.id_usuario, 
    usuarios.nombre, 
    usuarios.apellido, 
    usuarios.email, 
    usuarios.edad,
    roles.nombre_rol, 
    categorias.nombre_categoria   
FROM statements.usuarios
JOIN( role, usuarios_categorias, categorias)
ON usuarios.id_rol = roles.id_rol
AND usuarios.id_categoria = usuarios_categorias.id_usuario
AND usuarios_categorias.id_categoria = categorias.id_categoria 
*/