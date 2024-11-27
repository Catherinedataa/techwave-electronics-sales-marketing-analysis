-- Key Performance Indicators --
SELECT
     SUM(`Sales Amount (USD)`) AS Total_Revenue
FROM
    sales_data;
    
SELECT 
     SUM(`Cost Price (USD)`) AS Total_Cost
FROM 
    sales_data;
    
-- Profit --
SELECT
      SUM(`Sales Amount (USD)`) - SUM(`Cost Price (USD)`) AS Profit
FROM
    sales_data;
    
-- Average Conversion Rate--
SELECT
     AVG(`Conversion Rate (%)`) AS Avg_Conversion_Rate
FROM
    sales_data;
    
-- Total Views --
SELECT
     SUM(Views) AS Total_Views
FROM
    sales_data;
    
-- Closed Deals --
SELECT
     COUNT(*) AS Closed_Deals
FROM 
    sales_data
WHERE
     `Closed Deal?`='Yes';
-- Monthly Revenue Performance vs Target--

SELECT 
     YEAR(sd.`Sales Date`) AS Year,
     MONTH(sd.`Sales Date`) AS Month,
     SUM(sd.`Sales Amount (USD)`) AS Monthly_Revenue,
     LAG(SUM(sd.`Sales Amount (USD)`), 1) OVER (ORDER BY YEAR(sd.`Sales Date`), MONTH(sd.`Sales Date`)) AS Previous_Month_Revenue
FROM 
    sales_data sd
WHERE sd.`Sales Date` BETWEEN '2022-01-01' AND '2024-09-30'
GROUP BY 
       YEAR(sd.`Sales Date`), MONTH(sd.`Sales Date`)
ORDER BY 
       Year, Month;
       
-- Monthly Profit Margin Trend --
SELECT
      YEAR (sd.`Sales Date`) AS Year,
      MONTH(sd.`Sales Date`) AS Month,
      SUM(sd.`Sales Amount (USD)`) AS Total_Revenue,
      SUM(sd.`Cost Price (USD)`) AS Total_Cost,
      ROUND((SUM(sd.`Sales Amount (USD)`) - SUM(sd.`Cost Price (USD)`)) / NULLIF(SUM(sd.`Sales Amount (USD)`),0) * 100,2) AS Profit_Margin_Percentage
FROM
    sales_data sd
WHERE 
     sd.`Sales Date` BETWEEN '2022-01-01' AND '2024-09-30'
GROUP BY 
       YEAR(sd.`Sales Date`) , MONTH(sd.`Sales Date`)
ORDER BY
       Year, Month;
       
-- Revenue Distribution by Marketing Campaign -- 
SELECT
     mc.`Marketing Campaign` AS Marketing_Campaign,
     SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
FROM 
     sales_data sd
JOIN
	dimmarketingcampaign mc ON sd.`Campaign ID` = mc.`Campaign ID`
GROUP BY
       mc.`Marketing Campaign`
ORDER BY
       Total_Revenue DESC;
       
-- Regional Revenue Distribution --
SELECT
     c.Region AS Region_Name,
     SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
FROM 
     sales_data sd
JOIN
	dimcountry c ON sd.`Country ID` = c.`Country ID`
GROUP BY
       c.Region
ORDER BY
       Total_Revenue DESC;
       
-- Revenue Contribution by Lead Source--
SELECT
     ls.`Lead Source` AS Lead_Source,
     SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
FROM 
     sales_data sd
JOIN
	dimleadsource ls ON sd.`Lead Source ID` = ls.`Lead Source ID`
GROUP BY
       ls.`Lead Source`
ORDER BY
       Total_Revenue DESC;
       
