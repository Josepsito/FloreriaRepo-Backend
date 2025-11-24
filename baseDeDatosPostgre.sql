

CREATE DATABASE floreriadb;
\c floreriadb;

-- TABLA USUARIOS
CREATE TABLE usuarios (
    usuarioid SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    rol VARCHAR(20) NOT NULL DEFAULT 'USUARIO' -- MySQL ENUM cambiado a VARCHAR
);

-- TABLA CATEGORIAS
CREATE TABLE categorias (
    categoriaid SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    imagenurl VARCHAR(500) NOT NULL,
    imagen_secundariaurl VARCHAR(500) NOT NULL
);

-- TABLA PRODUCTOS
CREATE TABLE productos (
    productoid SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagenurl VARCHAR(300),
    categoriaid INT,
    FOREIGN KEY (categoriaid) REFERENCES categorias(categoriaid)
);

-- TABLA CARRITO
CREATE TABLE carrito (
    carritoid SERIAL PRIMARY KEY,
    usuarioid INT,
    productoid INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (usuarioid) REFERENCES usuarios(usuarioid),
    FOREIGN KEY (productoid) REFERENCES productos(productoid)
);

-- TABLA PEDIDOS
CREATE TABLE pedidos (
    pedidoid SERIAL PRIMARY KEY,
    usuarioid INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    total DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (usuarioid) REFERENCES usuarios(usuarioid)
);

-- TABLA DETALLE PEDIDO
CREATE TABLE detallepedido (
    detalleid SERIAL PRIMARY KEY,
    pedidoid INT,
    productoid INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedidoid) REFERENCES pedidos(pedidoid),
    FOREIGN KEY (productoid) REFERENCES productos(productoid)
);

-- TABLA ENVIOS
CREATE TABLE envios (
    envioid SERIAL PRIMARY KEY,
    pedidoid INT NOT NULL,
    direccion_envio VARCHAR(200) NOT NULL,
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais VARCHAR(50),
    empresa_envio VARCHAR(100),
    fecha_envio TIMESTAMP,
    fecha_entrega_estimada TIMESTAMP,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    FOREIGN KEY (pedidoid) REFERENCES pedidos(pedidoid)
);

-- INSERTAR CATEGORIAS
INSERT INTO categorias (nombre, descripcion, imagenurl, imagen_secundariaurl) VALUES
('Cumpleaños', 'Flores dedicadas a cumpleañeros', 'https://images.pexels.com/photos/34241942/pexels-photo-34241942.jpeg', 'https://i.postimg.cc/zB7gN3S0/cumplea-os.png'),
('Aniversario', 'Para parejas que festejan su fecha especial', 'https://images.pexels.com/photos/169198/pexels-photo-169198.jpeg', 'https://i.postimg.cc/qvNSC3N4/aniversario.png'),
('Funerales', 'Homenaje a las personas queridas', 'https://images.pexels.com/photos/10499692/pexels-photo-10499692.jpeg', 'https://i.postimg.cc/ZnDjTwxk/funerales.png'),
('San Valentín', 'Día de los enamorados', 'https://images.pexels.com/photos/6551792/pexels-photo-6551792.jpeg', 'https://i.postimg.cc/Cx8JgHZG/san-Valentin.png'),
('Día de la Madre', 'Dedica estas flores a tu queria madre', 'https://images.pexels.com/photos/1158961/pexels-photo-1158961.jpeg', 'https://i.postimg.cc/tgt51qNz/DMadre.png'),
('Día del Padre', 'Regala a tu padre unas flores especiales', 'https://images.pexels.com/photos/16225168/pexels-photo-16225168.jpeg', 'https://i.postimg.cc/y8Tjx6P7/DPadre.png'),
('Dia de las flores amarillas', 'Celebra con las mejores flores amarillas', 'https://images.pexels.com/photos/1287124/pexels-photo-1287124.jpeg', 'https://i.postimg.cc/V62BpJf8/Dflores-Amarillas.png'),
('Agradecimiento', 'Festeja con cariño con esa persona especial', 'https://images.pexels.com/photos/1196445/pexels-photo-1196445.jpeg', 'https://i.postimg.cc/FKDS57xd/agradecimiento.png');

