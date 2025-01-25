create database zomato;

describe customer_support_interaction;
describe goldusers_signup;
describe product;
describe product_location;
describe product_categories;
describe promotions;
describe ratings;
describe sales;
describe support_agents;
describe user_location;
describe users;

select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;
select * from customer_support_interaction;
select * from product_location;
select * from user_location;
select * from product_categories;
select * from promotions;
select * from ratings;
select * from support_agents;

/* A. Product Sales and Promotion Analysis. */
/* 1. What is the total number of products sold for each category? */
select p.category_id, c.category_name, count(s.product_id) as total_products_sold
from sales s
join product p on s.product_id = p.product_id
join product_categories c on p.category_id = c.category_id
group by p.category_id, c.category_name
order by total_products_sold desc;

/* 2. What are the top 5 best-selling products by total sales quantity? */
select p.product_name, count(s.product_id) as total_sales
from sales s
join product p on s.product_id = p.product_id
group by p.product_name
order by total_sales desc
limit 5;

/* 3. Which product category has the highest average sales price? */
select c.category_name, avg(p.price) as avg_price
from product p
join product_categories c on p.category_id = c.category_id
group by c.category_name
order by avg_price desc
limit 1;

/* 4. How many different products were promoted in 2022? */
select count(distinct p.product_id) as promoted_products_count
from promotions p
where p.start_date <= '2022-12-31'
  and p.end_date >= '2022-01-01';

/* 5. What is the total discount offered by each promotion? */
select p.promotion_id, sum(p.discount_percentage) as total_discount
from promotions p
group by p.promotion_id;

/*6. Which product had the highest total discount during the promotional period in 2021? */
select p.product_id, sum(p.discount_percentage) as total_discount
from promotions p
where p.start_date >= '2021-01-01' and p.end_date <= '2021-12-31'
group by p.product_id
order by total_discount desc;

/*7. What is the average discount percentage for promotions that lasted more than 10 days in 2023? */
select avg(p.discount_percentage) as avg_discount_percentage
from promotions p
where datediff(p.end_date, p.start_date) > 10
  and p.start_date >= '2023-01-01' and p.end_date <= '2023-12-31';

/*8. Which products have had the most promotions in the last year? */
select p.product_name, count(pr.promotion_id) as promo_count
from promotions pr
join product p on pr.product_id = p.product_id
where pr.start_date between '2023-01-01' and '2023-12-31'
group by p.product_name
order by promo_count desc
limit 5;

/* 9. How many unique users purchased products that were on promotion during the year 2022? */
select count(distinct s.userid) as unique_users
from sales as s
join promotions as p on s.product_id = p.product_id
where p.start_date <= '2022-12-31'
  and p.end_date >= '2022-01-01'
  and s.created_date between '2022-01-01' and '2022-12-31';

/* 10.  Which product category has the highest sales revenue from discounted products in the last year? */
select c.category_name, sum(p.price * (1 - pr.discount_percentage / 100)) as discounted_revenue
from sales s
join product p on s.product_id = p.product_id
join promotions pr on p.product_id = pr.product_id
join product_categories c on p.category_id = c.category_id
where pr.start_date between '2023-01-01' and '2023-12-31'
group by c.category_name
order by discounted_revenue desc
limit 6;

/* B. Customer Support Interaction and Feedback Analysis. */
/* 1. What is the total number of customer support interactions? */
select count(*) as total_interactions
from customer_support_interaction;

/* 2. What are the most common issues raised by customers? */
select issue_description, count(*) as issue_count
from customer_support_interaction
group by issue_description
order by issue_count desc;

/* 3. What is the average resolution time for support interactions? */
select avg(resolution_time) as avg_resolution_time
from customer_support_interaction
where status = 'Closed';

/* 4. Which product category has the most customer support interactions? */
select p.category_id, count(ci.interaction_id) as interaction_count
from customer_support_interaction ci
join sales s on ci.user_id = s.userid
join product p on s.product_id = p.product_id
group by p.category_id
order by interaction_count desc;

/* 5. How many interactions have occurred with Gold users? */
select count(*) as gold_user_interactions
from customer_support_interaction ci
join goldusers_signup gus on ci.user_id = gus.userid;

/* 6. How many interactions are still pending resolution? */
select count(*) as pending_interactions
from customer_support_interaction
where status = 'Pending';

