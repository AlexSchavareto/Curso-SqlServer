--Utilizando a funcao COALESCE
CREATE TABLE Salario
(
Func_id tinyint identity,
valor_hora decimal NULL,
salario_fixo decimal NULL,
comissao decimal NULL,
total_vendas tinyint NULL
)

GO
INSERT Salario VALUES(10.00, NULL, NULL, NULL);
INSERT Salario VALUES(NULL, 100000, NULL, NULL);
INSERT Salario VALUES(NULL, NULL, 20000, 6);
INSERT Salario VALUES(40.00, NULL, NULL, NULL);
INSERT Salario VALUES(NULL, 10000, NULL, NULL);
INSERT Salario VALUES(20, NULL, NULL, NULL);
INSERT Salario VALUES(NULL, 40000.00, NULL, NULL);
INSERT Salario VALUES(NULL, NULL, 15000, 3);
INSERT Salario VALUES(NULL, 30000.00, NULL, NULL);
INSERT Salario VALUES(NULL, NULL, 25000, 2);
INSERT Salario VALUES(30.00, NULL, NULL, NULL);
INSERT Salario VALUES(NULL, NULL, 14000, 4);
INSERT Salario VALUES(NULL, NULL, NULL, NULL);

GO

SELECT * FROM Salario

SELECT
Func_id,
valor_hora,
salario_fixo,
comissao,
total_vendas,
COALESCE
(
valor_hora * 168,
salario_fixo,
comissao*total_vendas
)
FROM
Salario

SELECT
--3
Func_id,
valor_hora,
salario_fixo,
comissao,
total_vendas,
COALESCE
(
valor_hora * 168,
salario_fixo,
comissao*total_vendas,
0
) AS SalarioBruto
--1
FROM
Salario
--2
WHERE
COALESCE
(
valor_hora * 168,
salario_fixo,
comissao*total_vendas,
0
) = 0


SELECT
ProductID,
Name,
ListPrice

FROM
Production.Product
WHERE
ListPrice > 0
AND 
Color IS NOT NULL
ORDER BY
ListPrice ASC,
Name DESC

SELECT * FROM Sales.SalesOrderDetail


SELECT
SalesOrderID,
ProductID,
OrderQty,
UnitPrice,
TotalPrice,
COALESCE
(
SalesOrderID * 168,
salario_fixo,
comissao*total_vendas
)

FROM
Sales.SalesOrderDetail
WHERE
SalesOrderID = 43659

SELECT 
    SalesPersonID, 
    SUM(TotalDue) AS TotalPedido
FROM 
    Sales.SalesOrderHeader
WHERE   
    SalesPersonID IS NOT NULL
GROUP BY 
    SalesPersonID
ORDER BY 
    TotalPedido DESC


SELECT
    --Name,
    MAX(ListPrice) AS ProdutoMaisCaro,
    MiN(ListPrice) AS ProdutoMaisBarato,
    AVG(ListPrice) AS PrecoMedioProduto
FROM
    Production.Product
WHERE
    ListPrice > 0


SELECT
    SalesOrderID,
    SUM(OrderQty*UnitPrice) AS Total
FROM
    Sales.SalesOrderDetail
GROUP BY
    SalesOrderID
HAVING
    SUM(OrderQty*UnitPrice) > 140000
ORDER BY
    Total DESC


--Listar a MÉDIA de vendas por vendedor (SalesPersonID) em
--cada territorio (TerritoryID) e ordenado pela MENOR média
SELECT
SalesPersonID,
TerritoryID,
AVG(TotalDue) AS MediaVendedor
FROM
Sales.SalesOrderHeader
WHERE SalesPErsonID IS NOT NULL
GROUP BY SalesPersonID, TerritoryID
HAVING
AVG(TotalDue) > 30000
ORDER BY MediaVendedor ASC

CREATE TABLE Livro
(
Codigo INT IDENTITY(1,1),
Titulo VARCHAR(100),
Ano_Pb VARCHAR(4),
Qtd INT
)
GO
INSERT INTO Livro(Titulo,Ano_Pb,Qtd)
VALUES
('SQL SERVER 2005','2004',10),
('SQL SERVER 2008','2008',20),
('Tuning Queries','2005',5),
('Backup & Restore','2004',40),
('Seguranca','2004',15)

