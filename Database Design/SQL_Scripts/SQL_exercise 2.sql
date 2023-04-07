set FOREIGN_KEY_CHECKS = 1;

-- SHOW TABLE DATA

-- a
SELECT e.lname, e.fname
from employee e, employee s
where s.fname='Franklin' and s.lname='Wong' and e.superssn=s.ssn;

-- b
select lname, fname, address
from employee where exists(select *
    from works_on, project
    where ssn=essn and pno=pnumber
    and plocation='Houston')
and 
    not exists (select *
    from dept_locations
    where dno=dnumber and dlocation='Houston');
-- c
select COUNT(CustomerID), Country
from customers
group by Country
order by count(CustomerID) DESC;
 -- d
--SELECT dname, COUNT(ssn)
from department, employee
where dno=dnumber
GROUP BY dname
having avg(salary) > 30000;

-- e
-- TODO
--SELECT dname, COUNT(ssn)
--from department, employee
--where dno=dnumber amd sex='M'
--dno IN (select dno from employee group by dno
--    having avg(salary) > 30000)
--    group by dname;

-- SQL EXERCISE 2

-- 1
select shippers.shippername, count(orders.orderid)
from orders
left join shippers on orders.shipperid=shippers.shipperid
group by shippername;

-- 2
select orders.orderid, customers.customername,
shippers.shippername 
from ((orders
inner join customers on orders.customerid = 
customers.customerid)
inner join shippers on orders.shipperid = shippers.shipperid);

-- 3
select suppliername from suppliers
where EXISTS
(select productname from products where supplierid =
suppliers.supplierid
and price < 20);

-- 5
select customername, contactname
from customers
where (LEFT(customername,1) = LEFT(contactname,1));

-- 6
select productname, contactname
from products, order_details, orders, customers
where (quantity > 30
    and order_details.orderid = orders.orderid 
    and orders.customerid = customers.customerid
    and order_details.productid = products.productid);