/* 7.  What is the most common type of interaction (Phone, Chat)? */
select interaction_type, count(*) as interaction_count
from customer_support_interaction
group by interaction_type
order by interaction_count desc;

/* 8. Which issues are taking the longest to resolve? */
select issue_description, avg(resolution_time) as avg_resolution_time
from customer_support_interaction
where status = 'Closed'
group by issue_description
order by avg_resolution_time desc
limit 5;

/* 9. Which customer purchased which product and what changes were made (if any)? */
select u.userid, u.signup_date, p.product_name, 
       ci.issue_description as interaction_issue, 
       ci.resolution_time as interaction_resolution_time,
       ci.feedback as interaction_feedback
       from sales s
join product p on s.product_id = p.product_id
join users u on s.userid = u.userid
left join customer_support_interaction ci on s.userid = ci.user_id
order by u.userid, p.product_name;

/* 10. What percentage of support interactions were resolved with positive and negative feedback? */
		select (count(case 
						when feedback like '%help%' 
						or feedback like '%excellent%' 
						or feedback like '%satisfied%' 
						or feedback like '%great%' 
						or feedback like '%quick%' 
						or feedback like '%quickly%' 
						or feedback like '%helpful%' 
						or feedback like '%perfectly%' 
						or feedback like '%good%' 
						or feedback like '%prompt%' 
					   then 1 
					   end) * 100.0 / count(*)) as positive_feedback_percentage,
			(count(case 
					   when feedback like '%not resolved%' 
					   then 1 
					   end) * 100.0 / count(*)) as negative_feedback_percentage
			from customer_support_interaction
			where status = 'Closed';

/* C. User Behavior and Product Preferences. */
/* 1. What are the top 5 most purchased products? */
select product_name, count(*) as total_sales
from sales s
join product p on s.product_id = p.product_id 
group by product_name
order by total_sales desc
limit 5;

/* 2. What are the average ratings of each product? */
select product_id, avg(rating) as avg_rating
from ratings
group by product_id
order by avg_rating desc;

/* 3. Which products have received the most 5-star ratings? */
select product_id, count(*) as five_star_count
from ratings
where rating = 5
group by product_id
order by five_star_count desc;

/* 4. Which products have the highest sales and the best average rating among users? */
select p.product_id, p.product_name, count(s.product_id) as total_sales, avg(r.rating) as avg_rating
from sales s
join product p on s.product_id = p.product_id
join ratings r on s.product_id = r.product_id
group by p.product_id, p.product_name
order by total_sales desc, avg_rating desc
limit 5;

/*5. What are the top 5 most common products bought together (i.e., co-purchases)? */
select s1.product_id as product_1, s2.product_id as product_2, count(*) as co_purchase_count
from sales s1
join sales s2 on s1.userid = s2.userid and s1.product_id != s2.product_id
group by s1.product_id, s2.product_id
order by co_purchase_count desc
limit 5;

/* 6. Which product category has the highest average user rating? */
select p.category_id, avg(r.rating) as avg_category_rating
from product p
join ratings r on p.product_id = r.product_id
group by p.category_id 
order by avg_category_rating desc;

/* 7.  Which product has the highest total revenue? */
select s.product_id, p.product_name, sum(p.price) as total_revenue
from sales s
join product p on s.product_id = p.product_id
group by s.product_id, p.product_name 
order by total_revenue desc
limit 1;

/* 8. How many products did each user buy? */
select u.userid, group_concat(distinct p.product_name) as products_bought
from sales s
join product p on s.product_id = p.product_id
join users u on s.userid = u.userid
group by u.userid
order by count(distinct s.product_id) desc;

 /* 9. What is the average rating for each product category? */
select c.category_name, avg(r.rating) as avg_rating
from ratings r
join product p on r.product_id = p.product_id
join product_categories c on p.category_id = c.category_id
group by c.category_name
order by avg_rating desc;

/* 10. Which users have provided feedback on the most products and given them the highest ratings? */
select u.userid, 
       count(distinct r.product_id) as total_feedbacks, 
       csi.feedback as feedback, 
       avg(r.rating) as avg_rating
from users u
join ratings r on u.userid = r.userid
join customer_support_interaction csi on u.userid = csi.user_id
group by u.userid, csi.feedback
order by total_feedbacks desc, avg_rating desc, feedback
limit 5;

