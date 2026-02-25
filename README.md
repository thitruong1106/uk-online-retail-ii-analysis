# UK Online Retail Revenue & Seasonality Analysis (2009-2011) 

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Project Type](https://img.shields.io/badge/Analysis-Retail_Data-green)

--- 

## Executive Summary 

This project analysis transaction data from a UK-based online retailer (2009-2011) to understand 
- Revenue growth drivers
- Customer progression
- Seasonal performance risk
- Product mix shifts across quarters

I conducted the analysis using **MySQL**, using structured queries to ensure reproducibility. 

--- 

## Objective 

The purpose of this analysis was to understand revenue growth, customer evolution, and product seasonality patterns using transaction data from 2009 to 2011. 

The goal was to identify what drives revenue growth and if the business shows structural seasonality risk. 

--- 

## Cleaning The Data 

To ensure that the analysis reflected actual customer purchases only, i removed: 
- Cancelled invoices (invoice starting with a "C")
- Accounting adjustment and manual entry
- Fees such as Amazon fee and postage 
- Negative quantity and prices
 
Revenue is defined as: 
	Revenue = Quantity * Unit Price 

This is to ensure that all revenue represented real product sales. 

--- 

## Key Findings 

### 1. Revenue Growth is driven by volume, Not Higher Spending 

From Q1 2010 to Q4 2010, quarterly revenue has nearly doubled. But if you look at the average customer spent each time, it stayed flat at around 18-20pound. 

This reflects growth was driven by increased transaction volume rather than customers spending more per purchase. 

---

### 2. Strong Q4 Seasonality 

Across both years, Q4 consistently generated the highest revenue and transaction count. 

While the seasonal trend is clear, comparison to q4 2011 should be interpreted cautiously because data was only available up to December 9th. 

The business show strong seasonal dependence on Q4 performance. 

---

### 3. Customer Base Evolution 

The customer mix shifted significantly over time: 
- 2009 Launch: All customer were new customers.  
- 2010 Growth: The percentage of new customers decrease while returning customers increased steadily each quarter. 
- 2011 Maturity: By Q4 2011, About 83% of customer were returning customers. 

This suggests the company successfully transitioned from customer acquisition to customer retention. Even though the average amount people spent per transaction didn't increase, the revenue stayed steady. This confirms that growth came from returning customer, not just getting them to spend more each time. 

---

### 4. Product mix shifts completely in Q4 

The products people buy in Q4 are completely different from the rest of the year (Q1-Q3). 

There are 16 products that generates over 78% of their annual revenue in just three months(Q4). These include 
* Christmas decoration 
* Winter seasonal goods 
* Gift items 

In other words, Q4 is consider the "holiday driven" quarter. 

---

### 5.The risk: Seasonal products push out regular sellers 

During Q4 period, shelf space and demand shifts heavily towards holiday related items. 

For example, The picnic Basket Wicker (60 pieces), Party Bunting, or Medium Ceramic Storage Jar. These items sell steadily all year, but they don't appear int he top rankings product in Q4 periods. 

That create a risk, because if the Christmas category products underperforms, the company wont have their usual reliable products to fall back on. 

---

### 6.The backbone of products. 

Four products stayed in the top 20 product ranking during both Q4 Period and the rest of the year. 

These are the true sellers, because they don't under perform during either period, they just perform. These products are the type of products that holds the business together. 

---

## Business implications 

What does this mean for the business ? 

1. Loyalty 
Revenue is growing because more customers are coming back more often, not because the business is charging more. That's a healthy sign for the business, as it means the growth is sustainable and customer-driven. 

2. Q4 Dependency
Q4 isn't just a busy period. The business leans heavily on holidays sales, and product mix shifts during those months. Its not a problem, but its something that needs planning around off. 

3. The trade-off: seasonal products crowd out regular products 
During Q4, holiday items dominates which pushes out the regular best seller. This strategy works because when sesaonal demand is strong, but creates risks if holiday sales decilne. 

4. Opportunity 
Only four products perform consistently all year round. That's a small backbone. By finding more products that sell consistently, or giving more attention to the ones in stock, could reduce seasonal risk significantly. 

Conclusion 
The business successfully matured from an acquisition-focused startup into a retention driven business. 

Revenue growth has been stable due to the increased customer loyalty and transaction volume. 

However, the company is structurally dependent on Q4 seasonal performance. Strangthening year round products performance could reduce seasonal risk and support more consistent long term growth. 
