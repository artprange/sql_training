USE employees;

SELECT first_name, last_name FROM employees;

SELECT*FROM  employees;

SELECT dept_no FROM departments;


SELECT 	* FROM 	employees
WHERE 	first_name = 'Denis';

SELECT * FROM employees
WHERE first_name = 'Elvis';


SELECT * FROM employees
WHERE first_name='Denis' AND gender ='M';

SELECT * FROM employees
WHERE first_name='Kelie' AND gender = 'F';

# WE SHALL USE 'AND' SETTING CONDITIONS ON DIFFERENT COLUMNS 
# AND 'OR' WITH THE CONDITIONS SET ON THE SAME COLUMN 


SELECT * FROM employees
WHERE first_name='Kellie' OR first_name='Aruna';


# O OPERADOR 'AND' VEM ANTES DE 'OR'
# ENTÃO, ELE PRIMIERO VAI EXECUTAR O 'AND' E DEPOIS O 'OR'
# NÃO IMPORTA A ORDEM QUE VOCE USE.alter

#exemplo:

SELECT * FROM employees
WHERE last_name = 'Denis' AND gender='M' OR gender='F';

#aqui extraímos todos os indivíduos homens com o sobrenome DENIS e TODAS as mulheres.


#corrigindo: colocamos parenteses para isolar a condição imposta a primeira query/condição (todos que tem o sobrenome DENIS e estão com o genero definido (not null)) 

SELECT * FROM employees
WHERE last_name = 'Denis' AND (gender='M' OR gender='F');

SELECT * FROM employees
WHERE (first_name ='Kellie' OR first_name='Aruna') AND gender='F';

# quando precisamos de mais de duas condições, usamos o  IN
# ele retornará os nomes dentro dos parentesis caso haja na lista

SELECT * FROM employees
WHERE first_name IN ('Cathie', 'Mark', 'Nathan');


#NOT IN - todos os nomes dentro do parentesis NÃO serão exibidos

SELECT * from employees
WHERE first_name IN ('Denis', 'Elvis');

SELECT * from employees
WHERE first_name NOT IN ('Mark', 'John', 'Jacob');



# buscará todos os nomes começando "mar"  PRECISA do % 
# se quisermos com o final "mar" colocamos o % antes da string desejada
# LOGO
# colocando o % antes da string desejada, fará com que retorne xxxMAR
# E SE
#colocarmos a string desejada entre %?
# retornará xxxMARxxx - sim, no meio 
# resumindo % - substitui uma sequencia de caracteres

# _ ajuda a achar UM unico caracter
# se eu quiser achar todos os nomes que começam com MAR e tem uma letra no final (seja ela qual for) basta usar na query:
# "Mar_"


SELECT * FROM employees
WHERE first_name LIKE('Mar%');

SELECT * FROM employees
WHERE first_name LIKE('%ar%');

SELECT * FROM employees
WHERE first_name LIKE('Mar_');

#
#
#

# NOT LIKE - extamaente o oposto, não vai retornar as querys listadas entre parenteses

SELECT * FROM employees
WHERE first_name LIKE ('Mark%');

SELECT * FROM employees
WHERE hire_date =('2000%');

SELECT * FROM employees
WHERE emp_no=('1000_');


SELECT * FROM employees
WHERE first_name Like ('%Jack%');

SELECT * FROM employees
WHERE first_name NOT LIKE('%Jack%');


# BETWEEN ... AND... limita o campo da pesquisa

SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';


# NOT BETWEEN... AND...
# nos dará um intervalo composto de duas partes:
# um intervalo menor que o primeiro valor indicado e,
#um segundo intervalo acima do segundo valor

SELECT * FROM employees
WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';




SELECT * FROM salaries
WHERE salary BETWEEN '66000' AND '70000';

SELECT * FROM employees
WHERE emp_no NOT BETWEEN '1004' AND '10012';



SELECT * FROM dept_emp
WHERE dept_no BETWEEN 'd003' AND 'd006';


# IS NOT NULL 
# retornará o que não é NULL

SELECT * FROM employees
WHERE first_name IS NOT NULL;

SELECT * FROM employees
WHERE first_name IS NULL;

# ^^^^^^^
# nas queries acima, podemos selecionar os primeiros nomes que NÃO SAO nulos.
# para testar o resultado (que foi em branco) selecionamos os que são. 


