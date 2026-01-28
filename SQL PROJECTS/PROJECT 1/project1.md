# Student Performance SQL Analysis

***A segmentation-first, SQL-driven exploration of a synthetic student dataset*** 

---

##  Table of Contents

* [Project Overview](#project-overview)
* [Dataset Description](#dataset-description)
* [Data Cleaning Process](#data-cleaning-process)
* [Basic Analysis](#basic-analysis)
* [Segmentation](#segmentation)
* [Distribution Analysis](#distribution-analysis)
* [Grade-Based Insights](#grade-based-insights)
* [Percentile-Based Patterns](#percentile-based-patterns)
* [Conclusion](#conclusion)

---

# ##  Project Overview

This project analyzes a student performance dataset using **MS SQL Server**, with the goal of understanding how various factors (study hours, attendance, internet access, study method, travel time, etc.) relate to academic performance.

Early into the analysis, it became clear that the dataset is **synthetic and extremely balanced**, meaning demographic variables do not impact performance as such. Instead of forcing correlations, I moved to a more honest and realistic analytical approach:

* segmentation
* distribution-based insights
* grade patterns
* percentile-based performance behavior

This reflects how real analysts work when the dataset doesn't naturally reveal dramatic differences.

---

# ##  Dataset Description

I worked with two CSV files:

* `student_perf_raw.csv` — original dataset
* `student_perf_cleaned.csv` — after applying data cleaning (travel time brackets, removing redundant columns)

### Columns included:

`student_id`, `age`, `gender`, `school_type`, `parent_education`, `study_hours`,
`attendance_percentage`, `internet_access`, `extra_activities`,
`study_method`, `math_score`, `science_score`, `english_score`,
`overall_score`, `final_grade`, `travel_time_bracket`

Dataset size: **25,000 rows**

---

# ##  Data Cleaning Process

<details>
<summary><strong>Click to expand data cleaning steps</strong></summary>

###  Imported flat file into MS SQL Server

MS SQL automatically converted Yes/No values to 1/0.
This was acceptable, so I kept it as-is.

### Travel Time Cleanup

The original `travel_time` column contained inconsistent text values like:

* `<15 mins`
* `15–30 mins`
* `30–60 mins`
* `>60 mins`

To group them uniformly, I replaced it with a cleaner bracket column.

#### 1. Add new column

```sql
ALTER TABLE student_perf
ADD travel_time_bracket VARCHAR(20);
```

#### 2. Populate bracket values

```sql
UPDATE student_perf
SET travel_time_bracket =
    CASE
        WHEN travel_time LIKE '<15%' THEN 'Very Low'
        WHEN travel_time LIKE '15-30%' THEN 'Low'
        WHEN travel_time LIKE '30-60%' THEN 'Medium'
        WHEN travel_time LIKE '>60%' THEN 'High'
    END;
```

#### 3. Drop redundant column

```sql
ALTER TABLE student_perf
DROP COLUMN travel_time;
```

### ✔ Final Check

```sql
SELECT * FROM student_perf;
```

</details>

---

# ##  Basic Analysis

<details>
<summary><strong>Q1. Average overall score by travel_time and school_type</strong></summary>

### SQL

```sql
SELECT travel_time_bracket, school_type,
       AVG(overall_score) AS avg_overall,
       COUNT(*) AS n_students
FROM student_perf
GROUP BY travel_time_bracket, school_type
ORDER BY travel_time_bracket, school_type;
```

### Key Output (simplified)

| travel_time_bracket | school_type | avg_overall | n_students |
| ------------------- | ----------- | ----------- | ---------- |
| High                | private     | 64.50       | 3100       |
| High                | public      | 63.65       | 3066       |
| Low                 | private     | 63.45       | 3258       |
| Very Low            | public      | 64.68       | 3007       |

### Insight

No major differences.
Travel time and school type barely influence performance, the dataset is clearly **balanced and synthetic**, not reflecting any real-world variation.

</details>

---

<details>
<summary><strong>Q2. Correlation between study hours and final grades</strong></summary>

```sql
SELECT final_grade,
       ROUND(AVG(study_hours),2) AS avg_hours,
       COUNT(*) AS n_students
FROM student_perf
GROUP BY final_grade
ORDER BY final_grade;
```

### Output

| final_grade | avg_hours |
| ----------- | --------- |
| a           | 7.41      |
| b           | 6.92      |
| c           | 5.83      |
| d           | 4.06      |
| e           | 2.32      |
| f           | 1.32      |

### Insight

Study hours correlate *directly* with final grade.
Attendance shows a similar upward trend.
Demographic factors do **not** show any such trend.

</details>

---

# ## Segmentation

### Grade Segmentation

```sql
SELECT
  final_grade,
  COUNT(*) AS n_students,
  ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM student_perf), 2) AS percent_total
FROM student_perf
GROUP BY final_grade
ORDER BY percent_total DESC;
```

### Output

| grade | students | percent_total |
| ----- | -------- | ------------- |
| d     | 6311     | 25.24%        |
| c     | 6161     | 24.64%        |
| e     | 5672     | 22.69%        |
| f     | 2955     | 11.82%        |
| b     | 2696     | 10.78%        |
| a     | 1205     | 4.82%         |

### Insight

Grades are uniformly distributed without any sharp skews.
This confirms the dataset's synthetic nature and sets a foundation for further segmentation.

---

# ## Distribution Analysis

```sql
SELECT
  CASE
    WHEN overall_score < 40 THEN '0-40'
    WHEN overall_score < 60 THEN '40-60'
    WHEN overall_score < 80 THEN '60-80'
    ELSE '80-100'
  END AS score_range,
  COUNT(*) AS n_students
FROM student_perf
GROUP BY
  CASE
    WHEN overall_score < 40 THEN '0-40'
    WHEN overall_score < 60 THEN '40-60'
    WHEN overall_score < 80 THEN '60-80'
    ELSE '80-100'
  END
ORDER BY score_range;
```

### Output

| score_range | n_students |
| ----------- | ---------- |
| 0–40        | 2941       |
| 40–60       | 7777       |
| 60–80       | 8384       |
| 80–100      | 5898       |

### Insight

Uniform score distribution with no heavy skew confirms dataset is designed to be balanced.

---

# ## Grade-Based Insights

```sql
SELECT
  final_grade,
  ROUND(AVG(math_score),2) AS avg_math,
  ROUND(AVG(science_score),2) AS avg_science,
  ROUND(AVG(english_score),2) AS avg_english,
  ROUND(AVG(overall_score),2) AS avg_overall
FROM student_perf
GROUP BY final_grade
ORDER BY avg_overall DESC;
```

### Output (Simplified)

| Grade | Math  | Science | English | Overall |
| ----- | ----- | ------- | ------- | ------- |
| a     | 95.19 | 95.04   | 95.21   | 98.37   |
| b     | 88.64 | 89.06   | 87.85   | 89.36   |
| c     | 77.15 | 77.20   | 77.32   | 77.33   |

### Insight

Subjects align perfectly with final grade and this again shows **grades are the strongest segmentation factor**, not demographics.

---

# ## Percentile-Based Patterns

<details>
<summary><strong>Click to expand NTILE(10) analysis</strong></summary>

```sql
WITH ranked AS (
  SELECT *,
         NTILE(10) OVER (ORDER BY overall_score DESC) AS score_decile
  FROM student_perf
)
SELECT
  score_decile,
  ROUND(AVG(study_hours),2) AS avg_study_hours,
  ROUND(AVG(attendance_percentage),2) AS avg_attendance,
  ROUND(AVG(overall_score),2) AS avg_score
FROM ranked
GROUP BY score_decile
ORDER BY score_decile;
```

### Pattern Observed

* Top deciles study more
* Attend classes more
* Score predictably higher
* Smooth downward trend across lower deciles

Even though differences are modest, percentile segmentation reveals clearer trends than demographic analysis.

</details>

---

# ##  Conclusion

This project proved something important:
**Not every dataset offers dramatic insights. And that’s fine.**

Although it is first project, I thought that I had found an amazing dataset and would be able to perform various opertaions and apply some concepts of statistics, but I wasn't able to due to the nature of dataset
The student dataset turned out to be:

* highly synthetic
* evenly distributed
* weak in demographic variation
* predictable across categories

So instead of chasing correlations that weren’t there, the analysis focused on what the dataset *can* genuinely reveal:

* meaningful segmentation
* clean grade patterns
* distribution-based insights
* percentile-based behavior
* high vs low performer traits

That was all for this project, instead of beating myself up for not able to form relationships between variables, I approached this project with a segmentative approach. I learnt an important lesson today in the field of data. 
