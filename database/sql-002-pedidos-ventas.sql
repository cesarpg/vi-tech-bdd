CREATE TABLE [cliente] (
  [idCliente] int PRIMARY KEY IDENTITY(1, 1),
  [correo] varchar(100),
  [telefono] varchar(20),
  [direccion] text,
  [creado_en] timestamp,
  [idTipoCliente] int
)
GO

CREATE TABLE [TipoCliente] (
  [idTipoCliente] int PRIMARY KEY,
  [tipoCliente] varchar(100) NOT NULL
)
GO

CREATE TABLE [detallePersonaJuridica] (
  [idDetallePersonaJuridica] int PRIMARY KEY,
  [nrc] varchar(100) NOT NULL,
  [nombreEmpresa] varchar(100) NOT NULL,
  [idCliente] int
)
GO

CREATE TABLE [inventario] (
  [id_inventario] int PRIMARY KEY,
  [codigo_lote] varchar(50),
  [descripcion] text,
  [fecha_ingreso_lote] datetime,
  [fecha_vencimiento] datetime,
  [numero_serie] varchar(100),
  [estado_lote] varchar(50)
)
GO

CREATE TABLE [existencias] (
  [id_existencia] int PRIMARY KEY,
  [id_inventario] int,
  [id_producto] int,
  [id_estado] int,
  [cantidad_actual] int,
  [stock_minimo] int,
  [ubicacion] varchar(100)
)
GO

CREATE TABLE [movimientos] (
  [id_movimiento] int PRIMARY KEY,
  [id_inventario] int,
  [id_existencia] int,
  [tipo_movimiento] varchar(20),
  [cantidad_anterior] int,
  [cantidad_posterior] int,
  [descripcion_movimiento] varchar(150)
)
GO

CREATE TABLE [entradas_salidas] (
  [id_operacion] int PRIMARY KEY,
  [id_movimiento] int UNIQUE,
  [cantidad] int,
  [fecha] datetime,
  [id_proveedor] int,
  [id_abastecimiento] int,
  [id_usuario] int,
  [motivo] varchar(150),
  [destino_area_solicitante] varchar(150),
  [id_pedido] int
)
GO

CREATE TABLE [estados] (
  [id_estado] int PRIMARY KEY,
  [codigo] varchar(20) UNIQUE NOT NULL,
  [nombre] varchar(50) NOT NULL,
  [descripcion] varchar(150),
  [activo] boolean
)
GO

CREATE TABLE [PROVEEDOR] (
  [ID_Proveedor] int PRIMARY KEY IDENTITY(1, 1),
  [NRC] varchar(20) UNIQUE,
  [Nombre_Empresa] varchar(150) NOT NULL,
  [Contacto] varchar(100),
  [Telefono] varchar(20) NOT NULL,
  [Email] varchar(100) NOT NULL,
  [Direccion] text,
  [Pais] varchar(50) DEFAULT 'El Salvador',
  [Estado] varchar(20) DEFAULT 'Activo'
)
GO

CREATE TABLE [ABASTECIMIENTO] (
  [ID_Abastecimiento] int PRIMARY KEY IDENTITY(1, 1),
  [Fecha] date NOT NULL,
  [Estado_Operacion] varchar(30) DEFAULT 'Pendiente',
  [ID_Proveedor] int NOT NULL,
  [Fecha_Recepcion] date,
  [Total] decimal(12,2),
  [ID_Usuario_Responsable] int,
  [Observaciones] text
)
GO

CREATE TABLE [DETALLE_ABASTECIMIENTO] (
  [ID_Detalle] int PRIMARY KEY IDENTITY(1, 1),
  [Cantidad] int NOT NULL,
  [Cantidad_Recibida] int DEFAULT (0),
  [ID_Abastecimiento] int NOT NULL,
  [ID_Producto] int NOT NULL,
  [Precio_Compra] decimal(10,2) NOT NULL,
  [Subtotal] decimal(12,2) NOT NULL
)
GO

CREATE TABLE [PRODUCTO] (
  [ID_Producto] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre_Producto] varchar(150) NOT NULL,
  [Descripcion] text,
  [Categoria] varchar(100),
  [Precio_Unitario] decimal(10,2) NOT NULL,
  [Estado] varchar(20) DEFAULT 'Activo'
)
GO

CREATE TABLE [INVENTARIO] (
  [ID_Inventario] int PRIMARY KEY IDENTITY(1, 1),
  [Existencias_Actuales] int NOT NULL DEFAULT (0),
  [Stock_Minimo] int NOT NULL DEFAULT (5),
  [ID_Producto] int NOT NULL
)
GO

CREATE TABLE [MOVIMIENTO_INVENTARIO] (
  [ID_Movimiento] int PRIMARY KEY IDENTITY(1, 1),
  [Tipo_Movimiento] varchar(20) NOT NULL,
  [Cantidad_Movida] int NOT NULL,
  [Fecha_Movimiento] date NOT NULL,
  [ID_Inventario] int NOT NULL,
  [ID_Abastecimiento] int
)
GO

