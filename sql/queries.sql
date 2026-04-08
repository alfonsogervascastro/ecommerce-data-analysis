-- Conversion Rate
SELECT 
  COUNT(*) as total_orders,
  SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) as delivered_orders,
  ROUND(SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) as conversion_rate_percentage
FROM st-project-portfolio.eCommerce_analysis.orders

-- Average Delivery Time
SELECT 
  ROUND(AVG(DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY)), 2) as avg_delivery_days
FROM st-project-portfolio.eCommerce_analysis.orders op
WHERE order_status = 'delivered'

-- Revenue by Payment Type
SELECT 
  op.payment_type,
  ROUND(SUM(op.payment_value), 2) as total_revenue,
  ROUND(AVG(op.payment_value), 2) as avg_order_value
FROM st-project-portfolio.eCommerce_analysis.order_payments op
GROUP BY op.payment_type
ORDER BY total_revenue DESC

-- Order Value Segment
SELECT 
  CASE 
    WHEN payment_value < 50 THEN 'Low'
    WHEN payment_value BETWEEN 50 AND 150 THEN 'Medium'
    ELSE 'High'
  END as order_value_segment,
  COUNT(*) as total_orders,
  ROUND(AVG(payment_value), 2) as avg_value
FROM st-project-portfolio.eCommerce_analysis.order_payments op
GROUP BY order_value_segment
ORDER BY avg_value DESC