## exercicio com cross-check
SELECT * FROM dept_emp
WHERE dept_no IS NOT NULL;

SELECT * FROM dept_emp
WHERE dept_no IS NULL;



# selecionar valores maiores que, depois de e afins:

SELECT * FROM employees
WHERE hire_date > '2000-01-01'; 

SELECT * FROM employees
WHERE hire_date < '1985-02-01';


SELECT * FROM employees
WHERE hire_date >='2000-01-01' AND gender='F';


SELECT * FROM salaries
WHERE salary >'150000';





## SELECT DISTINCT
## seleciona todos os itens distintos
## na query abaixo vai retornar apenas F e M


SELECT DISTINCT gender
FROM employees;

SELECT DISTINCT  hire_date
FROM employees; 


# aggregate funcions
# aplicam-se em várias linhas de uma unica coluna e retornará UM unico valor;
# IGNORAM NULL por default. precisa especificar para contar;
# COUNT() - conta a quantidade de valores não nulos;
# SUM() - soma todos os valores não nulos;
# MIN() - retorna o menor valor daquela lista;
# MAX() - retorna o maior valor daquela lista;
# AVG () - retorna o valor médio;


SELECT COUNT(emp_no)
 FROM employees;



#checando se há algum primeiro nome nulo
SELECT COUNT(first_name IS NOT NULL)
FROM employees;


# count distinct - essa é a grafia correta


SELECT COUNT(DISTINCT first_name)
FROM employees;






SELECT COUNT(salary)
FROM salaries WHERE(salary >= 100000);


# ORDER BY
# ASC - ascending => se não especificar ele entende default que é ASCENDING
# DESC - descending

SELECT * FROM employees
ORDER BY first_name;


SELECT * FROM employees
ORDER BY emp_no DESC;

# aqui organizamos por primeiro nome em ordem alfabetica E o segundo nome, tabmém
SELECT * FROM employees
ORDER BY first_name, last_name ASC;


SELECT * FROM employees
ORDER BY hire_date DESC;


# GROUP BY
# precisa vir logo após WHERE se tiver e antes do ORDER BY
# então

#SELECT column_name(s)
#FROM table_name
#WHERE conditions
#GROUP BY column_name(s)
#ORDER BY column_name(s);


SELECT first_name
FROM employees
GROUP BY first_name;
#esse query é igual a:

SELECT DISTINCT first_name
FROM employees;

# na maioria dos casos, quando se usa uma aggregate function, se usa GROUP BY também

# a query abaixo mostrará quantas vezes cada nome aparece
SELECT COUNT(first_name)
FROM employees 
GROUP BY first_name; 

# para aparecer o nome, PRECISAMOS incluir o campo em que arrumamos, no argumento SELECT:
#seleciona o first_name
# organiza pelo first_name

SELECT first_name, COUNT(first_name) AS names_count
FROM employees
GROUP BY first_name
ORDER BY first_name ;

/*Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column. */

#resolução:

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE(salary >80000)
GROUP BY salary
ORDER BY salary;


#HAVING
#having é como o WHERE, porém aplicado ao GROUP BY

/*SELECT column_name(s)
FROM tabmle_name
WHERE conditions
GROUP BY column_name(s)
HAVING conditions
ORDER BY column_name(s);*/

SELECT * FROM employees
HAVING hire_date>='200-01-01';

#depois do having, precisa ter uma aggregate function, enquanto o WHERE as usa dentro das condições impostas.

#supondo que quero pegar todos os nomes que aparecem mais de 250 vezes na lista de empregados:

SELECT first_name, COUNT(first_name) as names_count
FROM employees
GROUP BY first_name
HAVING COUNT(first_name)>=250
ORDER BY first_name;

#WHERE vs HAVING

# quando vemos x vezes precisamos de COUNT()
# COUNT() é uma aggregate function, logo, precisamos de HAVING



#Select all employees whose average salary is higher than $120,000 per annum.

#Hint: You should obtain 101 records. 


SELECT emp_no,AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary)>120000
ORDER BY emp_no; 

#quando usamos o WHERE lo lugar HAVING, o resultado é maior porque incluirá os contratos individuais maiores que 120k por ano. O resultado não conterá a média.


