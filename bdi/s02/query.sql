CREATE TABLE partsupp2 WITH (appendonly=true, orientation=row) AS select * from partsupp;
CREATE TABLE lineitem2 WITH (appendonly=true, orientation=row) AS select * from lineitem;
CREATE TABLE nation2 WITH (appendonly=true, orientation=row) AS select * from nation;
CREATE TABLE customer2 WITH (appendonly=true, orientation=row) AS select * from customer;
CREATE TABLE orders2 WITH (appendonly=true, orientation=row) AS select * from orders;
CREATE TABLE supplier2 WITH (appendonly=true, orientation=row) AS select * from supplier;



--should be worst
select customer.*, supplier.* from customer
    inner join supplier on s_nationkey = c_nationkey
    inner join orders on o_custkey = c_custkey
    where o_totalprice > 100000.0
    limit 600000;

-- should be better
select customer2.*, supplier2.* from customer2
    inner join supplier2 on s_nationkey = c_nationkey
    inner join orders2 on o_custkey = c_custkey
    where o_totalprice > 100000.0
    and 
    limit 600000;

-- BETTER column
select c_name, o_orderstatus, count(*) from customer
    inner join orders on c_custkey = o_custkey
    where o_totalprice > 100000.0
    group by o_custkey, o_orderstatus, c_name
    ;

select c_name, o_orderstatus, count(*) from customer2
    inner join orders2 on c_custkey = o_custkey
    where o_totalprice > 100000.0
    group by o_custkey, o_orderstatus, c_name
    ;

-- better
select supplier2.*, orders2.* from customer2
    inner join supplier2 on s_nationkey = c_nationkey
    inner join orders2 on o_custkey = c_custkey
    limit 400000;

select supplier.*, orders.* from customer
    inner join supplier on s_nationkey = c_nationkey
    inner join orders on o_custkey = c_custkey
    limit 400000;


select o_totalprice, o_orderstatus, o_orderdate, o_orderpriority, c_name, c_address from orders2
    inner join customer2 on c_custkey = o_custkey
    limit 100
    ;

select o_totalprice, o_orderstatus, o_orderdate, o_orderpriority, c_name, c_address from orders
    inner join customer on c_custkey = o_custkey
    limit 100
    ;