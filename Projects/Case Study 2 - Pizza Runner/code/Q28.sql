/*If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?*/

It will majory affect on below tables :
1. pizza_names
2. pizza_recipes

-- Insert Scripts

insert into pizza_names(pizza_id,pizza_name) values (3,'Supreme');
insert into pizza_recipes(pizza_id,toppings) values (3,'1,2,3,4,5,6,7,8,9,10,11,12');