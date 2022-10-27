create database inclass

use inclass

select * from Bank_Account_Details
select * from Bank_Account_Relationship_Details
select * from BANK_ACCOUNT_TRANSACTION
select * from Bank_branch_PL
select * from Bank_customer
select * from Bank_customer_export
select * from BANK_CUSTOMER_MESSAGES
select * from BANK_INTEREST_RATE
select * from Bank_Inventory_pricing
select * from employee_details
select * from Department_Details

-- question-1
select product,price,sum(quantity) as quantity
from Bank_Inventory_pricing
where quantity >5
group by product,price;

--question-2
alter table bank_inventory_pricing
alter column purchase_cost float

select product,quantity,month, count(product)
from Bank_Inventory_pricing
where Estimated_sale_price < purchase_cost
group by product,quantity,month

update Bank_Inventory_pricing
set purchase_cost='null'
where purchase_cost='NULL'

--question-3
select top 1 * from (select top 3 Estimated_sale_price 
from Bank_Inventory_pricing
order by Estimated_sale_price desc) as temp 
order by Estimated_sale_price asc

--question-4
select product,count(product)as duplicate 
from Bank_Inventory_pricing
group by product
having count(product)>1

--question-5
select * from Bank_Inventory_pricing
create view bank_details1 as
select Product,Quantity,price from bank_inventory_pricing
where Product = 'PayPoints' and Quantity > 2;
select * FROM bank_details1;

--question-6
select * from bank_details1
update bank_details1
set quantity=3, price=410.67
where product = 'PayPoints'

select * from bank_details1

--question-7
select * from Bank_branch_PL 
select branch,sum(revenue-cost) as profit,sum(estimated_profit) 
from Bank_branch_PL
Group by branch
having (sum(revenue-cost)) > (sum(estimated_profit))

--question-8
select * from Bank_branch_PL 
select month,min(revenue-cost) as real_profit
from Bank_branch_PL
group by month 
having min(revenue-cost) > 0

--question-9
select quantity from Bank_Inventory_pricing

alter table bank_inventory_pricing
alter column quantity char

--question-10
select first_name, last_name 
from employee_details
where first_name like'%u%'

--question-11
select branch,product,
sum(revenue-(cost-cost*.30)) as profit,
sum(estimated_profit) as sum_estimated_profit
from bank_branch_PL
group by branch,product
having sum(revenue-(cost-cost*.30)) > sum(estimated_profit)

--question-12
select * from Bank_Inventory_pricing
where not product in ('busicard','supersave')

--question-13
select * from Bank_Inventory_pricing
where price between 220 and 300

--question-14
select distinct top 5 product as product_name from Bank_Inventory_pricing

--question-15
alter table Bank_Inventory_pricing
add  price_cal float

select * from Bank_Inventory_pricing
update Bank_Inventory_pricing
set price_cal = price + price*0.15
where quantity >3
select * from Bank_Inventory_pricing

--question-16
select * from Bank_Inventory_pricing
select round(price,0) from Bank_Inventory_pricing

--question-17
alter table bank_inventory_pricing
modify product varchar (30);


--question-18
alter table Bank_Inventory_pricing
add new_price float
update Bank_Inventory_pricing
set new_price = price+100
where Quantity > 3
select * from Bank_Inventory_pricing

---question-19--- question data is wrong--
select * from Bank_Account_Details
select * from Bank_Account_Relationship_Details

select account_type from Bank_Account_Relationship_Details
where account_type in ('saving_account','add-on credit card','credit card')

--question-20
select * from Bank_Account_Details
select * from BANK_ACCOUNT_TRANSACTION
select * from Bank_Account_Relationship_Details

select Bank_Account_Details.Account_Number,
       Bank_Account_Details.Account_type,
	   BANK_ACCOUNT_TRANSACTION.Transaction_amount,
	   bank_account_relationship_details.linking_account_number
from Bank_Account_Details inner join BANK_ACCOUNT_TRANSACTION
on Bank_Account_Details.Account_Number= BANK_ACCOUNT_TRANSACTION.Account_Number
inner join Bank_Account_Relationship_Details
on BANK_ACCOUNT_TRANSACTION.Account_Number = Bank_Account_Relationship_Details.Account_Number

