-- ============================================================
-- BodegaTech — Script de Inventario
-- Autor: [Tu nombre]
-- Fecha: [Fecha de entrega]
-- ============================================================

-- ── SECCIÓN DDL ─────────────────────────────────────

-- Eliminamos la tabla si ya existe, para poder re-ejecutar
-- este script las veces que sea necesario sin errores.
DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario (
    -- id_producto: clave primaria, identificador único y numérico de cada producto
    id_producto INT PRIMARY KEY,

    -- nombre_producto: texto corto, 100 caracteres son suficientes para cualquier nombre comercial
    nombre_producto VARCHAR(100) NOT NULL,

    -- categoria: texto corto, no necesita tantos caracteres como el nombre del producto
    categoria VARCHAR(50),

    -- precio_unitario: usamos DECIMAL (no FLOAT) porque es dinero y necesitamos precisión exacta,
    -- sin errores de redondeo. DECIMAL(10,2) admite hasta 10 dígitos totales, 2 decimales
    precio_unitario DECIMAL(10, 2) NOT NULL,

    -- stock_actual: cantidad de unidades, siempre un número entero (no tiene sentido un decimal)
    stock_actual INT NOT NULL,

    -- stock_minimo: igual que el anterior, cantidad entera usada como umbral de reposición
    stock_minimo INT,

    -- fecha_ingreso: solo nos interesa el día en que ingresó el producto, no la hora, por eso DATE
    fecha_ingreso DATE,

    -- activo: bandera simple (1 = disponible, 0 = descontinuado). Usamos SMALLINT porque
    -- es el tipo entero pequeño compatible tanto en PostgreSQL como en SQL Server
    activo SMALLINT DEFAULT 1
);

-- ── SECCIÓN DML ─────────────────────────────────────

-- Paso 3: carga de los 10 productos iniciales
INSERT INTO inventario
    (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES
    (1,  'Laptop Pro 15',        'Computación',     1200.00, 15, 3,  CURRENT_DATE, 1),
    (2,  'Mouse Inalámbrico',    'Accesorios',         28.00, 80, 10, CURRENT_DATE, 1),
    (3,  'Monitor 4K 27"',       'Computación',       450.00, 12, 2,  CURRENT_DATE, 1),
    (4,  'Teclado Mecánico',     'Accesorios',         95.00, 40, 5,  CURRENT_DATE, 1),
    (5,  'Laptop Basic 14',      'Computación',       650.00, 20, 3,  CURRENT_DATE, 1),
    (6,  'Auriculares BT Pro',   'Audio',             120.00, 35, 5,  CURRENT_DATE, 1),
    (7,  'Hub USB-C 7 puertos',  'Accesorios',         45.00, 60, 10, CURRENT_DATE, 1),
    (8,  'Webcam HD 1080p',      'Accesorios',         85.00, 25, 5,  CURRENT_DATE, 1),
    (9,  'SSD Externo 1TB',      'Almacenamiento',    130.00, 18, 3,  CURRENT_DATE, 1),
    (10, 'Parlante Bluetooth',   'Audio',              60.00, 45, 8,  CURRENT_DATE, 1);

-- Paso 4: registrar las ventas del día actualizando stock_actual
-- Laptop Pro 15 (id 1): se vendieron 3 unidades → 15 - 3 = 12
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Mouse Inalámbrico (id 2): se vendieron 12 unidades → 80 - 12 = 68
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Auriculares BT Pro (id 6): se vendieron 5 unidades → 35 - 5 = 30
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;

-- Paso 5: la Webcam HD 1080p (id 8) fue descontinuada por el proveedor
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;

-- Paso 6: validación de la carga
-- Ver la tabla completa para confirmar que los datos se cargaron
SELECT * FROM inventario;
