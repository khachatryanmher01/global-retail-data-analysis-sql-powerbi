# 📊 Global Electronics Retail Data Analysis (SQL + Power BI)

## 📖 Project Overview
This project demonstrates an end-to-end data analysis workflow, starting from a messy retail dataset and transforming it into a clean, structured format using SQL, followed by building an interactive executive dashboard in Power BI.

The goal is to simulate a real-world business scenario where raw transactional data must be cleaned and converted into actionable insights for decision-making.

---

## 🎯 Objectives
- Clean and standardize messy transactional data
- Handle inconsistencies in categorical and numerical fields
- Perform exploratory data analysis (EDA)
- Build a professional Power BI dashboard for business insights

---

## 🛠 Tools & Technologies
- **SQL** – Data cleaning and transformation  
- **Power BI** – Data visualization and dashboard creation  
- **CSV / Excel** – Data storage and handling  

---

## 📂 Dataset Description
The dataset contains retail transaction data with the following fields:

- Transaction_ID  
- Date  
- Customer_Name  
- Product_Category  
- Unit_Price  
- Quantity  
- Country  
- Customer_Age  
- Rating  

The raw dataset contained multiple inconsistencies such as:
- Mixed case values (e.g., `usa`, `USA`, `Armenia`)
- Inconsistent category naming (`ELECTRONICS`, `elec.`, etc.)
- Missing values
- Formatting issues

---

## 🧹 Data Cleaning Process (SQL)

The dataset was cleaned using SQL with the following steps:

- Removed duplicate records  
- Standardized **Product_Category** values:
  - `ELECTRONICS`, `elec.` → `Electronics`
  - Unified naming across all categories  
- Standardized **Country** values:
  - `usa`, `USA` → `USA`
  - `ARMENIA`, `Armenia` → `Armenia`  
- Handled missing/null values in key columns  
- Converted data types:
  - Date column formatted correctly  
  - Numeric fields validated  
- Verified data consistency and integrity  

📌 All SQL queries are available in:

sql/data_cleaning.sql


---

## 📊 Dashboard Overview (Power BI)

An interactive dashboard was built to visualize key business metrics and trends.

### Key KPIs:
- 💰 **Total Revenue:** $1.86M  
- 📦 **Order Volume:** 807  
- ⭐ **Average Rating:** 3.03  

---

## 📈 Key Insights

- **USA** generates the highest revenue among all regions  
- **Electronics** is the top-performing category  
- **Gen X customers** contribute the largest share of revenue  
- Sales show fluctuations across months, with noticeable peaks and dips  
- Certain regions have high order volume but lower revenue (pricing differences)  

---

## 🖼 Dashboard Preview

images/dashboard.png

---

## 📁 Project Structure


global-electronics-retail-analysis/
│
├── data/
│ ├── raw/ # Original messy dataset
│ └── cleaned/ # Cleaned dataset after SQL processing
│
├── sql/
│ └── data_cleaning.sql # SQL scripts used for cleaning
│
├── images/
│ └── dashboard.png # Dashboard preview image
│
├── powerbi/
│ └── dashboard.pbix # Power BI dashboard file
└── README.md


---

## 🚀 How to Use This Project

1. Review the raw dataset in `/data/raw_sales_data/`  
2. Explore the SQL cleaning process in `/sql/`  
3. Load the cleaned dataset from `/data/cleaned_sales_data/`  
4. Open the Power BI file (`.pbix`) to interact with the dashboard  

---

## 💼 Business Value

This project reflects real-world data analytics tasks, including:

- Cleaning messy datasets  
- Standardizing inconsistent data  
- Creating executive dashboards  
- Extracting actionable business insights  

It demonstrates the ability to turn raw data into meaningful visual reports that support business decision-making.

---

## 🧑‍💻 About Me

I specialize in:
- Data cleaning using SQL  
- Data analysis and transformation  
- Dashboard development in Power BI  

I can help businesses:
- Clean and organize their data  
- Build dashboards and reports  
- Generate insights for better decisions  

---

## 🔗 Let's Connect

- GitHub: https://github.com/yourusername  
- Fiverr: (Add your Fiverr link here)  

---

## ⭐ If you found this project useful, feel free to star the repository!