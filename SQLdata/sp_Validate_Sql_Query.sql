CREATE PROCEDURE sp_Validate_Sql_Query
    @SqlQuery NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UpperQuery NVARCHAR(MAX);
    SET @UpperQuery = UPPER(@SqlQuery);

    /* ================= BLOCK SYSTEM / PROTECTED TABLES ================= */

    IF (
           @UpperQuery LIKE '% USERS %'
        OR @UpperQuery LIKE '% USERS;%'
        OR @UpperQuery LIKE '% USERS)%'
        --OR @UpperQuery LIKE '% ROLES %'
        --OR @UpperQuery LIKE '% PERMISSIONS %'
        --OR @UpperQuery LIKE '% LOGIN %'
        --OR @UpperQuery LIKE '% ACCOUNT %'
    )
    BEGIN
        RAISERROR (
            'You can''t query system tables (USERS,OrderP,ProductP,CustomerP).',
            16,
            1
        );
        RETURN;
    END

    /* ================= EXECUTE USER QUERY ================= */

    EXEC sp_executesql @SqlQuery;
END
