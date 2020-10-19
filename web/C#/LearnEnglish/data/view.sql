CREATE VIEW [dbo].[User]
AS 
SELECT [Username],[HashPassword], 'Members' AS [Role]
FROM [Learner]

UNION

SELECT [AdminName],[HashPassword], 'Admins' AS [Role]
FROM [Admin]