/* D. Geographical Analysis of Product Distribution and Sales. */
/* 1.  What is the total sales revenue from each product category in different locations? */
select ul.location, pc.category_name, sum(p.price) as total_sales_revenue
from sales s
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
join product_categories pc on p.category_id = pc.category_id
group by ul.location, pc.category_name
order by total_sales_revenue desc;

/* 2. Which locations have the highest rating for products sold? */
select ul.location, avg(r.rating) as avg_product_rating
from ratings r
join user_location ul on r.userid = ul.user_id
group by ul.location
order by avg_product_rating desc;

/* 3. Which locations have the highest number of products sold? */
select ul.location, count(s.product_id) as products_sold
from sales s
join user_location ul on s.userid = ul.user_id
group by ul.location
order by products_sold desc;

/* 4. What is the sales distribution of products in each warehouse and store? */
select pl.location, p.product_name, sum(p.price) as total_sales
from product_location pl
join product p on pl.product_id = p.product_id
join sales s on s.product_id = p.product_id
group by pl.location, p.product_name
order by total_sales desc;

/* 5. What is the total number of products sold per category by location?  */
select ul.location, pc.category_name, count(s.product_id) as products_sold
from sales s
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
join product_categories pc on p.category_id = pc.category_id
group by ul.location, pc.category_name
order by products_sold desc;

/* 6. Which location made the highest profits in total sales? */
select 
    pl.location as product_location,
    sum(p.price) as total_sales_value
from 
    sales s
join product p on s.product_id = p.product_id
join product_location pl on p.product_id = pl.product_id
group by 
    pl.location
order by 
    total_sales_value desc
limit 1;

/* 7. Which product was rated by which user, and from which user location? */
select
    p.product_name,
    r.rating,
    r.userid as user_id,
    ul.location as user_location,
    r.rating_date
from 
    ratings r
join product p on r.product_id = p.product_id
join user_location ul on r.userid = ul.user_id
order by r.rating_date desc;

/* 8. Which product has been delivered to which user, by location, and from which product location? */
select 
    p.product_name,
    s.userid as user_id,
    ul.location as user_location,
    pl.location as product_location
from 
    sales s
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
join product_location pl on p.product_id = pl.product_id
order by user_id, p.product_name;

/* 9. Which locations have the highest and lowest sales for each product? */
select 
    p.product_name, 
    ul.location as user_location, 
    count(s.product_id) as total_sales, 
    max(s.created_date) as last_sale_date
from sales s
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
group by p.product_name, ul.location
order by total_sales desc;

/* 10. How does the distribution of sales vary by location and month? */
select ul.location, 
       extract(month from s.created_date) as month,
       extract(year from s.created_date) as year,
       sum(p.price) as total_sales
from sales s
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
group by ul.location, year, month
order by year desc, month desc;

/* E. Comprehensive Product and Customer Segmentation Analysis with Category Insights. */
/* 1. What are the top 5 products purchased by gold users, and how does their geographical location affect their purchase behavior? */
select ul.location, p.product_name, count(s.product_id) as purchase_count
from sales s
join goldusers_signup gsu on s.userid = gsu.userid
join product p on s.product_id = p.product_id
join user_location ul on s.userid = ul.user_id
group by ul.location, p.product_name
order by purchase_count desc
limit 5;

/* 2. What is the average product rating by category, and how does it correlate with customer support interaction (feedback and resolution time)? */
select pc.category_name, avg(r.rating) as avg_rating, count(c.feedback) as feedback_counts, avg(c.resolution_time) as avg_resolution_time
from ratings r
join product p on r.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join customer_support_interaction c on r.userid = c.user_id
group by pc.category_name;

/* 3. Which geographical regions have the highest sales of products in the "Food" category and how do promotions impact these sales? */
select 
    ul.location, 
    pc.category_name,
    p.product_name,
    sum(s.product_id) as total_sales,
    count(s.product_id) as purchase_count,
    pl.location as product_location,
    count(distinct s.userid) as unique_buyers,
    max(pr.discount_percentage) as promo_discount
from sales s
join product p on s.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join user_location ul on s.userid = ul.user_id
join product_location pl on p.product_id = pl.product_id
left join promotions pr on p.product_id = pr.product_id
join users u on s.userid = u.userid
where pc.category_name = 'Food'
group by ul.location, pc.category_name, p.product_name, pl.location
order by total_sales desc;

