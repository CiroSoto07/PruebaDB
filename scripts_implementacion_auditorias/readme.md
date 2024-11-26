Primero, se creo una tabla de auditoría que registre los cambios relevantes en las tablas de permisos (PermiUser, PermiRole, PermiUserRecord, PermiRoleRecord).
Esta tabla almacenará detalles como el tipo de acción (insertar, actualizar, eliminar), el usuario que realizó la acción, la fecha y hora del cambio, así como la información relevante sobre el permiso afectado.

El tipo de acción (action_type) puede tomar los siguientes valores:
INSERT: Cuando se inserta un nuevo permiso.
UPDATE: Cuando se actualiza un permiso existente.
DELETE: Cuando se elimina un permiso.
El campo old_value contendrá el valor anterior del registro antes de que se realice la acción de actualización o eliminación, y el campo new_value contendrá el valor actualizado.

Una vez que se implementen estos triggers, cada vez que se inserte, actualice o elimine un registro en las tablas de permisos (PermiUser, PermiRole, PermiUserRecord, PermiRoleRecord), el sistema automáticamente registrará los cambios en la tabla AuditLog