SELECT
ISNULL(CAST(Ano_Pb AS VARCHAR(10)),'Total') AS Ano_Pb,
SUM(Qtd) AS TotalVendas
FROM
Livro
GROUP BY
ROLLUP(Ano_Pb)

INSERT INTO Livro(Titulo,Ano_Pb,Qtd)
VALUES
('SQL SERVER 2005','2008',10),
('SQL SERVER 2008','2005',20),
('Tuning Queries','2010',5),
('Backup & Restore','2012',40),
('Seguranca','2021',15)

SELECT
Titulo,
Ano_Pb,
SUM(Qtd) AS TotalVendas
FROM
Livro
GROUP BY
ROLLUP(Titulo,Ano_Pb)

--NA MESMA QUERY
--Total por AnoPB
--Total por Titulo
--Media de Qtd
--Media de Qtd por Ano_PB
--Rank da qtd por Ano_PB
--Rank da qtd por titulo

SELECT
Ano_Pb,
Titulo,
Qtd,
SUM(Qtd) OVER (PARTITION BY Ano_Pb) AS Total_AnoPB,
SUM(Qtd) OVER (PARTITION BY Titulo) AS Total_Titulo,
AVG(Qtd) OVER () AS MediaGeralQtd,
DENSE_RANK() OVER (PARTITION BY Ano_Pb ORDER BY Qtd DESC) AS RankAnoPb,
DENSE_RANK() OVER (PARTITION BY Titulo ORDER BY Qtd DESC) AS RankTitulo
FROM
dbo.Livro

SELECT
SOD.SalesOrderID,
SOD.ProductID,
P.Name,
P.Color,
SOD.OrderQty,
SOD.UnitPrice
FROM
Sales.SalesOrderDetail AS SOD
INNER JOIN
Production.Product AS P
ON
SOD.ProductID = P.ProductID
WHERE
SOD.SalesOrderID = 43659

SELECT
SOH.SalesOrderID,
SOH.OrderDate,
SOH.ShipMethodID,
ST.TerritoryID,
ST.CountryRegionCode,
ST.[Group]
FROM
Sales.SalesOrderHeader AS SOH
INNER JOIN
Sales.SalesTerritory AS ST
ON
SOH.TerritoryID = ST.TerritoryID
WHERE

select * from Sales.SalesOrderHeader
select * from Sales.SalesTerritory

/*1) Listar o nome dos alunos, quais os cursos que estao matriculados e (em
qual dia da semana iniciara cada um dos cursos de cada aluno) () opcional
2) Listar o Total de vendas por curso e um totalizador geral com a soma
de todos os cursos juntos
3) Listar o nome dos alunos, quanto cada aluno gastou com os cursos
e qual o curso mais caro realizado por cada aluno
4) Montar um ranking ordenado de forma descendente pela quantidade de 
cursos realizadas por cada aluno
5) Listar o total por aluno e o total por curso na mesma consulta
6) Listar os alunos que não compraram cursos e os cursos que 
não foram vendidos na mesma consulta
7) Montar um ranking pelos cursos mais vendidos e retornar somente 
o curso que menos vendeu
*/


select * from AlunoCurso
select * from Curso
select * from Aluno


CREATE TABLE Aluno
(CodAlu INT, Nome VARCHAR(100),Sexo CHAR(1),
DataNasc DATE)
GO
CREATE TABLE Curso
(CodCurso INT, NomeCurso VARCHAR(100),ValorCurso DECIMAL(9,2))
GO
CREATE TABLE AlunoCurso
(CodAlu INT,CodCurso INT, DataCurso DATETIME2(0))
GO
INSERT Aluno VALUES (1,'Vitor','M','19830225'),(3,'Juliene','F','19811017'),
(2,'Ana','F','19550505'),(4,'Jose','M','19850428'),(5,'Roberto','M','19570315')
GO
INSERT Curso VALUES (1,'10774',1500),(2,'10775',2000),
(3,'10776',1800),(4,'10777',1750),(5,'10778',2350)
GO
INSERT AlunoCurso
VALUES
(1,1,GETDATE()+10),(1,2,GETDATE()+20),(1,3,GETDATE()+30),
(2,3,GETDATE()+11),(2,4,GETDATE()+21),(3,2,GETDATE()+31),
(3,1,GETDATE()+12),(3,4,GETDATE()+22),(4,4,GETDATE()+32)

