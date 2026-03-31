Marketing Funnel and Campaign Performance Analysis (SQL)
Overview

This project analyzes marketing funnel performance and campaign effectiveness using SQL across multiple datasets, including customer data, event-level behavioral data, transactions, and campaign metadata.

The goal was to evaluate how users move through the funnel (view → click → add-to-cart → purchase) and identify which traffic sources and campaign strategies drive the highest conversion and revenue.

Objectives

Measure funnel conversion rates across key stages
Compare performance across traffic sources
Evaluate campaign effectiveness by channel and objective
Identify drop-off points and optimization opportunities

Dataset

Data sourced from Kaggle:
Marketing & E-Commerce Analytics Dataset

Tables used:
- events
- transactions
- campaign
- customers
- products

The analysis uses multiple relational tables:

events: user behavior (views, clicks, add-to-cart, purchases)
transactions: purchase and revenue data
campaign: campaign metadata (channel, objective)
customers: demographic and acquisition data
products: product details

Key Analyses
1. Funnel Performance

Calculated conversion rates across:

View → Click
Click → Add-to-Cart
Add-to-Cart → Purchase

2. Traffic Source Analysis

Compared funnel performance across:

Email
Paid Search
Social
Organic
Direct

3. Campaign Performance

Evaluated campaigns by:

Revenue
Transactions
Purchasing customers
Average order value
Refund rate

Key Findings

Email was the most efficient channel, with the highest purchase conversion rate (~19%). Organic drove the most traffic but had weak lower-funnel conversion (5% purchase rate). Paid Search (Cross-sell) was the top revenue driver (~$858K). Affiliate campaigns delivered high-quality conversions, with relatively low refund rates. The largest drop-off occurs at the add-to-cart → purchase stage

Tools Used
SQL (SQLite)
DBeaver

Project Structure
schema.sql: table exploration and structure queries
analysis.sql: core analysis queries
insights.md: business insights and conclusions

Conclusion

This project demonstrates how SQL can be used to analyze marketing performance across both user behavior and revenue outcomes. By combining funnel metrics with campaign-level performance, the analysis identifies both efficiency and scale drivers, as well as key opportunities for optimization.
