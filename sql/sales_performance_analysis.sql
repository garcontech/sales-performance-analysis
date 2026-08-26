SELECT COUNT(*) AS row_count
FROM sales;
SELECT *
FROM sales
LIMIT 10;
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE sales IS NULL) AS null_sales,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE profit IS NULL) AS null_profit
FROM sales;
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    MIN(ship_date) AS earliest_ship_date,
    MAX(ship_date) AS latest_ship_date
FROM sales;
SELECT
    COUNT(*) FILTER (WHERE sales <= 0) AS invalid_sales,
    COUNT(*) FILTER (WHERE quantity <= 0) AS invalid_quantity,
    COUNT(*) FILTER (WHERE discount < 0 OR discount > 1) AS invalid_discount
FROM sales;
SELECT COUNT(*) AS negative_profit_rows
FROM sales
WHERE profit < 0;

-- Overall business KPIs
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales;

-- Category performance
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY category
ORDER BY total_sales DESC;
-- Furniture sub-category performance
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
WHERE category = 'Furniture'
GROUP BY sub_category
ORDER BY total_profit ASC;

-- Tables and Bookcases profitability by year
SELECT
    EXTRACT(YEAR FROM order_date)::INTEGER AS year,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
WHERE sub_category IN ('Tables', 'Bookcases')
GROUP BY
    EXTRACT(YEAR FROM order_date),
    sub_category
ORDER BY
    year,
    sub_category;

	-- Discount and profitability analysis
SELECT
    discount,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY discount
ORDER BY discount;

-- Profitability by discount group
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 0.20 THEN 'Low Discount (<20%)'
        WHEN discount < 0.30 THEN 'Moderate Discount (20-29%)'
        ELSE 'High Discount (30%+)'
    END AS discount_group,
    COUNT(*) AS transaction_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM sales
GROUP BY
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 0.20 THEN 'Low Discount (<20%)'
        WHEN discount < 0.30 THEN 'Moderate Discount (20-29%)'
        ELSE 'High Discount (30%+)'
    END
ORDER BY profit_margin_pct DESC;

-- Rank sub-categories by profitability
WITH subcategory_performance AS (
    SELECT
        sub_category,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
    FROM sales
    GROUP BY sub_category
)
SELECT
    sub_category,
    total_sales,
    total_profit,
    profit_margin_pct,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM subcategory_performance
ORDER BY profit_rank;