#WHERE permite que explicitemos as condiçoes que vão se referir a linhas diferentes
# essas condições são aplicadas ANTES de reorganizar o resultado em grupos (GROUP BY) ; 



/*extract a list of all names that are encountered less than 200 times. Let the data refer to people hires after the 1st of january 1999*/

SELECT first_name, COUNT(first_name) as names_count
FROM employees
WHERE hire_date >'1999-01-01' # se refere a todas as linhas individuais na tabela de empregados
GROUP BY first_name
HAVING COUNT(first_name)<200 # se refere a todas as incidencias
ORDER BY first_name DESC;

# PRIMEIRO colocamos as condições que vão se referir a linhas diferentes e precisamos colocar essas condições ANTES de organizar o output. então o WHERE e vem antes do HAVIG

/* temos duas condiçoes a satisfazer: hire_date e first_name <200
	lembrando aqui, que COUNT() é uma aggregate function então precisará do HAVING
    a outra condição é geral, pessoas contratadas depois de 01-01-1999
    nenhuma função aggregate precisa ser evocada,
    logo, podemos usar o WHERE*/
   
   
# aggregate functions - usamos GROUP BY e HAVING;
# General conditions - WHERE;


/* select the employee numbers of all individuals who have signed more than one contract after the 1st of january 2020;*/


SELECT emp_no FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) >1
ORDER BY emp_no;

# LIMIT
# auto explicativo e sempre vai ao final, antes do ponto - virgula

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 15; 


/* select the first 100 rows from the 'dept_emp' table*/

SELECT * FROM dept_emp
LIMIT 100;


SELECT * FROM employees
order by emp_no DESC
LIMIT 10;

#INSERT 

# teoricamente não precisamos declarar esse primeiro parenteses (emp_ no e etc)
# basta colocar VALUES(xxx)
# CASO queira declarar de forma diferente, então precisa delcarar o primeiro parenteses

INSERT INTO employees
	(
		emp_no,
		birth_date,
		first_name,
		last_name,
		gender,
		hire_date
	) 
		VALUES
	(
		999908,
        '1986-04-21',
        'John',
        'Smith',
        'M',
        '2011-01-01'
	);
    
    # aqui vamos inserir data na ordem diferente da tabela, MAS explicitando nos campos da tabela
    
    INSERT INTO employees
	(
		birth_date,
        emp_no,
		first_name,
		last_name,
		gender,
		hire_date
	) 
		VALUES
	(
		'1986-04-21',
         999902,       
        'Patricia',
        'Lawrence',
        'F',
        '2005-01-01'
	);

# aqui colocamos data sem especificar os campos, MAS se deixarmos campos em branco, ele não aceitará a query 
INSERT INTO employees
VALUES
(
	999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
); 

SELECT * FROM titles
LIMIT 10;


INSERT INTO titles
(
	

	emp_no,
    title,
    from_date
)

VALUES
( 
	999903,
    'Senior Engineer',
    '1997-10-01'
    
    
);

SELECT * FROM titles
ORDER BY emp_no DESC
LIMIT 10;


SELECT * FROM dept_emp
ORDER BY emp_no DESC
LIMIT 10; 


/*Insert information about the individual with employee number 999903 into the “dept_emp” table. He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.

Hint: Use the date ‘9999-01-01’ to designate the contract is for an indefinite period. */

# cê errou né? melhor sempre escrever aonde quer colocar cada dado.


INSERT INTO dept_emp
(

	emp_no,
    dept_no,
    from_date,
    to_date
)

VALUES

(

	999903,

    'd005',

    '1997-10-01',

    '9999-01-01'

); 







#INSERTING DATA INTO A NEW TABLE


#para inserir dados em uma tabela nova, vamos clonar a tabela departments e jogar os dados da tabela departments para a departments_dup

SELECT * FROM departments;


CREATE TABLE departmenmts_dup

