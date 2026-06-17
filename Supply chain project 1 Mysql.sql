SELECT *
FROM kaggle_supply_chain_data_project_v2;


-- Find the product that generates the most profit based on the difference between total revenue, manufacturing costs and shipping costs.
SELECT `Product type`, 
ROUND(SUM(`Revenue generated`), 3) AS revenue,
ROUND(SUM(`Manufacturing costs`), 3) AS manufacturing_cost,ROUND(SUM(`Shipping costs`), 3) AS shipping_cost,
ROUND(SUM(`Revenue generated`) - SUM(`Manufacturing costs`) - SUM(`Shipping costs`), 3) AS estimated_profit
FROM kaggle_supply_chain_data_project_v2
GROUP BY `Product type`
ORDER BY revenue DESC;


-- Average defect rate across all product types
SELECT `Product type`, ROUND(AVG(`Defect rates`), 3) AS Defect_Rate
FROM kaggle_supply_chain_data_project_v2
GROUP BY `Product type`
ORDER BY Defect_Rate DESC;


-- How defect rates affect revenue across all product types
SELECT `Product type`,
ROUND(SUM(`Revenue generated`), 3) AS Revenue,
ROUND(AVG(`Defect rates`), 3) AS Defect_Rate,
ROUND(SUM(`Revenue generated`) * (AVG(`Defect rates`) / 100),3) AS Revenue_risked,
ROUND(SUM(`Revenue generated`) - (SUM(`Revenue generated`) * (AVG(`Defect rates`) / 100)), 3) AS Revenue_after_defect
FROM kaggle_supply_chain_data_project_v2
GROUP BY `Product type`
ORDER BY Defect_Rate DESC;


-- How defects impact profitability across product types
SELECT `Product type`,
ROUND(SUM(`Revenue generated`), 3) AS Revenue,
ROUND(SUM(`Revenue generated`) - SUM(`Manufacturing costs`) - SUM(`Shipping costs`), 3) AS Estimated_profit,
ROUND(AVG(`Defect rates`), 3) AS Defect_rate,
ROUND((SUM(`Revenue generated`) - SUM(`Manufacturing costs`) - SUM(`Shipping costs`)) * (AVG(`Defect rates`) / 100), 3) AS Profit_exposure,
ROUND((SUM(`Revenue generated`) - SUM(`Manufacturing costs`) - SUM(`Shipping costs`)) - ((SUM(`Revenue generated`) - SUM(`Manufacturing costs`) - SUM(`Shipping costs`)) * (AVG(`Defect rates`) / 100)), 3) AS Quality_adjusted_profit
FROM kaggle_supply_chain_data_project_v2
GROUP BY `Product type`
ORDER BY Quality_adjusted_profit DESC;