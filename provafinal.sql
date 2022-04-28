/*
1) Listar BusinessEntityID,FirstName e LastName quando
LastName for igual a 'Akers'
2) Listar os produtos da tabela Production.Product quando
Color for NULO
3) Listar o total de cada pedido da tabela 
Sales.SalesOrderDetail (SalesOrderId, OrderQty, UnitPrice)
4) Montar um RANK descendente de estoque utilizando a tabela
Estoque
5) Listar o nome dos cursos que cada Aluno fez utilizando as
tabelas Aluno, AlunoCurso e Curso*/

--1)
select BusinessEntityID, FirstName, LastName
FROM Person.Person
Where LastName = 'Akers'

--2)
select * from Production.Product, [Name], ISNULL (Color = 'Sem Cor') as Color
where Color is NULL

--3)
SELECT
    SalesOrderID,
    SUM(OrderQty*UnitPrice) AS Total
FROM
    Sales.SalesOrderDetail
GROUP BY
    SalesOrderID


--4)
SELECT
*
FROM
Estoque
WHERE
Qtd_Estoque > 0
ORDER BY
Qtd_Estoque DESC

--5)
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

