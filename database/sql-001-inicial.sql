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
  [ID_estado_pedido] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre] varchar(50) UNIQUE NOT NULL,
  [Descripcion] text,
  [Activo] boolean NOT NULL DEFAULT (true)
)
GO

CREATE TABLE [Pedido] (
  [ID_Pedido] int PRIMARY KEY IDENTITY(1, 1),
  [ID_cliente] int NOT NULL,
  [ID_estado_pedido] int NOT NULL,
  [Fecha_pedido] datetime NOT NULL,
  [Subtotal] decimal(10,2) NOT NULL,
  [Impuestos] decimal(10,2) NOT NULL,
  [Descuento] decimal(10,2) NOT NULL DEFAULT (0),
  [Total] decimal(10,2) NOT NULL,
  [Observaciones] text,
  [Fecha_actualizacion] datetime
)
GO

CREATE TABLE [Detalle_Pedido] (
  [ID_detalle_pedido] int PRIMARY KEY IDENTITY(1, 1),
  [ID_pedido] int NOT NULL,
  [ID_Producto] int NOT NULL,
  [Cantidad] int NOT NULL,
  [Precio_Unitario] decimal(10,2) NOT NULL,
  [Descuento] decimal(10,2) NOT NULL DEFAULT (0),
  [Subtotal] decimal(10,2) NOT NULL
)
GO

CREATE TABLE [Historial_Pedido] (
  [ID_historial_pedido] int PRIMARY KEY IDENTITY(1, 1),
  [ID_pedido] int NOT NULL,
  [ID_estado_anterior] int,
  [ID_estado_nuevo] int,
  [Tipo_evento] varchar(100) NOT NULL,
  [Fecha_hora] datetime NOT NULL,
  [ID_usuario] int,
  [Descripcion] text
)
GO

CREATE TABLE [Estado_venta] (
  [ID_estado_venta] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre] varchar(50) UNIQUE NOT NULL,
  [Descripcion] text,
  [Activo] boolean NOT NULL DEFAULT (true)
)
GO

CREATE TABLE [Venta] (
  [ID_venta] int PRIMARY KEY IDENTITY(1, 1),
  [ID_pedido] int UNIQUE NOT NULL,
  [ID_estado_venta] int NOT NULL,
  [Fecha_venta] datetime NOT NULL,
  [Subtotal] decimal(10,2) NOT NULL,
  [Impuestos] decimal(10,2) NOT NULL,
  [Descuento] decimal(10,2) NOT NULL DEFAULT (0),
  [Total] decimal(10,2) NOT NULL,
  [Observaciones] text
)
GO

CREATE TABLE [Detalle_venta] (
  [ID_detalle_venta] int PRIMARY KEY IDENTITY(1, 1),
  [ID_venta] int NOT NULL,
  [ID_producto] int NOT NULL,
  [Cantidad] int NOT NULL,
  [Precio_unitario] decimal(10,2) NOT NULL,
  [Descuento] decimal(10,2) NOT NULL DEFAULT (0),
  [Subtotal] decimal(10,2) NOT NULL
)
GO

CREATE TABLE [Comprobante_Venta] (
  [ID_comprobante] int PRIMARY KEY IDENTITY(1, 1),
  [ID_venta] int NOT NULL,
  [Tipo_comprobante] varchar(50) NOT NULL,
  [Numero_comprobante] varchar(100) UNIQUE NOT NULL,
  [Fecha_emision] datetime NOT NULL,
  [Subtotal] decimal(10,2) NOT NULL,
  [Impuestos] decimal(10,2) NOT NULL,
  [Total] decimal(10,2) NOT NULL,
  [Estado] varchar(50) NOT NULL
)
GO

CREATE TABLE [Metodo_de_pago] (
  [ID_metodo] int PRIMARY KEY IDENTITY(1, 1),
  [Nombre] varchar(50) UNIQUE NOT NULL,
  [Descripcion] text,
  [Estado_activo] boolean NOT NULL DEFAULT (true),
  [Fecha_creacion] datetime NOT NULL
)
GO

CREATE TABLE [Pago] (
  [ID_pago] int PRIMARY KEY IDENTITY(1, 1),
  [ID_venta] int NOT NULL,
  [ID_metodo] int NOT NULL,
  [Fecha_pago] datetime NOT NULL,
  [Monto] decimal(10,2) NOT NULL,
  [Referencia] varchar(100),
  [Estado] varchar(50) NOT NULL,
  [Observaciones] text
)
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

CREATE UNIQUE INDEX [Detalle_Pedido_index_0] ON [Detalle_Pedido] ("ID_pedido", "ID_Producto")
GO

CREATE UNIQUE INDEX [Detalle_venta_index_1] ON [Detalle_venta] ("ID_venta", "ID_producto")
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

ALTER TABLE [Pedido] ADD FOREIGN KEY ([ID_estado_pedido]) REFERENCES [Estado_pedido] ([ID_estado_pedido])
GO

ALTER TABLE [Detalle_Pedido] ADD FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido] ([ID_Pedido])
GO

ALTER TABLE [Historial_Pedido] ADD FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido] ([ID_Pedido])
GO

ALTER TABLE [Historial_Pedido] ADD FOREIGN KEY ([ID_estado_anterior]) REFERENCES [Estado_pedido] ([ID_estado_pedido])
GO

ALTER TABLE [Historial_Pedido] ADD FOREIGN KEY ([ID_estado_nuevo]) REFERENCES [Estado_pedido] ([ID_estado_pedido])
GO

ALTER TABLE [Venta] ADD FOREIGN KEY ([ID_pedido]) REFERENCES [Pedido] ([ID_Pedido])
GO

ALTER TABLE [Venta] ADD FOREIGN KEY ([ID_estado_venta]) REFERENCES [Estado_venta] ([ID_estado_venta])
GO

ALTER TABLE [Detalle_venta] ADD FOREIGN KEY ([ID_venta]) REFERENCES [Venta] ([ID_venta])
GO

ALTER TABLE [Comprobante_Venta] ADD FOREIGN KEY ([ID_venta]) REFERENCES [Venta] ([ID_venta])
GO

ALTER TABLE [Pago] ADD FOREIGN KEY ([ID_venta]) REFERENCES [Venta] ([ID_venta])
GO

ALTER TABLE [Pago] ADD FOREIGN KEY ([ID_metodo]) REFERENCES [Metodo_de_pago] ([ID_metodo])
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

