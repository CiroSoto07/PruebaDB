--Este procedimiento busca los permisos asignados de cuatro fuentes:

--PermiUser: Permisos asignados directamente a un usuario sobre una entidad.
--PermiRole: Permisos asignados a un rol del usuario sobre una entidad.
--PermiUserRecord: Permisos asignados a un usuario sobre registros específicos dentro de una entidad.
--PermiRoleRecord: Permisos asignados a los roles del usuario sobre registros específicos dentro de una entidad.
--El resultado de este procedimiento será una lista de permisos asignados al usuario, indicando si son permisos de nivel de entidad o de nivel de registro.

CREATE PROCEDURE GetUserPermissions
    @entitycatalog_id BIGINT,
    @user_id BIGINT
AS
BEGIN
    -- Devolución de permisos a nivel de entidad para el usuario (PermiUser y PermiRole)
    SELECT 
        'Entity Level' AS PermissionType,
        pu.permission_id,
        p.name AS PermissionName,
        pu.peusr_include AS IncludePermission
    FROM PermiUser pu
    INNER JOIN Permission p ON pu.permission_id = p.id_permi
    WHERE pu.entitycatalog_id = @entitycatalog_id
    AND pu.usercompany_id IN (
        SELECT id_useco FROM UserCompany WHERE user_id = @user_id
    )
    
    UNION ALL

    -- Permisos asignados al rol del usuario (PermiRole)
    SELECT 
        'Role Level' AS PermissionType,
        pr.permission_id,
        p.name AS PermissionName,
        pr.perol_include AS IncludePermission
    FROM PermiRole pr
    INNER JOIN Permission p ON pr.permission_id = p.id_permi
    WHERE pr.entitycatalog_id = @entitycatalog_id
    AND pr.role_id IN (
        SELECT r.id_role 
        FROM Role r
        INNER JOIN UserCompany uc ON uc.company_id = r.company_id
        WHERE uc.user_id = @user_id
    )

    UNION ALL

    -- Permisos asignados a nivel de registro específico para el usuario (PermiUserRecord)
    SELECT 
        'Record Level (User)' AS PermissionType,
        pur.permission_id,
        p.name AS PermissionName,
        pur.peusr_include AS IncludePermission
    FROM PermiUserRecord pur
    INNER JOIN Permission p ON pur.permission_id = p.id_permi
    WHERE pur.entitycatalog_id = @entitycatalog_id
    AND pur.usercompany_id IN (
        SELECT id_useco FROM UserCompany WHERE user_id = @user_id
    )
    AND pur.peusr_record IN (
        SELECT record_id FROM EntityRecords WHERE entitycatalog_id = @entitycatalog_id
    )
    
    UNION ALL

    -- Permisos asignados a nivel de registro específico para los roles del usuario (PermiRoleRecord)
    SELECT 
        'Record Level (Role)' AS PermissionType,
        prr.permission_id,
        p.name AS PermissionName,
        prr.perrc_include AS IncludePermission
    FROM PermiRoleRecord prr
    INNER JOIN Permission p ON prr.permission_id = p.id_permi
    WHERE prr.entitycatalog_id = @entitycatalog_id
    AND prr.role_id IN (
        SELECT r.id_role 
        FROM Role r
        INNER JOIN UserCompany uc ON uc.company_id = r.company_id
        WHERE uc.user_id = @user_id
    )
    AND prr.perrc_record IN (
        SELECT record_id FROM EntityRecords WHERE entitycatalog_id = @entitycatalog_id
    )
END
