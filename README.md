# Restaurant-Sales-and-Customer-Behavior-Analysis-Using-SQL

Table of Contents

- [Project Background](#project-background)
- [Database Overview](#database-overview)
- [Executive Summary](#executive-summary)
- [Insights Deep-Dive](#insights-deep-dive)
    - [Top Menu Items Performance](#top-menu-items-performance)
    - [Category Revenue & Sales Trends](#category-revenue-and-sales-trends)
    - [Least & Most Ordered Items Analysis](#least-and-most-ordered-items-analysis)
    - [Monthly & Category Sales Peaks](#monthly-and-category-sales-peaks)
    - [Sales by Platforms & Channels](#peak-days-and-hours-for-resource-allocation)
- [Recommendations](#recommendations)

***

## Project background

Fork & Feast is a mid-sized restaurant chain established in 2019, known for its diverse menu and strong customer base across urban locations. To support data-informed decision-making, using MySQL, this project analyzes 12,000 restaurant order records from January 1 to March 9, 2023, this project aims to analyze sales trends, item popularity, customer behavior, and peak business hours—ultimately providing data-backed recommendations to enhance performance across kitchen operations, product development, and marketing strategies.

## Database Overview

The restaurant sales analysis is based on two relational tables: menu_items and order_details. These tables are linked through a common key <i><strong>"menu_item_id"</strong></i> and <i><strong>"item_id"</strong></i>
### 1. menu_items Table
<ul>
    <li>menu_item_id – Unique identifier for each menu item (Primary Key)</li>
    <li>item_name – Name of the food or beverage item</li>
    <li>category – Cuisine or food type classification (e.g., Asian, Italian, American)</li>
    <li>price – Selling price of the menu item</li>
</ul>

### 2. order_details Table
<ul>
    <li>order_id – Unique identifier for each order transaction (Primary Key).</li>
    <li>order_date – The date on which the order was placed.</li>
    <li>order_time – The specific time the order was placed.</li>
    <li>menu_item_id – Foreign key referencing menu_item_id in the menu_items table.</li>
</ul>

![Image](https://github.com/user-attachments/assets/d2ba5c6f-ecef-4fc6-8853-cd1a1de7ddbe)

## Executive Summary
 The dataset combines detailed transactional data from two core tables—menu_items and order_details—capturing item categories, pricing, order timing, and frequency.

The analysis reveals that the Hamburger leads in orders (622) and significant revenue ($8,054.90), with Asian and Italian cuisines dominating top-performing categories, generating $46.7K and $49.5K in revenue respectively. March had the highest sales ($54,610.60), driven primarily by Italian dishes ($17,189.90). Monday is the peak day with 1,988 orders and ₹26,007.45 sales, while 12 PM is the busiest hour (1,659 orders, $21,718.40). The least ordered items include Chicken Tacos (123 orders).

## Insights Deep-Dive

### Top Menu Items Performance
<ul>
    <li>Hamburger leads with 622 orders, generating $8,054.90 in revenue, confirming its role as a consistent bestseller and staple item.</li>
    <li>Korean Beef Bowl, with 588 orders, generates the highest revenue of $10,554.60, highlighting the effectiveness of premium pricing and customer willingness to pay more.</li>
    <li>Vegetarian Tofu Pad Thai records 455 orders and $8,149.00 in revenue, indicating strong demand for plant-based options and supporting menu diversity.</li>
    <li>The presence of American, Asian, and Italian dishes among top sellers shows a balanced international mix, suggesting potential for fusion dishes and targeted themed promotions to attract varied customer segments.</li>
</ul>

### Category Revenue And Sales Trends
<ul>
    <li>Asian cuisine dominates with 9,280,150 in sales and $46,720.65 in revenue, justifying increased investment in menu innovation and expansion.</li>
    <li>Italian cuisine, generating 7,974,281 in sales but higher revenue of $49,462.70, indicates premium pricing; consider introducing upscale offerings and upselling strategies.        </li>
    <li>Mexican (7,820,101 sales, $34,796.80 revenue) and American (7,497,477 sales, $28,237.75 revenue) categories, though popular, underperform in revenue; explore price                 adjustments or refresh menu to boost profitability.</li>
    <li>Prioritize marketing campaigns on Asian and Italian cuisines to capitalize on higher sales volume and margins for better ROI.</li>
</ul>

### Least And Most Ordered Items Analysis
<ul>
    <li>Hamburger (622 orders, American) and Edamame (620 orders, Asian) lead in popularity, driving significant foot traffic; prioritize their quality and availability to maintain customer loyalty.</li>
    <li>Chicken Tacos (123 orders, Mexican) and Potstickers (135 orders, Asian) show low demand; consider rebranding, adjusting pricing, or removal to optimize menu efficiency.</li>
    <li>These underperformers contribute to menu clutter, increasing operational complexity and reducing profitability.</li>
    <li>Balanced mix of international cuisines suggests opportunity to highlight fusion dishes or themed promotions.</li>
</ul>

### Monthly And Category Sales Peaks
<ul>
<li>March records the highest order value at $54,610.60, driven primarily by Italian ($17,189.90) and Asian ($16,056.45) food sales; ensure inventory and staffing align with this demand surge.</li>
<li>Italian cuisine’s strong contribution (31% of March sales) suggests aggressive promotion during peak months can maximize revenue.</li>
<li>Mexican ($11,358.50) and American ($10,005.75) sales are lower in March; monitor for seasonal trends and adjust offerings accordingly.</li>
<li>Leveraging monthly sales data enables targeted promotions and accurate demand forecasting, reducing waste and improving profitability.</li>
</ul>

### Peak Days And Hours for Resource Allocation
<ul>
<li>Mondays record the highest orders (1,988) and sales (₹26,007.45); increase staff and inventory to meet peak demand efficiently.</li>
<li>Wednesdays show the lowest orders (1,522) and sales (₹19,902.30), indicating a mid-week slump; leverage targeted promotions or discounts to boost traffic.</li>
<li>Peak hours are 12 PM (1,659 orders, $21,718.40 revenue) and 1 PM (1,558 orders, $20,640.25 revenue), with strong sales continuing through 4–6 PM; optimize kitchen staffing and delivery logistics during these times.</li>
<li>Early morning at 10 AM sees only 5 orders ($63.35 revenue), and late nights (10–11 PM) fall below 305 orders and $4,100 revenue; consider reducing operational costs or running incentive campaigns to increase off-peak sales.</li>
</ul>

## Recommendations
<ul>
<li>Promote High-Performing Categories (Asian & Italian):
Since Asian and Italian dishes lead in both sales and revenue, the restaurant should expand these offerings by adding premium versions, seasonal specials, and focused promotions—especially in peak months like March—to drive customer interest and boost profits.</li>

<li>Streamline the Menu by Removing Unpopular Items:
Items like Chicken Tacos and Potstickers are underperforming and add to kitchen complexity. These should be improved, rebranded, or replaced with trending options such as fusion or plant-based dishes to enhance efficiency and better meet customer preferences.</li>

<li>Optimize Staffing and Inventory by Time:
Mondays and lunch hours are peak periods and require more staff and stock to meet demand. During slow times like early mornings and late nights, the restaurant should reduce staffing or offer discounts to cut costs and attract customers.</li>
</ul>