CREATE TABLE [Estado_pedido] (
  [ID_estado_pedido] INT IDENTITY(1, 1) PRIMARY KEY,
  [Nombre] VARCHAR(50) UNIQUE NOT NULL,
  [Descripcion] TEXT,
  [Activo] BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE [Pedido] (
  [ID_Pedido] INT IDENTITY(1, 1) PRIMARY KEY,
  [Codigo_pedido] VARCHAR(50) UNIQUE NOT NULL,
  [ID_cliente] INT NOT NULL,
  [ID_estado_pedido] INT NOT NULL,
  [Fecha_pedido] DATETIME NOT NULL,
  [Subtotal] DECIMAL(10,2) NOT NULL,
  [Impuestos] DECIMAL(10,2) NOT NULL,
  [Descuento] DECIMAL(10,2) NOT NULL DEFAULT 0,
  [Total] DECIMAL(10,2) NOT NULL,
  [Observaciones] TEXT,
  [Fecha_actualizacion] DATETIME,
  CONSTRAINT [FK_Pedido_Estado] FOREIGN KEY ([ID_estado_pedido]) REFERENCES [Estado_pedido]([ID_estado_pedido])
);
GO

CREATE TABLE [Detalle_Pedido] (
  [ID_detalle_pedido] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_pedido] INT NOT NULL,
  [ID_Producto] INT NOT NULL,
  [Cantidad] INT NOT NULL,
  [Precio_Unitario] DECIMAL(10,2) NOT NULL,
  [Descuento] DECIMAL(10,2) NOT NULL DEFAULT 0,
  [Subtotal] DECIMAL(10,2) NOT NULL,
  CONSTRAINT [FK_DetallePedido_Pedido] FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido]([ID_Pedido]),
  CONSTRAINT [UQ_Pedido_Producto] UNIQUE ([ID_pedido], [ID_Producto])
);
GO

CREATE TABLE [Tracking_Pedido] (
  [ID_tracking_pedido] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_pedido] INT NOT NULL,
  [ID_estado_pedido] INT NOT NULL,
  [Tipo_evento] VARCHAR(100) NOT NULL,
  [Fecha_hora] DATETIME NOT NULL,
  [ID_usuario] INT,
  [Descripcion] TEXT,
  CONSTRAINT [FK_Tracking_Pedido] FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido]([ID_Pedido]),
  CONSTRAINT [FK_Tracking_Estado] FOREIGN KEY ([ID_estado_pedido]) REFERENCES [Estado_pedido]([ID_estado_pedido])
);
GO

CREATE TABLE [Estado_venta] (
  [ID_estado_venta] INT IDENTITY(1, 1) PRIMARY KEY,
  [Nombre] VARCHAR(50) UNIQUE NOT NULL,
  [Descripcion] TEXT,
  [Activo] BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE [Venta] (
  [ID_venta] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_pedido] INT UNIQUE NOT NULL,
  [ID_estado_venta] INT NOT NULL,
  [Fecha_venta] DATETIME NOT NULL,
  [Subtotal] DECIMAL(10,2) NOT NULL,
  [Impuestos] DECIMAL(10,2) NOT NULL,
  [Descuento] DECIMAL(10,2) NOT NULL DEFAULT 0,
  [Total] DECIMAL(10,2) NOT NULL,
  [Observaciones] TEXT,
  CONSTRAINT [FK_Venta_Pedido] FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido]([ID_Pedido]),
  CONSTRAINT [FK_Venta_Estado] FOREIGN KEY ([ID_estado_venta]) REFERENCES [Estado_venta]([ID_estado_venta])
);
GO

CREATE TABLE [Detalle_venta] (
  [ID_detalle_venta] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_venta] INT NOT NULL,
  [ID_producto] INT NOT NULL,
  [Cantidad] INT NOT NULL,
  [Precio_unitario] DECIMAL(10,2) NOT NULL,
  [Descuento] DECIMAL(10,2) NOT NULL DEFAULT 0,
  [Subtotal] DECIMAL(10,2) NOT NULL,
  CONSTRAINT [FK_DetalleVenta_Venta] FOREIGN KEY ([ID_venta]) REFERENCES [Venta]([ID_venta]),
  CONSTRAINT [UQ_Venta_Producto] UNIQUE ([ID_venta], [ID_producto])
);
GO

CREATE TABLE [Comprobante_Venta] (
  [ID_comprobante] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_venta] INT NOT NULL,
  [Tipo_comprobante] VARCHAR(50) NOT NULL,
  [Numero_comprobante] VARCHAR(100) UNIQUE NOT NULL,
  [Fecha_emision] DATETIME NOT NULL,
  [Subtotal] DECIMAL(10,2) NOT NULL,
  [Impuestos] DECIMAL(10,2) NOT NULL,
  [Total] DECIMAL(10,2) NOT NULL,
  [Estado] BIT NOT NULL DEFAULT 1,
  CONSTRAINT [FK_Comprobante_Venta] FOREIGN KEY ([ID_venta]) REFERENCES [Venta]([ID_venta])
);
GO

