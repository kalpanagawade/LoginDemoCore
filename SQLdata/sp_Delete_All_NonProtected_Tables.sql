CREATE PROCEDURE sp_Delete_All_NonProtected_Tables
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TableName NVARCHAR(256);
    DECLARE @Sql NVARCHAR(MAX);

    -- Cursor to loop all user tables except protected ones
    DECLARE table_cursor CURSOR FOR
    SELECT QUOTENAME(s.name) + '.' + QUOTENAME(t.name)
    FROM sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name NOT IN (
        'Users',
        --'Roles',
        --'Permissions',
        'CustomerP',
        'ProductP',
        'OrderP'
    );

    OPEN table_cursor;
    FETCH NEXT FROM table_cursor INTO @TableName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Sql = 'DROP TABLE ' + @TableName;
        EXEC sp_executesql @Sql;

        FETCH NEXT FROM table_cursor INTO @TableName;
    END

    CLOSE table_cursor;
    DEALLOCATE table_cursor;
END