-- Country Wise Sales Performance Overview --
SELECT
      dc.`Country Name` AS Country,
      SUM(sd.`Sales Amount (USD)`) AS Total_Revenue,
      ROUND((SUM(CASE WHEN YEAR (sd.`Sales Date`) = 2024 THEN sd.`Sales Amount (USD)` ELSE 0 END) -
             SUM(CASE WHEN YEAR(sd.`Sales Date`) = 2023 THEN sd.`Sales Amount (USD)` ELSE 0 END)) /
             NULLIF(SUM(CASE WHEN YEAR(sd.`Sales Date`) = 2023 THEN sd.`Sales Amount (USD)` ELSE 0 END), 0) *100, 2) AS YoY_Growth_Rate,
	 COUNT(DISTINCT CASE WHEN sd.`Closed Deal?`='Yes' THEN  sd.`Customer ID` END) AS Closed_Deals,
     ROUND((SUM(sd.`Sales Amount (USD)`) - SUM(sd.`Cost Price (USD)`)) / NULLIF(SUM(sd.`Sales Amount (USD)`),0) * 100,2) AS Profit_Margin_Percentage
FROM
   sales_data sd
JOIN 
    dimcountry dc ON sd.`Country ID` = dc.`Country ID`
GROUP BY 
      dc.`Country Name`
ORDER BY 
       Total_Revenue DESC;
   
       
     
     -- Lead & Marketing Campaign --
-- Lead Conversion Rate --
SELECT
     ROUND(
          (COUNT(CASE WHEN sd.`Closed Deal?`='Yes' THEN sd.`Customer ID` END) * 1.0) /
          NULLIF(COUNT(sd.`Customer ID`), 0) * 100,
          2
          ) AS Lead_Conversion_Rate
FROM
    sales_data sd;
    
-- Average Revenue Per Lead --
SELECT 
     ROUND(
          SUM(sd.`Sales Amount (USD)`) / NULLIF(COUNT(sd.`Lead Source ID`), 0),
          2
	  ) AS Avg_Revenue_Per_Lead
FROM 
    sales_data sd;

-- Cost Per Lead --
SELECT
    ROUND(
		SUM(sd.`Cost Price (USD)`) / NULLIF(COUNT(sd.`Lead Source ID`), 0),
        2
	) AS Cost_Per_Lead
FROM
   sales_data sd;
   
-- Return on Ad Spend --
SELECT
    ROUND(
	  SUM(sd.`Sales Amount (USD)`) / NULLIF(SUM(sd.`Cost Price (USD)`), 0),
      2
	) AS Return_on_Ad_Spend
FROM
    sales_data sd;
    
-- Lead Conversion Funnel --
-- Total Leads --
SELECT 
     COUNT(*) AS Total_Leads
FROM
    sales_data
WHERE 
    `Lead Source ID` IS NOT NULL;
    
-- Total Follow ups --
SELECT 
      COUNT(DISTINCT(`Customer ID`)) AS DistinctFollowups
FROM
     sales_data
WHERE `Follow-ups` > 0;

-- Closed Deals --
SELECT
     COUNT(DISTINCT(`Customer ID`)) AS DistinctClosedDeals
FROM
    sales_data
WHERE
     `Closed Deal?` = 'Yes';
     
-- Monthly Revenue Trends by Marketing Campaign --
SELECT
     YEAR(sd.`Sales Date`) AS Year,
     MONTH(sd.`Sales Date`) AS Month,
     mc.`Marketing Campaign`,
     SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
FROM 
    sales_data sd
JOIN 
    dimmarketingcampaign mc ON sd.`Campaign ID` = mc.`Campaign ID`
GROUP  BY
      YEAR(sd.`Sales Date`),
      MONTH(sd.`Sales Date`),
	  mc.`Marketing Campaign`
ORDER BY 
      YEAR(sd.`Sales Date`) ASC,
      MONTH(sd.`Sales Date`) ASC,
      mc.`Marketing Campaign`;
-- Revenue and Cost Breakdown by Lead Source --
SELECT 
      ds.`Lead Source` AS LeadSource,
      SUM(sd.`Sales Amount (USD)`) AS TotalRevenue,
      SUM(sd.`Cost Price (USD)`) AS TotalCost,
      CASE
          WHEN COUNT(sd.`Customer ID`) =  0 THEN 0
          ELSE SUM(sd.`Sales Amount (USD)`) / COUNT(sd.`Customer ID`)
	END AS AvgRevenuePerLead