/* 4. Which geographical region has the highest average customer feedback for products in the "Food" category, and what is the correlation with the number of promotions during that period? */
select 
    ul.location as user_location,
    pc.category_name,
    avg(r.rating) as avg_rating,
    csi.feedback as feedback,
    count(pr.promotion_id) as total_promotions,
    count(s.product_id) as total_purchases
from ratings r
join product p on r.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join customer_support_interaction csi on r.userid = csi.user_id
join user_location ul on r.userid = ul.user_id
left join sales s on r.userid = s.userid and r.product_id = s.product_id
left join promotions pr on p.product_id = pr.product_id
where pc.category_name = 'Food'
group by ul.location, pc.category_name, csi.feedback
order by avg_rating desc;

/* 5. How does customer feedback on products in the "Beverages" category correlate with their location and promotion periods? */
select 
    pc.category_name, 
    avg(r.rating) as avg_rating,  
    csi.feedback as feedback,
    ul.location as user_location, 
    pr.discount_percentage as promotion_discount,
    count(s.product_id) as total_purchases
from sales s
join product p on s.product_id = p.product_id
join customer_support_interaction csi on s.userid = csi.user_id
join product_categories pc on p.category_id = pc.category_id
join user_location ul on s.userid = ul.user_id
join promotions pr on p.product_id = pr.product_id
join ratings r on s.userid = r.userid and s.product_id = r.product_id
where pc.category_name = 'Beverages'
group by pc.category_name, ul.location, pr.discount_percentage, csi.feedback;

/* 6. Which product categories have the highest average rating, and how does the location of users influence these ratings? */
select 
    pc.category_name, 
    avg(r.rating) as avg_rating,
    ul.location as user_location
from ratings r
join product p on r.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join user_location ul on r.userid = ul.user_id
join users u on r.userid = u.userid
group by pc.category_name, ul.location
order by avg_rating desc;

/* 7. What is the total number of support interactions for each product category, and how does the resolution time vary by geographical region? */
select 
    pc.category_name,
    ul.location as user_location,
    count(csi.interaction_id) as total_interactions,
    avg(csi.resolution_time) as avg_resolution_time
from customer_support_interaction csi
join sales s on csi.user_id = s.userid
join product p on s.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join user_location ul on csi.user_id = ul.user_id
group by pc.category_name, ul.location
order by total_interactions desc;

/* 8. How does the purchase behavior of gold users differ by product category, and what impact do promotions have on these purchases? */
select 
    pc.category_name, 
    count(s.product_id) as purchase_count, 
    sum(p.price) as total_sales,
    max(pr.discount_percentage) as promo_discount,
    ul.location as user_location
from sales s
join goldusers_signup gsu on s.userid = gsu.userid
join product p on s.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
left join promotions pr on p.product_id = pr.product_id
join users u on s.userid = u.userid
join user_location ul on s.userid = ul.user_id
group by pc.category_name, ul.location;

/* 9. How do customer ratings for products in the "Bakery items" category correlate with the duration of promotions (start to end dates) and the support agents handling the cases? */
select 
    pc.category_name,
    coalesce(sa.agent_name, '0') as support_agent,
    avg(r.rating) as avg_rating,
    datediff(pr.end_date, pr.start_date) as promotion_duration,
    count(s.product_id) as total_purchases
from ratings r
join product p on r.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
left join promotions pr on p.product_id = pr.product_id
left join customer_support_interaction csi on r.userid = csi.user_id
left join support_agents sa on csi.support_agent_id = sa.agent_id
left join sales s on r.userid = s.userid and r.product_id = s.product_id
where pc.category_name = 'Bakery items'
group by pc.category_name, sa.agent_name, promotion_duration
order by avg_rating desc;

/* 10. What is the most popular product in the "Groceries" category by sales, and how does its customer support feedback compare across different geographical regions?  */
select
    p.product_name,
    pc.category_name,
    ul.location as user_location,
    count(s.product_id) as total_sales,
    avg(csi.resolution_time) as avg_resolution_time,
    coalesce(avg(r.rating), '0') as avg_rating
from sales s
join product p on s.product_id = p.product_id
join product_categories pc on p.category_id = pc.category_id
join user_location ul on s.userid = ul.user_id
left join customer_support_interaction csi on s.userid = csi.user_id and s.product_id = p.product_id
left join ratings r on s.userid = r.userid and s.product_id = r.product_id
where pc.category_name = 'Groceries'
group by p.product_name, ul.location
order by total_sales desc
limit 1;









































    
































