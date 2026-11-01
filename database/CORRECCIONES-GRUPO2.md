# Correcciones a la base de datos - Grupo 2

Script: `database/sql-002-correcciones-grupo2.sql` (esquema completo corregido; ejecutar en una base vacía).
El archivo original `sql-001-inicial.sql` NO se modificó.

## Errores encontrados y corrección

| # | Error en sql-001 | Corrección |
|---|---|---|
| 1 | Tablas `[inventario]` e `[INVENTARIO]` duplicadas (SQL Server no distingue mayúsculas) | La de lotes (módulo bodega) se renombró a `inventario_lote`; `INVENTARIO` queda para existencias por producto |
| 2 | Tipo `boolean` no existe en SQL Server | Se usa `bit` |
| 3 | `DEFAULT (true)` no es válido | `DEFAULT (1)` |
| 4 | `cliente.creado_en` como `timestamp` (es rowversion, no fecha) | `datetime DEFAULT (GETDATE())` |
| 5 | FK `cliente.idCliente -> detallePersonaJuridica.idCliente` al revés y a columna sin llave | FK `detallePersonaJuridica.idCliente -> cliente.idCliente` (con UNIQUE) |
| 6 | `Reportes_Nivel` con FKs a `Reportes.Nivel` y `Nivel.Nivel`, que no son llaves | Se eliminó `Reportes_Nivel`; FK directa `Reportes.Nivel -> Nivel.id_Nivel` |
| 7 | FKs faltantes | Agregadas: `existencias.id_producto`, `Detalle_Pedido.ID_Producto`, `Detalle_venta.ID_producto` -> `PRODUCTO`; `Pedido.ID_cliente -> cliente`; `entradas_salidas.id_proveedor -> PROVEEDOR`, `id_abastecimiento -> ABASTECIMIENTO`, `id_pedido -> Pedido` |
| 8 | Índices únicos con columnas entre comillas dobles (`"ID_pedido"`) fallan en sqlcmd (QUOTED_IDENTIFIER OFF) | Se usan corchetes `[ID_pedido]` |

Prueba: en SQL Server Express el script crea 28 tablas y 34 llaves foráneas sin errores.

Nota: las columnas de usuario (`id_usuario`, `ID_Usuario_Responsable`) quedan sin FK porque aún no existe tabla de usuarios.
