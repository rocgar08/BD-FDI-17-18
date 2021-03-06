/*Rocio García Núñez y  Lidia Barja Diez*/
--Descripcion de las tablas--
DESCRIBE pr3_countries;
DESCRIBE pr3_departments;
DESCRIBE pr3_employees;
DESCRIBE pr3_job_history;
DESCRIBE pr3_jobs;
DESCRIBE pr3_locations;
DESCRIBE pr3_regions;
---consultas sql---
--1
SELECT * FROM PR3_DEPARTMENTS
WHERE LOCATION_ID = 1500;
--2
SELECT FIRST_NAME FROM PR3_EMPLOYEES
WHERE DEPARTMENT_ID = 100;
--3
SELECT FIRST_NAME FROM PR3_EMPLOYEES
WHERE MANAGER_ID IS NULL;
--4
SELECT DEPARTMENT_ID FROM PR3_EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
--5
SELECT FIRST_NAME FROM PR3_EMPLOYEES , PR3_DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance'
ORDER BY LAST_NAME;
--6
SELECT FIRST_NAME FROM PR3_EMPLOYEES E1,PR3_DEPARTMENTS D1
WHERE E1.EMPLOYEE_ID = D1.MANAGER_ID;
--7
SELECT DISTINCT E2.LAST_NAME 
FROM PR3_EMPLOYEES E1, PR3_EMPLOYEES E2, PR3_DEPARTMENTS D1
WHERE E1.EMPLOYEE_ID = D1.MANAGER_ID AND E1.SALARY < E2.SALARY;
--8
SELECT FIRST_NAME 
FROM PR3_EMPLOYEES E1 , PR3_DEPARTMENTS D1
WHERE DEPARTMENT_NAME = 'Sales' AND D1.DEPARTMENT_ID = E1.DEPARTMENT_ID;

--9 Nombres de los puestos que desempeñan los empleados en el departamento IT, sin tuplas
--repetidas.
SELECT  DISTINCT JB.JOB_TITLE 
FROM (PR3_EMPLOYEES EMP  INNER JOIN PR3_JOBS JB   ON JB.JOB_ID = EMP.JOB_ID) INNER JOIN PR3_DEPARTMENTS DE ON EMP.DEPARTMENT_ID=DE.DEPARTMENT_ID
WHERE DE.DEPARTMENT_NAME = 'IT';

SELECT DISTINCT JOB_TITLE
FROM PR3_JOBS JB, PR3_EMPLOYEES EM, PR3_DEPARTMENTS DE
WHERE JB.JOB_ID = EM.JOB_ID AND EM.DEPARTMENT_ID = DE.DEPARTMENT_ID AND DE.DEPARTMENT_NAME = 'IT';

/*10. Listado con los nombres de los empleados que trabajan en el departamento IT que no trabajan
en Europa, junto con el nombre del país en el que trabajan.*/
SELECT DISTINCT FIRST_NAME FROM PR3_EMPLOYEES EMP JOIN PR3_DEPARTMENTS DE ON EMP.DEPARTMENT_ID = DE.DEPARTMENT_ID JOIN
PR3_LOCATIONS LO ON LO.LOCATION_ID = DE.LOCATION_ID 
WHERE DE.DEPARTMENT_NAME = 'IT' AND  LO.LOCATION_ID<> 1200 AND  LO.LOCATION_ID<> 1300 AND  LO.LOCATION_ID<> 1400  AND  LO.LOCATION_ID<> 1500
AND  LO.LOCATION_ID<> 1600 AND  LO.LOCATION_ID<> 1800  AND  LO.LOCATION_ID<> 1900 AND  LO.LOCATION_ID<> 2000  AND  LO.LOCATION_ID<> 2100  AND  LO.LOCATION_ID<> 2200  
AND  LO.LOCATION_ID<> 2300  AND  LO.LOCATION_ID<> 2800 AND  LO.LOCATION_ID<> 3200;

SELECT FIRST_NAME, COUNTRY_NAME
FROM  PR3_EMPLOYEES E, PR3_DEPARTMENTS D, PR3_LOCATIONS L, PR3_COUNTRIES CO, PR3_REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND D.LOCATION_ID = L.LOCATION_ID AND L.COUNTRY_ID = CO.COUNTRY_ID AND CO.REGION_ID = R.REGION_ID AND R.REGION_NAME <> 'Europa' AND D.DEPARTMENT_NAME = 'IT';

/*11. Listado de los apellidos de los empleados del departamento SALES que no trabajan en el
mismo departamento que su jefe, junto con el apellido de su jefe y el departamento en el que
trabaja el jefe.*/
SELECT E1.LAST_NAME,E2.LAST_NAME,E2.DEPARTMENT_ID FROM  PR3_EMPLOYEES E1,PR3_EMPLOYEES E2 ,PR3_DEPARTMENTS DE  
WHERE E2.EMPLOYEE_ID = DE.MANAGER_ID AND E1.DEPARTMENT_ID != E2.DEPARTMENT_ID  AND DE.DEPARTMENT_NAME = 'SALES';

/*12. Listado con los nombres de los empleados que han trabajado en el departamento IT, pero que
actualmente trabajan en otro departamento distinto*/

SELECT DISTINCT FIRST_NAME FROM PR3_EMPLOYEES EMP JOIN PR3_JOB_HISTORY JH ON JH.EMPLOYEE_ID = EMP.EMPLOYEE_ID,PR3_JOBS JB
WHERE JH.DEPARTMENT_ID = 60 AND JB.JOB_ID<>JH.JOB_ID;

SELECT FIRST_NAME
FROM PR3_EMPLOYEES E, PR3_JOB_HISTORY JH, PR3_DEPARTMENTS D1, PR3_DEPARTMENTS D2
WHERE (E.EMPLOYEE_ID = JH.EMPLOYEE_ID AND JH.DEPARTMENT_ID = D1.DEPARTMENT_ID AND D1.DEPARTMENT_NAME = 'IT') AND (E.DEpARTMENT_ID = D2.DEPARTMENT_ID AND D2.DEPARTMENT_NAME <> 'IT');