FROM 
    sales_data sd
JOIN 
    dimleadsource ds ON sd.`Lead Source ID` = ds.`Lead Source ID`
GROUP BY
       ds.`Lead Source`;
       
-- Lead and Conversion Rate by Marketing Campaign --
WITH ConversionCategory AS (
	SELECT 
        d.`Marketing Campaign`,
        COUNT(s.`Lead Source ID`) AS TotalLeads,
        CASE
            WHEN s.`Conversion Rate (%)` > 25 THEN 'High'
            WHEN s.`Conversion Rate (%)` BETWEEN 10 AND 25 THEN 'Medium'
            ELSE 'Low'
		END AS ConversionRateCategory
	FROM
        sales_data s
	JOIN 
       dimmarketingcampaign d ON s.`Campaign ID` = d.`Campaign ID`
	GROUP BY 
        d.`Marketing Campaign`,
        CASE
            WHEN s.`Conversion Rate (%)` > 25 THEN 'High'
            WHEN s.`Conversion Rate (%)` BETWEEN 10 AND 25 THEN 'Medium'
            ELSE 'Low'
		END
	)
    SELECT 
         `Marketing Campaign`,
         ConversionRateCategory,
         TotalLeads
	FROM
        ConversionCategory
	ORDER BY
           `Marketing Campaign`, `ConversionRateCategory`;
           
-- Lead Source Performance Breakdown --
SELECT
     dl.`Lead Source`,
     COUNT(sd.`Lead Source ID`) AS TotalLeads,
     SUM(sd.`Sales Amount (USD)`) AS TotalRevenue,
     SUM(sd.`Cost Price (USD)`) AS TotalCost,
     CASE
        WHEN COUNT(sd.`Lead Source ID`) = 0 THEN 0
        ELSE SUM(sd.`Cost Price (USD)`) / COUNT(sd.`Lead Source ID`)
	END AS CostPerLead,
    CASE WHEN COUNT(sd.`Lead Source ID`) = 0 THEN 0
        ELSE SUM(sd.`Sales Amount (USD)`) / COUNT(sd.`Lead Source ID`)
	END AS RevenuePerLead,
    CASE WHEN SUM(sd.`Cost Price (USD)`) = 0 THEN 0
        ELSE SUM(sd.`Sales Amount (USD)`) / SUM(sd.`Cost Price (USD)`)
	END AS ROAS
FROM
    sales_data sd
JOIN 
      dimleadsource dl ON sd.`Lead Source ID`= dl.`Lead Source ID`
GROUP BY 
       dl.`Lead Source`
ORDER BY
       TotalLeads DESC;

-- Customer Engagement and Loyalty --

USE sales_marketing;
-- Customer Lifetime Value --
SELECT
      SUM(ds.`Sales Amount (USD)`) / COUNT(DISTINCT `Customer ID`) AS `Customer Lifetime Value`
FROM 
     sales_data ds;
 
 -- Net Promoter Score --
 SELECT 
      (COUNT(CASE WHEN `Customer Rating` >= 9 AND `Customer Rating` <= 10 THEN 1 END) * 100.0 / COUNT(*)) AS Promoter_Percentage,
      (COUNT(CASE WHEN `Customer Rating` >= 0 AND `Customer Rating` <= 6 THEN 1 END) * 100.0 / COUNT(*)) AS Detractor_Percentage,
      (COUNT(CASE WHEN `Customer Rating` >= 9 AND `Customer Rating` <= 10 THEN 1 END) * 100.0 / COUNT(*)) - 
      (COUNT(CASE WHEN `Customer Rating` >= 0 AND `Customer Rating` <= 6 THEN 1 END) * 100.0 / COUNT(*)) AS NPS
FROM 
    sales_data;
    
-- Average Customer Rating --
SELECT 
      AVG(`Customer Rating`) AS `Average Customer Rating`
FROM
    sales_data;
      
-- Repeat Purchase Rate -- 
SELECT
     (COUNT(DISTINCT CASE WHEN purchase_count > 1 THEN  `Customer ID` END) /
     COUNT(DISTINCT `Customer ID`)) * 100 AS Repeat_Purchase_Rate
