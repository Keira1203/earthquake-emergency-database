# Earthquake Emergency Database

## Project Overview

This project develops a relational database system designed to optimize emergency response and resource allocation after major earthquakes. By integrating isolated data from affected individuals, medical facilities, and supply distributors, the system enables relief organizations to quickly assess public safety, manage hospital bed capacity, and prioritize critical supply distribution.

---

## Project Timeline & Deliverables

### Week 1: Societal Problem Definition 
In major earthquake events, emergency logistics and medical dispatch are severely delayed due to fragmented data silos across organizations. This database addresses this critical challenge by unifying shelter, medical, and logistics management into a single relational structure.
- **Document**: `./docs/Societal_problem_definition.pdf`

### Week 2: Data Modeling (ERD) 
The conceptual and logical schema for our database design is documented in the `images/` and `docs/` directories:
- **ERD Diagram**: 
  ![ERD](./images/erd.png)
- **Data Modeling Report**: `./docs/Data_modeling.pdf`

### Week 3: Schema Design & Database Connection in Code 
The database structure, table definitions, primary/foreign key constraints, and sample analytical queries are located in the `sql/` directory:
- **Schema Definition**: `./sql/schema.sql`
- **Initial Data**: `./sql/data.sql`
- **Sample Queries**: `./sql/queries.sql`

### Week 4: Video presentation of product to customers
We presented our database capabilities and stakeholder value proposition in our video demonstration:
- **Video Link**: [Watch the Presentation Video](./videos/presentation_video.mp4)

### Week 5: Integration of real data
To test how our database design holds up against real-world data, we integrated two complementary, open-licensed datasets (each containing over 50 unique rows).

#### 1. Datasets Used
* **Dataset 1: OpenFEMA Registration Intake and Individuals Household Program (RI-IHP) - v2**
  - **Source**: Federal Emergency Management Agency (FEMA) / U.S. Government
  - **URL**: [OpenFEMA Dataset Page](https://www.fema.gov/openfema-data-page/registration-intake-and-individuals-household-program-ri-ihp-v2)
  - **File Path**: `./data/RegistrationIntakeIndividualsHouseholdPrograms.csv`
  - **License**: U.S. Government Work / Open Data (Public Domain)
  - **Description**: Real-world data on disaster assistance registrations, locations (city, county, zip code), and financial support allocations used to validate `Person` and `Supplies` / `Supply_Order` records.

* **Dataset 2: CMS Hospital General Information**
  - **Source**: Centers for Medicare & Medicaid Services (CMS) / U.S. Department of Health & Human Services
  - **URL**: [Data.gov Hospital Dataset](https://data.cms.gov/provider-data/dataset/xubh-q36u)
  - **File Path**: `./data/Hospital_General_Information.csv`
  - **License**: Public Domain (U.S. Government Work)
  - **Description**: Comprehensive data on registered hospital facilities, locations, phone numbers, and emergency services used to validate the `Hospital` entity.

#### 2. Data Cleaning & Transformation
During the integration process, several data cleaning steps were conducted and documented:
- **Missing Data**: Converted empty strings and placeholder values (e.g., `N/A`, `Unknown`) into SQL `NULL` values.
- **Date Formatting**: Standardized irregular date string formats into standard ISO `YYYY-MM-DD` format.
- **Duplicates**: Removed duplicate facility and intake records based on unique identifiers (`id` and hospital registration numbers).
- **Naming Conventions**: Mapped external column names to match our SQL schema attributes (e.g., mapping `Facility Name` to `hospital_name`).

#### 3. Normalization & Schema Verification
- **3NF Verification**: After populating the database with real-world data, the schema was re-evaluated and confirmed to remain normalized up to **Third Normal Form (3NF)**.
- **Query Re-execution**: All analytical example queries from Week 3 (such as calculating available hospital capacity and identifying stock shortages) were re-run against the real-world data and yielded accurate, meaningful results without constraint violations.

---

## Repository Structure

```text
.
├── README.md                                           # Project overview and full course deliverables
├── data/                                               # Real-world datasets (Week 5)
│   ├── Hospital_General_Information.csv               # CMS hospital dataset
│   └── RegistrationIntakeIndividualsHouseholdPrograms.csv # OpenFEMA assistance dataset
├── sql/                                                # Database SQL scripts (Week 3)
│   ├── schema.sql                                      # Schema definitions and constraints
│   ├── data.sql                                        # Initial data insertion
│   └── queries.sql                                     # Analytical and operational queries
├── images/                                             # Project diagrams (Week 2)
│   └── erd.png                                         # Entity Relationship Diagram
├── docs/                                               # Project documentation
│   ├── Societal_problem_definition.pdf                # Week 1 deliverable
│   └── Data_modeling.pdf                               # Week 2 deliverable
└── videos/                                             # Stakeholder video (Week 4)
    └── presentation_video.mp4                          # Video demonstration

## Team

- Alisa Januška
- Iyem Pelzer
- Keira Nishigori
- Nicole Mihailov


## HOW TO USE THE CODEBASE

### 1. Open MySQL

#### Windows

Open PowerShell and navigate to the MySQL `bin` folder:

```powershell
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
```

Then log in:

```powershell
.\mysql -u root -p
```

#### macOS

Open Terminal and log in to MySQL:

```bash
mysql -u root -p
```

If the `mysql` command is not found, use the path to your MySQL installation or add MySQL to your PATH.

After successful login, you should see:

```text
mysql>
```

### 2. Create the database

**Run this only once.** You do not need to repeat it every time you use the codebase.

```sql
CREATE DATABASE disaster_management;
```

### 3. Select the database

```sql
USE disaster_management;
```

### 4. Create the database schema

Run the `schema.sql` file:

```sql
SOURCE <path-to-schema.sql>;
```

For example:

```sql
SOURCE C:/Users/Alisa/Desktop/disaster_management/schema.sql;
```

On macOS, use the path to the file on your Mac, for example:

```sql
SOURCE /Users/yourname/Desktop/disaster_management/schema.sql;
```
### 5. Import the base datasets

Run the `import.sql` file to load the CSV data into the `Hospital` and `Person` tables:

```
SOURCE sql/import.sql;
```

### Verify Data Import  
You can verify that the data was imported successfully by running:

```
SELECT COUNT(*) FROM Hospital; -- Expected: ~5,411 rows
SELECT COUNT(*) FROM Person;   -- Expected: ~225,352 rows

```


### Important

* Steps **1** are done in **PowerShell/Terminal**.
* Steps **2–4** are done inside **MySQL**, after you see `mysql>`.
* `CREATE DATABASE disaster_management;` only needs to be run **once**.
* If the database already exists, do **not** run `CREATE DATABASE` again. Start with:

```sql
USE disaster_management;
```
* Make sure you launch MySQL with `--local-infile=1` so `import.sql` can read local CSV files properly