--question-21
select * from BANK_ACCOUNT_TRANSACTION
select * from Bank_Account_Relationship_Details

select Bank_Account_Relationship_Details.Account_Number,
       Bank_Account_Relationship_Details.account_type,
	   sum(BANK_ACCOUNT_TRANSACTION.transaction_amount) as total_amount
from Bank_Account_Relationship_Details inner join BANK_ACCOUNT_TRANSACTION
on Bank_Account_Relationship_Details.Account_Number=BANK_ACCOUNT_TRANSACTION.Account_Number
where Account_type in ('Credit_Card','add-on credit card')
group by Bank_Account_Relationship_Details.Account_Number,Bank_Account_Relationship_Details.Account_type

--question-22
select * from BANK_ACCOUNT_TRANSACTION

select BANK_ACCOUNT_TRANSACTION.Account_Number,
       BANK_ACCOUNT_TRANSACTION.Transaction_amount,
       sum(transaction_amount) as aggregate_transaction_amount from BANK_ACCOUNT_TRANSACTION 
	   where Transaction_Date between '2020-04-01' and  '2020-04-30'
	   union all
	   select sum(transaction_amount) as aggregate_transaction_amount from BANK_ACCOUNT_TRANSACTION 
	   where Transaction_Date between '2020-03-01' and  '2020-03-30' and transaction_amount < 0


--question-27
select * from employee_details
select employee_id,first_name,last_name,phone_number,email,job_id
from employee_details
where not job_id = ('it_prog')

--question-30
select * from employee_details
select *  from Department_Details 

create table emp_dmpt(
empolyee_id float,
first_name nvarchar (255),
last_name nvarchar (255),
email nvarchar (255),
phone_number int,
hire_date date,
job_id nvarchar (255),
salary float,
manager_id int,
department_id int,
department_name nvarchar (255),
location_id int)

select * from emp_dmpt

insert into emp_dmpt
select employee_details.*,Department_Details.DEPARTMENT_NAME,Department_Details.LOCATION_ID
from employee_details inner join Department_Details
on employee_details.EMPLOYEE_ID = Department_Details.EMPLOYEE_ID

select * from emp_dmpt

--question-26
select * from Bank_Account_Details
select * from Bank_Account_Relationship_Details
select * from BANK_ACCOUNT_TRANSACTION

select Bank_Account_Details.Account_Number,
       Bank_Account_Details.account_type,
	   BANK_ACCOUNT_TRANSACTION.transaction_date
from Bank_Account_Details inner join bank_account_transaction
on Bank_Account_Details.Account_Number = bank_account_transaction.account_number
where Account_type in ('RECURRING_DEPOSITS', 'saving')
group by Bank_Account_Details.Account_Number,
         Bank_Account_Details.account_type,
         BANK_ACCOUNT_TRANSACTION.transaction_date

--question-25
select * from employee_details
select employee_id,first_name,last_name,phone_number,salary,job_id 
from employee_details
where employee_id = any(
select employee_id from Department_Details
WHERE DEPARTMENT_NAME='Contracting');

--question-24
select * from Bank_Account_Details
select * from BANK_ACCOUNT_TRANSACTION

select Bank_Account_Details.Account_Number,
	   BANK_ACCOUNT_TRANSACTION.Transaction_amount,
	   count(BANK_ACCOUNT_TRANSACTION.Transaction_amount) as No_transaction
from Bank_Account_Details inner join BANK_ACCOUNT_TRANSACTION
on Bank_Account_Details.Account_Number = BANK_ACCOUNT_TRANSACTION.Account_Number
where Account_type in ('credit card' , 'add-on credit card')
group by Bank_Account_Details.Account_Number,
         BANK_ACCOUNT_TRANSACTION.Transaction_amount
        

--question-29
select * from employee_details
select employee_id,last_name,phone_number,salary,job_id 
from employee_details
where employee_id =any( select employee_id from Department_Details
where MANAGER_ID = 60)