-- INSERTAR PRODUCTOS
INSERT INTO productos (nombre, descripcion, precio, stock, imagenurl, categoriaid) VALUES
('Ramo de rosas', 'Ramo de rosas rosadas', 25.00, 10, 'https://i0.wp.com/floresyregalosmx.com/wp-content/uploads/Captura-de-pantalla-2024-12-27-a-las-6.16.39%E2%80%AFp.m.png?fit=600%2C780&ssl=1', 1),
('Cesta floral', 'Cesta de flores para cumpleaños', 45, 5, 'https://undetalle.com.pe/wp-content/uploads/2023/08/cesta-de-pino-con-24-rosas-mix.webp', 1),
('Tulipanes', 'Conjunto de tulipanes', 32, 20, 'https://undetalle.com.pe/wp-content/uploads/2023/08/arreglo-de-12-tulipanes-mix.webp', 2),
('Planta felicidad', 'Planta pequeña de felicidad', 33.50, 35, 'https://undetalle.com.pe/wp-content/uploads/2024/09/plantita-de-felicidad-con-foto.webp', 2),
('Arreglo funerario', 'Arreglo funerario de 2 flores', 30.50, 5, 'https://floreriabellas.com/wp-content/uploads/2019/07/corona-funebre-8.jpg', 3),
('Corona fúnebre ', 'Corona para difuntos', 30.50, 5, 'https://www.enviafloresfunebres.com/imagenes/imgproducto/500coronas-para-difuntos-chico-2.jpg', 3),
('Girasoles', 'Girasoles para San valentín', 25, 5, 'https://magia.pe/cdn/shop/files/magia-pe-box-guinda-girasoles-2_ae4c68bb-3e18-48a8-817d-d2b2704d4f09_900x.jpg?v=1737759235', 4),
('Ramo de rosas', 'Ramo de rosas para tu pareja', 25, 5, 'https://undetalle.com.pe/wp-content/uploads/2025/01/ramo-de-15-rosas-rojas.webp', 4),
('Ramo de rosas y astromelias', 'Ramo conjunto de rosas y astromelias', 25, 5, 'https://lamour.pe/cdn/shop/files/Ramo-de-Rosas-y-Astromelias-Destellos-1.jpg?v=1736607777&width=1080', 5),
('Flores rosas y blancas', 'Conjunto de flores rosas y blancas', 30, 20, 'https://alore.pe/wp-content/uploads/2025/04/Caja-de-flores-para-mama-con-chocolates-500x667.webp', 5),
('Rosas azules', 'Arreglo de 12 rosas', 30.50, 5, 'https://undetalle.com.pe/wp-content/uploads/2024/12/florero-de-12-rosas-azules.webp', 6),
('Hortensias azules', 'Arreglo de hortensias azules', 30.50, 5, 'https://alirosas.pe/wp-content/uploads/2021/06/hortensiasglobo.jpg', 6),
('Ramo de girasoles', 'Ramo de girasoles ', 30.50, 5, 'https://floreriamiraflores.com/wp-content/uploads/2024/07/32-1-800x800.jpg', 7),
('Flores amarillas', 'Flores amarillas variadas', 30.50, 5, 'https://d20f60vzbd93dl.cloudfront.net/uploads/tienda_014965/tienda_014965_07e948bee075681400cd86a42104471acfd29e8a_producto_large_90.jpeg', 7),
('Ramo de tulipanes', 'Tulipanes de varios colores', 30.50, 5, 'https://floresyservicios.com/wp-content/uploads/2020/04/91--300x300.jpg', 8),
('Nombre del producto 14', 'Descripción del producto 2', 30.50, 5, 'https://latinflores.com/cdn/shop/files/mixfloral_afb9e1d9-c090-49c4-aa80-c7a7a5549db5.jpg?v=1746629975&width=533', 8);
