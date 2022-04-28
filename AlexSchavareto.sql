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
