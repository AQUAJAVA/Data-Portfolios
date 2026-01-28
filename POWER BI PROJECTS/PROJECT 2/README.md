# Bank Customer Churn Analysis (Power BI)

## Project Context

This project is based on a publicly available bank customer churn dataset containing 10,000 customer records.  
I initially referred to a Power BI tutorial that covered **basic dashboard creation and visualization mechanics**.

However, the tutorial largely focused on *how to build charts*, not on **why churn happens** or **what business actions should follow**.

I wanted to take this project **beyond a tutorial-level dashboard** and turn it into a **business-oriented churn analysis**, similar to how a data analyst or consultant would approach a real-world problem.

This README explains **my approach, my analysis, and the reasoning behind key insights**.

---

## Reference Tutorial (Baseline)

The following tutorial was used **only as a starting point** to understand the dataset and basic Power BI workflow:

🔗 Tutorial Video:  
https://youtu.be/HHu0FLM6Fp0?si=qOdECYTN-g1U67jE

The tutorial covers:
- Data import and cleaning
- Creating basic churn KPIs
- Building standard visuals (donuts, bar charts, gauge)

While useful, it stops at **visualization**, not **interpretation**.

These were the visualizations created in the video:-

<img width="1383" height="795" alt="image" src="https://github.com/user-attachments/assets/38592a0d-d7c1-493a-b431-1a2954df0662" />

---

## My Objective: From Dashboard to Decision-Making

Most churn projects answer:
> “What does the dashboard show?”

This project aims to answer:
- **Who is churning?**
- **Why are they churning?**
- **Which churn hurts the business the most?**
- **Where should the bank act first?**

I intentionally shifted focus from:
- Tool usage → **Business reasoning**
- Charts → **Insights**
- KPIs → **Actions**

### **I used the tutorial only as a starting point and intentionally shifted the focus from visualization to business reasoning**

---

## Dataset Overview

- Total customers: **10,000**
- Key features:
  - Credit Score
  - Country
  - Gender
  - Age
  - Tenure
  - Account Balance
  - Number of Products
  - Credit Card Status
  - Active Member Status
  - Churn (1 = Churned, 0 = Retained)

---

## Data Preparation & Modeling Approach

Beyond basic cleaning, I made specific design decisions to enable **better analysis**:

### 1. Meaningful Grouping
- Created **Age Groups**, **Credit Score Groups**, and **Account Balance Groups**
- These groupings help analyze churn behavior across customer segments rather than raw numbers

### 2. Correct Sorting Logic
- Built **reference tables** with custom IDs to ensure logical sorting  
  (e.g., 21–30 before 31–40, ₹10k before ₹100k)

### 3. DAX Measures
Core measures created:
- Total Customers
- Churned Customers
- Churn Rate (%)
- Segment-level averages (Credit Score, Balance)

All insights are driven by **measures**, not static columns.

For reference here are some extra visualizations I had made

<img width="1376" height="761" alt="image" src="https://github.com/user-attachments/assets/ff129195-267a-4d22-9225-34c2b23edf90" />

---

## Key Analytical Insights

### 1. Credit Score Is Not the Primary Churn Driver
- Average credit score of churned and retained customers is very similar
- Indicates churn is driven more by **experience and engagement** than creditworthiness

---

### 2. High-Balance Customers Are Churning More
- Churned customers have **higher average balances** than retained ones
- This is counterintuitive and critical:
  - High-value customers are leaving
  - Financial loss per churn is high

**Implication:** Retention should prioritize *value*, not volume.

---

### 3. Product-Level Failure (Products 3 & 4)
- Products 3 and 4 show extremely high churn rates
- Likely causes:
  - Poor value proposition
  - Complexity or poor communication
  - Weak onboarding

**Recommended action:** Immediate product audit and bundling strategy.

---

### 4. Geographic Risk: Germany
- Germany has:
  - Fewer customers
  - **Highest churn rate**
  - **Highest average balances (churned & retained)**

This makes Germany a **high-value, high-risk market**.

**Implication:** Country-specific retention strategies are required.

---

### 5. Demographic & Behavioral Patterns
- Highest churn observed in:
  - Age group 51–60
  - Very low credit score segments
  - Zero / low balance customers

Each segment requires a **different retention approach**, not a one-size-fits-all solution.

---

## Strategic Recommendations

Based on the analysis:

- Redesign or reposition failing products
- Create early warning systems for high-balance customers
- Improve UI/UX and support for older customers
- Use low-cost engagement strategies for low-balance, high-churn segments
- Localize strategy for high-risk regions like Germany

---

## Video Explanation (My Analysis)

I recorded a detailed video explaining **how to think through this analysis**, not how to build the dashboard.

If the written explanation is unclear, refer to this video:

🎥 My Analysis Video:  
https://youtu.be/t98MHamAUhI?si=-ajgURqNz_o3IrQA

The video focuses on:
- Interpreting churn patterns
- Connecting data to business reasoning
- Translating insights into actions

---

## Final Notes

This project is intentionally **not a step-by-step Power BI tutorial**.

It is meant to demonstrate:
- Analytical thinking
- Business interpretation
- Decision-oriented data analysis

Power BI is the tool — **thinking is the skill**.

---

## Files

- (.pbix) files uploaded, check in the folder
- To make this report yourself, find the dataset from the video tutorial link provided in the beginning

## Special Note
This analysis was done completely with the intention of learning to think like an analyst, I have come to realise that practicing SQL is not the only thing, You need to develop that Business Acumen to get better at your work