FROM
    (SELECT `Customer ID`, COUNT(*) AS purchase_count
     FROM sales_data
     GROUP BY `Customer ID`) AS `Customer Purchases`;
     
-- Monthly Customer Engagement Score   vs Previous Month --
SELECT
     YEAR(sd.`Sales Date`) AS Year,
     MONTH(sd.`Sales Date`) AS Month,
     AVG(sd.Sessions) * 0.5 + AVG(sd.Views) * 0.5  AS `Customer Engagement Score`
FROM
    sales_data sd
GROUP BY 
    YEAR(sd.`Sales Date`), MONTH(sd.`Sales Date`)
ORDER BY
     Year, Month;
	
-- Customer Lifetime Value by Plan --
SELECT
     sd.`Customer Plan`,
     dl.`Lead Source`,
     CASE
         WHEN sd.`Customer Rating` >= 1 AND sd.`Customer Rating` <= 3 THEN 'Low Rating'
         WHEN sd.`Customer Rating` >= 4 AND sd.`Customer Rating` <= 6 THEN 'Medium Rating'
         WHEN sd.`Customer Rating` >= 7 AND sd.`Customer Rating` <= 10 THEN 'High Rating'
         ELSE 'Undefined Rating'
	END AS Customer_Rating_Category,
     dc.`Region`,
     (SUM(sd.`Sales Amount (USD)`) / COUNT(DISTINCT sd.`Customer ID`)) AS Customer_Lifetime_Value
FROM
    sales_data sd
JOIN 
   dimleadsource dl ON sd.`Lead Source ID` = dl.`Lead Source ID`
JOIN
   dimcountry dc ON sd.`Country ID` = dc.`Country ID`
GROUP BY
      sd.`Customer Plan`,
      dl.`Lead Source`,
      Customer_Rating_Category,
      dc.`Region`
ORDER BY
       sd.`Customer Plan`,
       dl.`Lead Source`,
       Customer_Rating_Category,
       dc.`Region`;
       
-- Promoters, Passives & Detractors --
WITH NPS_Categories AS (
     SELECT
        CASE
          WHEN sd.`Customer Rating` >= 0 AND sd.`Customer Rating` <= 6 THEN 'Detractors'
          WHEN sd.`Customer Rating` >= 7 AND sd.`Customer Rating` <= 8 THEN 'Passives'
          WHEN sd.`Customer Rating` >= 9 AND sd.`Customer Rating` <= 10 THEN 'Promoters'
          ELSE 'Undefined'
		END AS NPS_Category,
        COUNT(*) AS Category_Count
	FROM
        sales_data sd
	GROUP BY
        NPS_Category
	),
    Total_Count AS(
          SELECT
              SUM(Category_Count) AS Total_Customers
		   FROM NPS_Categories
	)
    
    SELECT 
        NPS.NPS_Category,
        NPS.Category_Count,
        ROUND((NPS.Category_Count * 100.0 / Total.Total_Customers), 2) AS Percentage
	FROM
        NPS_Categories NPS
	CROSS JOIN 
        Total_Count Total
	WHERE
       NPS.NPS_Category IN ('Promoters', 'Passives', 'Detractors')
	ORDER BY
       NPS.NPS_Category;
       