(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT * FROM departmenmts_dup; #checando se está vazia


#inserindo data:

INSERT INTO departmenmts_dup
( 
	dept_no,
    dept_name
) 
SELECT * FROM  departments;

SELECT * FROM departmenmts_dup; #checando se populada

/*Create a new department called “Business Analysis”. Register it under number ‘d010’.

Hint: To solve this exercise, use the “departments” table.*/

INSERT INTO departments
VALUES
(
	'd010',
    'Business Analysis'
);

#UPDATE

USE employees;

SELECT * FROM employees
WHERE emp_no = 999901;

UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender= 'F'
    
WHERE
	emp_no = 999901;
    
# vamos fazer besteira**

# 1 primeiro vamos checar a tabela departments_dup

SELECT * FROM departmenmts_dup
ORDER BY dept_no;

# 2 vamos comitar:

COMMIT;

# 3 agora vamos fazer o update de forma ***ERRADA***

UPDATE departmenmts_dup
SET
	dept_no = 'd011',
    dept_name = 'Quality Control';

# 4 vamos checar como ficou a tabela:

SELECT * FROM departmenmts_dup
ORDER BY dept_no;
#TODOS OS VALORES FICARAM COMO 'd011' e 'Quality COntrol'

# 5 vamos reverter a falha:

ROLLBACK;

# -> se não tiver nenhum commit, ele vai levar ao começo da tabela, no script inicial  perderemos tudo.
# FAÇA COMMIT!

# 6 executei a query "ROLLBACK" e vou checar a tabela como está:

SELECT * FROM departmenmts_dup
ORDER BY dept_no;

# sempre que formos fazer o UPDATE é essencial que colocamos a condição WHERE 
# caso contrário, ele vai colocar o valor do SET em TODOS os campos


# Change the “Business Analysis” department name to “Data Analysis”.

UPDATE departments
SET
	dept_name = "Data Analysis"
    
WHERE
	dept_name = 'Business Analysis';
    
SELECT * FROM departments;
COMMIT;


# DELETE

SELECT * FROM employees
WHERE emp_no=999903;

SELECT * FROM titles
WHERE emp_no=999903;

DELETE FROM employees
WHERE emp_no = 999903;

# deletou de employees e de titles

# só fazer o ROLLBACK depois de ter feito o COMMIT e tá tudo de volta como era.

# SEMPRE usar o delete com o  W H E R E

#Remove the department number 10 record from the “departments” table.

DELETE FROM departments
WHERE dept_no='d010';

#** ** ** ** ** ** ** 
#DROP vs TRUNCATE vs DELETE
# 1 - DROP: não é capaz de fazer o ROLLBACK ou para o ultimo COMMIT. usamos o DROP TABLE apenas quando há certeza que não usaremos aquela tabela mais

# 2 - TRUNCATE: vai limpar a tabela, mas não irá deleta-la. A estrutura vai ser mantida e o AUTO INCREMENT vai se manter

# 3 - DELETE: vai deletar a tabela linha a linha. Ou seja, dentro das condições do WHERE. Aqui o AUTO INCREMENT vai ser mantido e continuará a contar das linhas (rows) apagadas.

COMMIT;

# aggregate functions juntam infos de uma tabela, e transformam-no em um só. 
# exemplo COUNT()
# o input dela contém várias linhas
# o output é o único valor.

SELECT COUNT(salary)
FROM salaries;

#datas de início distintas:
SELECT COUNT(DISTINCT from_date)
FROM salaries;

#as aggregate functions geralmente ignoram os valores nulos no campo em que se são aplicados
# para retornar até os nulos, usamos COUNT(*)

#How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.


SELECT COUNT(DISTINCT DEPT_no)
FROM dept_emp;


#quanto a empresa gasta por mes com pessoal?
SELECT SUM(salary)
FROM salaries;


# se usassemos SUM(*) daria erro porque ele vai somar os nulos também

SELECT SUM(salary)
FROM salaries
WHERE(from_date >'1997-01-01');


#MAX - MIN

SELECT MAX(salary)
FROM (salaries);

SELECT MIN(salary)
FROM (salaries);

#1. Which is the lowest employee number in the database?
SELECT MIN(emp_no)
FROM employees;

#2. Which is the highest employee number in the database?
SELECT MAX(emp_no)

FROM employees; 


#AVERAGE

SELECT AVG(salary)
FROM salaries;

#What is the average annual salary paid to employees who started after the 1st of January 1997?
SELECT AVG(salary)
FROM (salaries)
WHERE from_date > '1997-01-01';


#ROUND()

SELECT ROUND(AVG(salary))
FROM salaries;

# agora, se quero precisar o numero de casas decimais:

SELECT ROUND(AVG(salary),2)
FROM salaries; 