CREATE TABLE [Metodo_de_pago] (
  [ID_metodo] INT IDENTITY(1, 1) PRIMARY KEY,
  [Nombre] VARCHAR(50) UNIQUE NOT NULL,
  [Descripcion] TEXT,
  [Estado_activo] BIT NOT NULL DEFAULT 1,
  [Fecha_creacion] DATETIME NOT NULL
);
GO

CREATE TABLE [Pago] (
  [ID_pago] INT IDENTITY(1, 1) PRIMARY KEY,
  [ID_venta] INT NOT NULL,
  [ID_metodo] INT NOT NULL,
  [Fecha_pago] DATETIME NOT NULL,
  [Monto] DECIMAL(10,2) NOT NULL,
  [Referencia] VARCHAR(100),
  [Estado] VARCHAR(50) NOT NULL,
  [Observaciones] TEXT,
  CONSTRAINT [FK_Pago_Venta] FOREIGN KEY ([ID_venta]) REFERENCES [Venta]([ID_venta]),
  CONSTRAINT [FK_Pago_Metodo] FOREIGN KEY ([ID_metodo]) REFERENCES [Metodo_de_pago]([ID_metodo])
);
GO

CREATE TABLE [Reportes] (
  [id_Reporte_Ventas] integer PRIMARY KEY,
  [Data] integer NOT NULL,
  [Formato] integer NOT NULL,
  [Nivel] integer NOT NULL,
  [Nombre] nvarchar(255),
  [Fecha] date
)
GO

CREATE TABLE [Formato] (
  [id_Formato] integer PRIMARY KEY,
  [Formato] nvarchar(255)
)
GO

CREATE TABLE [Datos] (
  [id_Datos] integer PRIMARY KEY,
  [Tabla] integer NOT NULL
)
GO

CREATE TABLE [Nivel] (
  [id_Nivel] integer PRIMARY KEY,
  [Rol] integer NOT NULL,
  [Nivel] integer NOT NULL
)
GO

ALTER TABLE [cliente] ADD FOREIGN KEY ([idTipoCliente]) REFERENCES [TipoCliente] ([idTipoCliente])
GO

ALTER TABLE [cliente] ADD FOREIGN KEY ([idCliente]) REFERENCES [detallePersonaJuridica] ([idCliente])
GO

ALTER TABLE [existencias] ADD FOREIGN KEY ([id_inventario]) REFERENCES [inventario] ([id_inventario])
GO

ALTER TABLE [existencias] ADD FOREIGN KEY ([id_estado]) REFERENCES [estados] ([id_estado])
GO

ALTER TABLE [movimientos] ADD FOREIGN KEY ([id_inventario]) REFERENCES [inventario] ([id_inventario])
GO

ALTER TABLE [movimientos] ADD FOREIGN KEY ([id_existencia]) REFERENCES [existencias] ([id_existencia])
GO

ALTER TABLE [entradas_salidas] ADD FOREIGN KEY ([id_movimiento]) REFERENCES [movimientos] ([id_movimiento])
GO

ALTER TABLE [ABASTECIMIENTO] ADD FOREIGN KEY ([ID_Proveedor]) REFERENCES [PROVEEDOR] ([ID_Proveedor])
GO

ALTER TABLE [DETALLE_ABASTECIMIENTO] ADD FOREIGN KEY ([ID_Abastecimiento]) REFERENCES [ABASTECIMIENTO] ([ID_Abastecimiento])
GO

ALTER TABLE [DETALLE_ABASTECIMIENTO] ADD FOREIGN KEY ([ID_Producto]) REFERENCES [PRODUCTO] ([ID_Producto])
GO

ALTER TABLE [INVENTARIO] ADD FOREIGN KEY ([ID_Producto]) REFERENCES [PRODUCTO] ([ID_Producto])
GO

ALTER TABLE [MOVIMIENTO_INVENTARIO] ADD FOREIGN KEY ([ID_Inventario]) REFERENCES [INVENTARIO] ([ID_Inventario])
GO

ALTER TABLE [MOVIMIENTO_INVENTARIO] ADD FOREIGN KEY ([ID_Abastecimiento]) REFERENCES [ABASTECIMIENTO] ([ID_Abastecimiento])
GO

ALTER TABLE [Reportes] ADD FOREIGN KEY ([Formato]) REFERENCES [Formato] ([id_Formato])
GO

ALTER TABLE [Reportes] ADD FOREIGN KEY ([Data]) REFERENCES [Datos] ([id_Datos])
GO

CREATE TABLE [Reportes_Nivel] (
  [Reportes_Nivel] integer,
  [Nivel_Nivel] integer,
  PRIMARY KEY ([Reportes_Nivel], [Nivel_Nivel])
);
GO

ALTER TABLE [Reportes_Nivel] ADD FOREIGN KEY ([Reportes_Nivel]) REFERENCES [Reportes] ([Nivel]);
GO

ALTER TABLE [Reportes_Nivel] ADD FOREIGN KEY ([Nivel_Nivel]) REFERENCES [Nivel] ([Nivel]);
GO