-- Customer Performance Overview --
WITH CustomerPurchaseCounts AS (
    SELECT 
        sd.`Customer ID`,
        sd.`Customer Plan`,
        COUNT(sd.`Sales ID`) AS PurchaseCount
    FROM 
        sales_data sd
    GROUP BY 
        sd.`Customer ID`, 
        sd.`Customer Plan`
),
RepeatPurchaseRates AS (
    SELECT 
        `Customer Plan`,
        COUNT(*) AS TotalCustomers,
        SUM(CASE WHEN PurchaseCount > 1 THEN 1 ELSE 0 END) AS ReturningCustomers,
        ROUND(SUM(CASE WHEN PurchaseCount > 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) * 100, 2) AS RepeatPurchaseRate
    FROM 
        CustomerPurchaseCounts
    GROUP BY 
        `Customer Plan`
),
CustomerRatings AS (
    SELECT 
        sd.`Customer Plan`,
        COUNT(CASE WHEN sd.`Customer Rating` >= 9 THEN 1 END) AS Promoters,
        COUNT(CASE WHEN sd.`Customer Rating` <= 6 THEN 1 END) AS Detractors,
        COUNT(*) AS TotalRatings
    FROM 
        sales_data sd
    GROUP BY 
        sd.`Customer Plan`
)
SELECT 
    rpr.`Customer Plan` AS Customer_Plan,
    SUM(sd.`Sessions`) AS Sessions,
    ROUND(SUM(sd.`Sales Amount (USD)`) / NULLIF(SUM(sd.`Sessions`), 0), 2) AS Revenue_Per_Session,
    SUM(sd.`Sales Amount (USD)`) AS Total_Revenue,
    rpr.RepeatPurchaseRate AS Repeat_Purchase_Rate,
    ROUND((cr.Promoters - cr.Detractors) / NULLIF(cr.TotalRatings, 0) * 100, 2) AS NPS_Score
FROM 
    sales_data sd
JOIN 
    RepeatPurchaseRates rpr ON sd.`Customer Plan` = rpr.`Customer Plan`
JOIN 
    CustomerRatings cr ON sd.`Customer Plan` = cr.`Customer Plan`
GROUP BY 
    sd.`Customer Plan`, rpr.RepeatPurchaseRate, cr.Promoters, cr.Detractors, cr.TotalRatings
ORDER BY 
    Total_Revenue DESC;

-- Product Performance Analysis --
USE sales_marketing;
-- Average Revenue Per Product --
SELECT
      ROUND(
          SUM(`Sales Amount (USD)`) *1.0 / COUNT(DISTINCT `Product ID`), 2)
          AS Average_Revenue_Per_Product
FROM 
   sales_data;
   
-- Product Conversion Rate --
SELECT 
    ROUND(
        (SUM(CASE WHEN `Sales Amount (USD)` > 0 THEN 1 ELSE 0 END) *1.0 )/ NULLIF(SUM(Sessions), 0), 2)
        AS Product_Conversion_Rate
FROM
    sales_data;
    
-- Product Margin --
SELECT 
    ROUND(
       (SUM(`Sales Amount (USD)`) - SUM(`Cost Price (USD)`) )/ NULLIF(SUM(`Sales Amount (USD)`),0) * 100,2
       ) AS Product_Margin
FROM
    sales_data;
    
-- Sales Growth Rate --
WITH Total_Revenue_Per_Year AS (
    SELECT 
        YEAR(`Sales Date`) AS Year,
        SUM(`Sales Amount (USD)`) AS Total_Revenue
    FROM 
        sales_data
    WHERE 
        YEAR(`Sales Date`) BETWEEN 2022 AND 2024  
    GROUP BY 
        YEAR(`Sales Date`)
),
Overall_Cumulative AS (
    SELECT 
        SUM(Total_Revenue) AS Cumulative_Current_Sales, 
        SUM(CASE WHEN Year < 2024 THEN Total_Revenue ELSE 0 END) AS Cumulative_Previous_Sales -- Total from 2022 to 2023
    FROM 
        Total_Revenue_Per_Year
)
SELECT 
    ROUND(
        CASE 
            WHEN Cumulative_Previous_Sales > 0 
            THEN (Cumulative_Current_Sales - Cumulative_Previous_Sales) / Cumulative_Previous_Sales * 100 
            ELSE 0 
        END, 
    2) AS Sales_Growth_Rate
FROM 
    Overall_Cumulative;
    
-- Top 5 Products by Revenue --
WITH Product_Revenue AS (
    SELECT 
        dp.Product,
        SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
    FROM 
        sales_data sd
    JOIN 
        dimproduct dp ON sd.`Product ID` = dp.`Product ID`
    GROUP BY 
        dp.Product
),
Ranked_Products AS (
    SELECT 
        Product,
        Total_Revenue,
        RANK() OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
    FROM 
        Product_Revenue
)
SELECT 
    Product,
    Total_Revenue
