-- The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.


-- Create Scripts

create table rating
(
customer_id number(5,0)
,runner_id number(5,0)
,rating number(5,3)
);
commit;

--Insert Scripts

insert into rating (customer_id,runner_id,rating) values (101,1,3);
insert into rating (customer_id,runner_id,rating) values (101,3,2.8);
insert into rating (customer_id,runner_id,rating) values (102,1,2.5);
insert into rating (customer_id,runner_id,rating) values (102,2,3.5);
insert into rating (customer_id,runner_id,rating) values (103,2,2.5);
insert into rating (customer_id,runner_id,rating) values (104,1,3.2);
insert into rating (customer_id,runner_id,rating) values (104,3,3.6);
insert into rating (customer_id,runner_id,rating) values (105,2,3.8);

--Revert Scripts
Drop table rating;