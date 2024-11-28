# **TechWave Electronics Sales and Marketing Analysis**  

## **Overview** 
TechWave Electronics is a global e-commerce company specializing in the sale of consumer electronics through its website and mobile app. The company, since its incorporation, has been collecting data on its sales performance, marketing effort, customer behavior, and product engagement. The project analyzed the sales and marketing data for a period covering January 2022 to August 2024 and aimed at uncovering insights that will guide the company's strategies and improve commercial performance.

## **Insights and recommendations will be provided on the following key sections** 
 **Sales Trends**  
   - Analysis of revenue fluctuations over time.

**Product-Level Performance**  
   - Evaluation of product revenue, conversion rates, and customer engagement metrics.
     
 **Customer Engagement and Loyalty**  
   - Insights into repeat purchase rates, customer satisfaction, and retention.

 **Marketing Campaign Effectiveness**  
   - Assessment of marketing ROI and lead conversion success.

An interactive Power BI Dashboard: [https://github.com/Catherinedataa/techwave-electronics-sales-marketing-analysis/blob/master/sales_marketing.pbix]
The SQL Queries used to inspect and perform quality checks: [https://github.com/Catherinedataa/techwave-electronics-sales-marketing-analysis/blob/master/data_quality_checks.sql]
The SQL Queries utilized to prepare the dashboard: [https://github.com/Catherinedataa/techwave-electronics-sales-marketing-analysis/blob/master/sales-marketing-queries.sql]

## ** Data Structure and Initial Checks**
TechWave's database structure consists of the following key tables:
•	sales_data: Contains transactional details such as sales amount, cost price, customer feedback, and IDs linking to related dimensions (e.g., product, customer, campaign, etc.).
•	dimcountry: Maps country and region details to transactions.
•	dimchannel, dimcustomer, dimleadsource, dimmarketingcampaign, dimproduct, dimsalesrep: Contain additional descriptive information for various dimensions related to sales.
![image](https://github.com/user-attachments/assets/69c7d9d0-8a54-48e6-975a-1a980840752c)

## ** Executive Summary **
  **Overview of Findings** 
From January 2022 to August 2024, TechWave Electronics exhibited different performances over the years. In 2022, it was a base year with no variation in revenue, conversion rates, and closed deals. In the year 2023, the company witnessed positive growth in revenue by 4.75% and a slight increment in closed deals by 1.20%, while the conversion rate decreased by -1.25%. Yet, for this year, revenue drastically went down by -34.89%, the average conversion rate also decreased by -0.43%, while the number of closed deals declined by as high as -30.18%. This decrease in performance during 2024, contrasting to the positive performance in 2023, highlights areas of concern that need to be addressed moving forward.

Below is an overview page from the Power BI dashboard, with additional examples provided throughout the report. The interactive dashboard can be accessed here: [https://github.com/Catherinedataa/techwave-electronics-sales-marketing-analysis/blob/master/sales_marketing.pbix]
 
 **Sales Trend Analysis** There has been significant fluctuations in both revenue and profit from 2022 to 2024. 2022 (Base Year): Revenue was $601k, while profit was at 132K. This was used as the base for comparison in further years. 2023: Revenue was $630k an increase of 4.75%, reflecting positive growth. The profit also increased moderately by 3.14% to 136K 2024: Both revenue and profit took a sharp downturn. Revenue as at August is $410K, a declined by 34.89%, and profit dropped by 37.16%, falling to 86K.
![image](https://github.com/user-attachments/assets/0ff7b47c-25ad-44ff-aa28-577d9ff97dc6)

**Lead and Marketing Campaign**
There are steady trends in lead performance and marketing campaign effectiveness from 2022 to 2024.
2022 (Base Year): Lead Conversion Rate was 78%, Average Revenue per Lead was $797.02, and Cost per Lead was $621.71, with a ROAS of 1.28.

2023: Lead Conversion Rate remained steady at 78%, while Average Revenue per Lead increased to $840.47. Cost per Lead increased by a small margin to $658.45, while ROAS remained the same at 1.28.

2024: Lead Conversion Rate slightly fell to 77%, Average Revenue per Lead was $824.75, and Cost per Lead decreased to $652.35. ROAS slightly decreased to 1.26.
Marketing campaigns such as Winter Promo and Spring Promo remained key revenue drivers. Summer Deals showed consistent seasonal performance. Email and social media were the top lead sources, with Referral yielding the highest revenue per lead.
 ![image](https://github.com/user-attachments/assets/63062b40-0fbd-4c42-b8fd-711e57f306bc)


**Customer Loyalty and Engagement**
There have been notable shifts in customer engagement and loyalty from 2022 to 2024.
2022 (Base Year): CLV was $975.58, NPS was -43.37, and Repeat Purchase Rate was 20.29%. Basic Plan customers outperformed Premium, especially in Europe.
2023: CLV increased slightly to $1.01k, while NPS remained negative at -42.46. Basic Plan continued to outperform Premium. Email and Referral channels drove higher CLV, and regions like Asia and North America showed potential for more premium engagement.
2024: CLV decreased to $927.37, while NPS worsened to -46.48. Repeat Purchase Rate dropped to 11.76%. Referral leads continued to be at the top; Cold Calling presented lower value. Basic Plan customers kept leading in value, while Premium Plan continued to struggle.
![image](https://github.com/user-attachments/assets/c8a8e4d5-3677-4ffe-8891-fa586019bbca)

**Product Performance Analysis**
Product performance has some fluctuation from 2022 to 2024.

2022 (Base Year): Revenue per Product, on average, was $40.06k, Product Conversion Rate was 7.79%, and Sales Growth was flat at 0%. High performers were strong, such as Headphones Plus, whereas Laptop Pro 14 underperformed.

2023: Revenue per Product increased to $41.97k, Conversion Rate reached 7.90%, and Sales Growth was 4.75%. Growth drivers were Drone Vision and Soundbar 360, while some products declined.
2024: Revenue per Product is $27.33k, decreased by -34.89% in sales growth. Remarkable decreases observed in Laptops Pro 14, Wireless Speakers. Meanwhile, companies performed quite nicely with respect to their counterparts for Gaming Consoles Z and Smart TVs QLED, respectively.
![image](https://github.com/user-attachments/assets/1bf99db9-0f05-48e3-a02a-247f98e4422e)

## **Recommendations**

Marketing Campaigns: Improve the visibility of their products in the market; this could be done better during peak sales months such as Black Friday and Cyber Monday. Use data effectively to discern target audiences for which one can craft campaigns for.

Product Bundles: Drone Vision can be bundled with other good-selling items or promotional discounting, especially during weak months to push sales.

Targeted Promotion: Develop targeted offers for low conversion rate products, such as Smartphone X and Gaming Console Z, to make them more attractive with price reductions, bundles, or special offers.

Customer Retention Strategy: Enhance the loyalty program by offering special incentives to repeat customers and have customer support teams be proactive in addressing any problems or feedback for lower-performing products.

Improve Organic Marketing Strategy: Enhance social media and SEO to generate high-quality leads for high-performing products.

Enhancing NPS for Underperforming Products: Increase the focus on customer feedback, enhance the quality of products, and work out solutions to customers' most frequently heard complaints, especially for Wireless Speaker and Laptop Pro 14.

## ** Caveats and Assumptions**

Product Life Cycle: Some products, especially electronic ones, may have naturally declined due to saturation and the introduction of new competing products.

Marketing Budget Variability: Changes in marketing budget and strategy across different months could have impacted performance. Budget adjustments were not uniform.

Customer Behavioral Change: Economic conditions or other technological advances in customer preferences and behavior may have changed how sales and marketing were able to function effectively.




