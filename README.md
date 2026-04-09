# PlatinumRx Data Analyst Assignment

This repository contains my submission for the PlatinumRx Data Analyst assignment, covering Database Management (SQL), Data Manipulation (Spreadsheets), and Programming Logic (Python).

## 📁 Repository Structure

```text
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql    # Table creation and data insertion for Hotel
│   ├── 02_Hotel_Queries.sql         # Solutions for Part A (Questions 1-5)
│   ├── 03_Clinic_Schema_Setup.sql   # Table creation and data insertion for Clinic
│   └── 04_Clinic_Queries.sql        # Solutions for Part B (Questions 1-5)
│
├── Spreadsheets/
│   ├── Ticket_Analysis.xlsx         # The workbook containing data and analysis
│   └── generate_spreadsheet.py      # Python script used to automatically create the .xlsx file
│
├── Python/
│   ├── 01_Time_Converter.py         # Script for minutes conversion
│   └── 02_Remove_Duplicates.py      # Script for string manipulation
│
└── README.md                        # Notes on approaches and assumptions
```

## 📝 Phase 1: SQL Proficiency

All SQL queries operate on a standard compliant relational database schema. The setup scripts contain `CREATE TABLE` and sample `INSERT INTO` statements. The query scripts utilize modern functionalities like Common Table Expressions (CTEs), Aggregations, and Window Functions (`RANK()` and `DENSE_RANK()`).

**Key Assumptions:**
- I have leveraged standard SQL functions `EXTRACT(MONTH FROM ...)` and `EXTRACT(YEAR FROM ...)` which work directly in PostgreSQL and MySQL.
- I've assumed that where properties like "Same Day" queries require grouping, `datetime` boundaries encompass the full calendar day.

## 📊 Phase 2: Spreadsheet Proficiency

Located in `Spreadsheets/Ticket_Analysis.xlsx`.

**1. Populating `ticket_created_at`**
Since `cms_id` acts as the primary key located in column E of the `ticket` sheet, while `created_at` lies in column B, traditional `VLOOKUP` is ineffective (VLOOKUP searches from left-to-right). Thus, I've employed the `INDEX-MATCH` approach to dynamically pull the relevant timestamp backwards.
**Formula Snippet:**
```excel
=IFERROR(INDEX(ticket!B:B, MATCH(A2, ticket!E:E, 0)), "Not Found")
```

**2. Time Analysis (Same Day / Same Hour Counts)**
I designed logic checks as Helper Columns inside the `ticket` sheet, followed by `COUNTIFS` aggregations.
- **Same Day Check:** Compares the first 10 string characters (YYYY-MM-DD): `=LEFT(B2, 10) = LEFT(C2, 10)`
- **Same Hour Check:** Assesses if it's the Same Day AND compares the 12th & 13th hour characters: `=AND(F2, MID(B2, 12, 2)=MID(C2, 12, 2))`
- **Aggregate Counts:** Located in the distinct `Analysis` sheet using `=COUNTIFS(ticket!D:D, A2, ticket!F:F, TRUE)`.

## 💻 Phase 3: Python Proficiency

Two basic algorithmic scripts are supplied handling time evaluation and linear string duplication filtering utilizing native `//` modulo division and basic `for` loop string tracking.

## 🔗 Submission Links

- **GitHub Repository:** https://github.com/rameshmangali/PlatinumRx_Data_Analyst_Assignment
- **Spreadsheet:** Included inside `/Spreadsheets/` directory (`Ticket_Analysis.xlsx`). If utilizing Google Sheets, import this file directly.
- **Screen Recording:** `[INSERT DRIVE LINK HERE]`
