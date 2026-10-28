Observaciones de Base de Datos Vi-Tech

Hallazgos encontrados

Relación Cliente - detallePersonaJuridica

Validar la relación:



ALTER TABLE \[cliente] ADD FOREIGN KEY (\[idCliente]) REFERENCES \[detallePersonaJuridica] (\[idCliente])



Se recomienda verificar si la referencia debe apuntar a la clave primaria de la tabla detallePersonaJuridica.



Tablas de Inventario

Se identifican dos tablas:



inventario

INVENTARIO

Se recomienda validar si representan entidades distintas o si deben unificarse.



Referencias a Usuario

Existen campos relacionados con usuarios:



id\_usuario

ID\_Usuario\_Responsable

No se encontró la entidad Usuario dentro del script actual.



Relaciones Pendientes de Validación

Pedido → Cliente

Detalle\_venta → Producto

Reportes\_Nivel → Reportes

Reportes\_Nivel → Nivel

Estado

Pendiente de validación con el diagrama oficial y revisión funcional.