--Listar o nome dos alunos, quais os cursos que estao matriculados e (em qual dia da semana iniciara cada um dos cursos de cada aluno) () opcional
SELECT
	A.Nome,
	C.NomeCurso

FROM 
	Aluno AS A INNER JOIN AlunoCurso AS AC
ON
	A.CodAlu = AC.CodAlu INNER JOIN Curso AS C
ON
	C.CodCurso = AC.CodCurso
GROUP BY
	Nome,NomeCurso

 /*   SELECT
A.Nome,
AC.CodCurso,
--C.CodCurso,
AC.CodCurso
FROM
Curso AS C,
Aluno AS A
INNER JOIN
AlunoCurso AS AC
ON
C.CodCurso = AC.CodCurso,*/

-- Listar o Total de vendas por curso e um totalizador geral com a soma de todos os cursos juntos

SELECT
	C.NomeCurso,
	ISNULL (CAST(ValorCurso AS VARCHAR(10)),'TOTAL'),
	SUM(ValorCurso) AS TotalVendasCurso

FROM
	Curso AS C LEFT JOIN AlunoCurso AS AC
ON
	C.CodCurso = AC.CodCurso
GROUP BY
	C.NomeCurso,ValorCurso

-- Listar os alunos que não compraram cursos e os cursos que não foram vendidos na mesma consulta
    SELECT
	A.Nome,
	C.NomeCurso

FROM
	Aluno AS A FULL JOIN AlunoCurso AS AC
ON
	A.CodAlu = AC.CodAlu FULL JOIN Curso AS C
ON
	C.CodCurso = AC.CodCurso
WHERE 
	A.CodAlu IS NULL OR AC.CodCurso IS NULL

-- Montar um ranking pelos cursos mais vendidos e retornar somente o curso que menos vendeu
SELECT
	C.NomeCurso,
	COUNT(AC.CodCurso) AS QtdCurso

FROM
	Curso AS C RIGHT JOIN AlunoCurso AS AC
ON
	C.CodCurso = AC.CodCurso
GROUP BY
	NomeCurso
ORDER BY
	QtdCurso




CREATE TABLE Tabela1
(
Codigo INT
)
GO
INSERT INTO Tabela1(Codigo)
VALUES(10),(30),(40)
GO
CREATE TABLE Tabela2
(
Codigo INT
)
GO
INSERT INTO Tabela2(Codigo)
VALUES(10),(30),(60)




USE AdventureWorks2019
GO
CREATE TABLE Tabela1
(
Codigo INT
)
GO
INSERT INTO Tabela1(Codigo)
VALUES(10),(30),(40)
GO
CREATE TABLE Tabela2
(
Codigo INT
)
GO
INSERT INTO Tabela2(Codigo)
VALUES(10),(30),(60)

--UNION
SELECT * FROM Tabela1
UNION
SELECT * FROM Tabela2

--UNION ALL
SELECT * FROM Tabela1
UNION ALL
SELECT * FROM Tabela2

--INTERSECT
SELECT * FROM Tabela1
INTERSECT
SELECT * FROM Tabela2

--EXCEPT
SELECT * FROM Tabela1
EXCEPT
SELECT * FROM Tabela2

SELECT TOP(10) PERCENT
BusinessEntityID,
FirstName
FROM
Person.Person

--TABLESAMPLE
SELECT
BusinessEntityID,
FirstName
FROM
Person.Person
TABLESAMPLE(1.5 PERCENT)

SELECT
*
FROM
Production.Product
WHERE
ProductID IN (
SELECT
ProductID
FROM
Sales.SalesOrderDetail
)


SELECT
*
FROM
Production.Product
WHERE
ProductID NOT IN (
SELECT
ProductID
FROM
Sales.SalesOrderDetail
)


SELECT
SalesOrderID,
(SELECT AVG(UnitPrice) FROM Sales.SalesOrderDetail SOD2
WHERE SOD2.SalesOrderID = SOD1.SalesOrderID) AS MediaUnitPrice
FROM
Sales.SalesOrderDetail SOD1


--ANY
SELECT * FROM Tabela1
SELECT * FROM Tabela2

SELECT
Codigo
FROM
Tabela1
WHERE
Codigo > ANY (SELECT Codigo FROM Tabela2)

--ALL
SELECT * FROM Tabela2
SELECT * FROM Tabela1
SELECT
Codigo
FROM
Tabela2
WHERE
Codigo > ALL (SELECT Codigo FROM Tabela1)
