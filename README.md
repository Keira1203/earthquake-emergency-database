# Earthquake Emergency Database

## Project Overview

This project aims to develop a database system that helps emergency organizations
quickly identify the safety and location of people after a major earthquake.

## Project Structure

- `sql/schema.sql` - Database schema, tables, constraints, and data types
- `sql/data.sql` - Realistic mock data
- `sql/queries.sql` - Basic SQL operations and advanced queries

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

### Important

* Steps **1** are done in **PowerShell/Terminal**.
* Steps **2–4** are done inside **MySQL**, after you see `mysql>`.
* `CREATE DATABASE disaster_management;` only needs to be run **once**.
* If the database already exists, do **not** run `CREATE DATABASE` again. Start with:

```sql
USE disaster_management;
```

