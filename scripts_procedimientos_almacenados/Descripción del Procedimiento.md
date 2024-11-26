Descripción del Procedimiento
Parámetros de entrada:
@EntityCatalogId: Es el identificador de la entidad sobre la que se consultarán los permisos (puede ser Sucursal, Centro de Costos, etc.).
@UserId: Es el identificador del usuario para el cual se consultarán los permisos.

Lógica:
El procedimiento utiliza una tabla temporal @Permissions para almacenar los permisos obtenidos de las distintas tablas (PermiUser, PermiRole, PermiUserRecord, PermiRoleRecord).
Se realiza una consulta sobre cada una de las tablas relevantes, comenzando por los permisos a nivel de entidad (generales) y luego sobre los registros específicos, respetando la jerarquía de permisos (usuario, rol, entidad y registros).
Se utiliza DISTINCT y se ordenan los resultados por la fuente del permiso ('User', 'Role', 'UserRecord', 'RoleRecord') para dar mayor prioridad a los permisos asignados directamente al usuario.
