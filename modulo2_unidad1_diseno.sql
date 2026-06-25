-- =============================================================
-- Modulo 2 - Unidad 1: Diseño de estructura de base de datos
-- Sistema de gestión de ventas
-- Compatible con PostgreSQL y SQL Server
-- =============================================================

-- Si las tablas ya existen (por una ejecución anterior), las eliminamos
-- primero para poder volver a crearlas sin errores.
-- El orden importa: productos antes de clientes (por si en el futuro
-- hay claves foráneas entre ellas).
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- ---------------------------------------------------------
-- Tabla: clientes
-- ---------------------------------------------------------
CREATE TABLE clientes (
    -- id_cliente: identificador único del cliente, número entero
    id_cliente INT PRIMARY KEY,

    -- nombre: texto corto, máximo 100 caracteres, suficiente para nombre completo
    nombre VARCHAR(100) NOT NULL,

    -- perfil_bio: texto largo sin límite fijo de caracteres, ideal para biografías o notas extensas
    perfil_bio TEXT,

    -- fecha_registro: solo necesitamos la fecha (sin hora), por eso usamos DATE
    fecha_registro DATE
);

-- ---------------------------------------------------------
-- Tabla: productos
-- ---------------------------------------------------------
CREATE TABLE productos (
    -- id_producto: identificador único del producto, número entero
    id_producto INT PRIMARY KEY,

    -- descripcion: texto corto, máximo 255 caracteres, para el nombre/descripción del producto
    descripcion VARCHAR(255) NOT NULL,

    -- precio: usamos DECIMAL en lugar de FLOAT porque para dinero necesitamos precisión exacta,
    -- sin errores de redondeo. DECIMAL(10,2) permite hasta 10 dígitos en total, 2 de ellos decimales
    precio DECIMAL(10, 2) NOT NULL,

    -- esta_activo: usamos un valor booleano para representar si el producto está a la venta.
    -- En PostgreSQL existe el tipo BOOLEAN nativo (TRUE/FALSE).
    -- Si el motor no soporta BOOLEAN (ej. versiones viejas de SQL Server), se podría usar BIT en su lugar.
    esta_activo BOOLEAN DEFAULT TRUE
);
