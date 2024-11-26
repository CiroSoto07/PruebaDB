--Es recomendable agregar índices en las tablas clave para asegurar un rendimiento adecuado, especialmente en las columnas que se utilizan en las uniones (JOIN) y filtros (WHERE):

CREATE INDEX IX_PermiUser_EntityCatalog_UserCompany ON PermiUser(entitycatalog_id, usercompany_id);
CREATE INDEX IX_PermiRole_EntityCatalog_Role ON PermiRole(entitycatalog_id, role_id);
CREATE INDEX IX_PermiUserRecord_EntityCatalog_UserCompany ON PermiUserRecord(entitycatalog_id, usercompany_id);
CREATE INDEX IX_PermiRoleRecord_EntityCatalog_Role ON PermiRoleRecord(entitycatalog_id, role_id);
