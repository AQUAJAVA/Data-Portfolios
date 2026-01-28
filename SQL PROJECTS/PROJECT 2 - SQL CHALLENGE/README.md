# SQL & Data Analytics Practice Project  
**Real Datasets · Pandas Cleaning · SQL Problem Solving**

## About This Repository

This repository documents a **skill-practice project** I did while learning and strengthening my foundations in **data analytics and SQL**.

I was specifically looking for:
- Realistic datasets (not toy examples)
- Meaningful SQL questions (not LeetCode-style puzzles)
- A way to practice **data cleaning + SQL thinking together**

Instead of waiting to find the “perfect” resource, I picked a solid public dataset challenge, made a few adjustments to suit my learning goals, and decided to **work through it systematically** while documenting my learning via code and videos.

This repo is a **learning log**, not a production-grade or end-to-end analytics project.

---

## Why I Did This

While learning SQL and analytics:
- I didn’t want to practice only syntax
- I didn’t want to blindly follow tutorials
- I didn’t want artificially clean datasets

So I:
- Found a public repository with structured datasets and SQL questions
- Cleaned the data myself using Python (Pandas)
- Connected Python to SQL Server to understand real workflows
- Solved SQL questions with increasing complexity
- Recorded explanations to reinforce my understanding

The goal was simple: **get better by doing real work**.

# P.S. :- 
### I MADE A [YOUTUBE CHANNEL](https://www.youtube.com/@ayushqueries) SHOWING MY PROGRESS AND PROJECTS THAT I DO, PLEASE DO VISIT AND CHECK OUT - YOU MAY FIND SOMETHING VALUABLE

---

## Dataset Source

The datasets and SQL questions are adapted from a public GitHub repository:

- Original challenge repository:  
  [SQL CHALLENGE LINK](https://github.com/iweld/SQL_Coding_Challenge)

Datasets include:
- Countries
- Cities
- Languages
- Currencies

They contain real-world issues like:
- Inconsistent casing
- Special characters
- Missing values
- Many-to-many relationships

---


## Project Breakdown (By Parts)

### Part 1: Data Cleaning using Python Pandas

- Reading multiple CSV files
- Cleaning country codes, regions, and sub-regions
- Handling casing inconsistencies and special characters
- Using regex-based replacements
- Filling missing values thoughtfully
- Preparing datasets for reliable SQL joins

Video link:  
[PART - 1](https://youtu.be/FBDFpEfqzRY?si=lUP9IyUBrg9aiCMS)

---

### Part 2: Connecting Python with Microsoft SQL Server

- Understanding how Python connects to SQL Server
- Role of SQLAlchemy, DBAPI, and ODBC drivers
- Writing and understanding connection strings
- Running SQL queries from Python
- Loading SQL data into Pandas
- Writing data back from Pandas to SQL tables
- Debugging common connection and driver errors

Video link:  
[PART - 2](https://youtu.be/GhqYCGzQFvM?si=newbiIzbJL8xTa_j)


---

### Part 3: SQL Practice – Questions 1 to 5

- Writing SQL on cleaned datasets
- Using joins, filtering, grouping, and ordering
- Translating analytical questions into SQL logic
- Understanding how data cleaning affects query accuracy
- Avoiding common beginner mistakes

Video link:  
[PART - 3](https://youtu.be/9uQFb0Nq5do?si=ChFtKF8N9AGQ8TLX)

---

### Part 4: SQL Practice – Questions 6 to 10 

- String-based logic (palindromes, pattern matching)
- Numeric formatting and aggregation
- Case-insensitive filtering
- Using CTEs to structure complex queries
- Window functions for ranking and segmentation
- Handling many-to-many relationships
- Aggregating multiple values using `STRING_AGG`

Video link:  
[PART - 4](https://youtu.be/uaycabT4ggk?si=2FDKMGmyd1WuPWCp)

---

## Tools Used

- Python
  - Pandas
  - SQLAlchemy
  - pyodbc
- Microsoft SQL Server
- Jupyter Notebook
- GitHub

---

## What This Project Is (and Is Not)

**This project IS:**
- A hands-on learning exercise
- Practice for SQL and analytics thinking
- A realistic way to work with messy data
- A record of skill development

**This project is NOT:**
- A production system
- A business case study
- An end-to-end analytics pipeline
- A polished portfolio project (yet)

---

## How to Use This Repo

- Explore the cleaned datasets
- Try solving the SQL questions yourself
- Modify queries and experiment
- Use the datasets for your own practice

---

## Closing Note

This repository exists to document **learning through doing**.

If you’re also learning SQL or data analytics and feel stuck between tutorials and real work, this kind of structured practice can help bridge that gap.

## Project Structure