FROM 
    Ranked_Products
WHERE 
    Revenue_Rank <= 5
ORDER BY 
    Total_Revenue DESC;

-- Top 5 Products by Monthly Revenue --
WITH Monthly_Product_Revenue AS (
    SELECT 
        YEAR(sd.`Sales Date`) AS Year,
        MONTH(sd.`Sales Date`) AS Month,
        dp.Product,
        SUM(sd.`Sales Amount (USD)`) AS Monthly_Revenue
    FROM 
        sales_data sd
    JOIN 
        dimproduct dp ON sd.`Product ID` = dp.`Product ID`
    GROUP BY 
        YEAR(sd.`Sales Date`), MONTH(sd.`Sales Date`), dp.Product
),
Ranked_Monthly_Products AS (
    SELECT 
        Year,
        Month,
        Product,
        Monthly_Revenue,
        RANK() OVER (PARTITION BY Year, Month ORDER BY Monthly_Revenue DESC) AS Revenue_Rank
    FROM 
        Monthly_Product_Revenue
)
SELECT 
    Year,
    Month,
    Product,
    Monthly_Revenue
FROM 
    Ranked_Monthly_Products
WHERE 
    Revenue_Rank <= 5
ORDER BY 
    Year, Month, Monthly_Revenue DESC;
    
-- Revenue and Conversion Rate by Product --
WITH Product_Performance AS (
    SELECT 
        dp.Product,
        SUM(sd.`Sales Amount (USD)`) AS Total_Revenue,
        SUM(sd.`Sessions`) AS Total_Sessions,
        COUNT(CASE WHEN sd.`Sales Amount (USD)` > 0 THEN 1 END) AS Total_Purchases
    FROM 
        sales_data sd
    JOIN 
        dimproduct dp ON sd.`Product ID` = dp.`Product ID`
    GROUP BY 
        dp.Product
),
Product_Conversion AS (
    SELECT 
        Product,
        Total_Revenue,
        ROUND(
            CASE 
                WHEN Total_Sessions > 0 THEN (CAST(Total_Purchases AS FLOAT) / Total_Sessions) * 100 
                ELSE 0 
            END, 2
        ) AS Product_Conversion_Rate
    FROM 
        Product_Performance
)
SELECT 
    Product,
    Total_Revenue,
    Product_Conversion_Rate
FROM 
    Product_Conversion
ORDER BY 
    Total_Revenue DESC;
    
-- Product Revenue Contribution --
SELECT 
    dp.Product,
    SUM(sd.`Sales Amount (USD)`) AS Total_Revenue
FROM 
    sales_data sd
JOIN 
    dimproduct dp ON sd.`Product ID` = dp.`Product ID`
GROUP BY 
    dp.Product
ORDER BY 
    Total_Revenue DESC;

-- Product Performance Analysis  Table --
SELECT 
    p.`Product` AS Product,
    COUNT(DISTINCT sd.`Customer ID`) AS Customers,
    COUNT(sd.`Sales ID`) AS Sales_Count,
    SUM(sd.`Sales Amount (USD)`) AS Total_Revenue,
    ROUND((SUM(CASE WHEN YEAR(sd.`Sales Date`) = 2024 THEN sd.`Sales Amount (USD)` ELSE 0 END) -
           SUM(CASE WHEN YEAR(sd.`Sales Date`) = 2023 THEN sd.`Sales Amount (USD)` ELSE 0 END)) /
           NULLIF(SUM(CASE WHEN YEAR(sd.`Sales Date`) = 2023 THEN sd.`Sales Amount (USD)` ELSE 0 END), 0) * 100, 2) AS Product_Growth_Rate,
    ROUND(AVG(sd.`Customer Rating`), 2) AS Customer_Rating
FROM 
    sales_data sd
JOIN 
    dimproduct p ON sd.`Product ID` = p.`Product ID`
GROUP BY 
    p.`Product`
ORDER BY 
    Total_Revenue DESC;
      
