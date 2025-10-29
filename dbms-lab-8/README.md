# DBMS Lab 8 - PostgreSQL Database Operations with Node.js

## Prerequisites

- Node.js (v14 or higher)
- PostgreSQL database server
- PostgreSQL database named `studentdb`

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

This will install the required `pg` package for PostgreSQL connectivity.

### 2. Database Setup

1. Ensure PostgreSQL is running on your system
2. Create a database named `studentdb`:
   ```sql
   CREATE DATABASE studentdb;
   ```
3. Update the database connection string in `task.js` if needed:
   ```javascript
   const DatabaseUrl="postgresql://username:password@localhost/studentdb"
   ```
   Replace `username` and `password` with your PostgreSQL credentials.

### 3. Project Structure

```
dbms-lab8/
├── task.js          # Main application file
├── dbconnect.js     # Database connection module
├── package.json     # Node.js dependencies and scripts
└── README.md        # This file
```

## Execution Steps

### Running the Application

```bash
node task.js
```

### Menu Options

The application provides an interactive menu with the following options:

```
Main Menu:
1. Create Table
2. Insert Student
3. Update Student
4. Delete Student
5. Query Data
6. Exit
```

### Task Descriptions

#### Task 1: Create Table
- Prompts for table name and column definitions
- Creates the table if it doesn't exist
- Confirms creation by querying `information_schema.tables`

Example usage:
- Table name: `students`
- Columns: `id SERIAL PRIMARY KEY, name VARCHAR(100), age INT, department VARCHAR(100)`

#### Task 2: Data Insertion and Manipulation (DML)
- Prompts for number of students to add
- Collects student details (ID, name, age, department)
- Inserts records into the students table
- Updates a student's department based on their name
- Provides feedback on success/failure
- Deletes a student record by ID
- Provides feedback on success/failure

#### Task 3: Query Operations
Submenu with options:
1. Display all students
2. Display students by department
3. Display average age by department (GROUP BY)
4. Find students by name pattern (LIKE)

### Sample Database Schema

The application expects a `students` table with the following structure:

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department VARCHAR(100)
);
```

## Error Handling

The application includes comprehensive error handling:

- Database connection errors
- SQL query errors
- Invalid user input
- Graceful shutdown on SIGINT (Ctrl+C) and SIGTERM
- Automatic cleanup of database connections and readline interface

## Exit and Cleanup

- Use option `6` in the main menu for normal exit
- Press `Ctrl+C` for immediate termination
- All database connections are closed gracefully
- Readline interface is properly cleaned up

## Dependencies

- **pg**: PostgreSQL client for Node.js
- **readline**: Built-in Node.js module for terminal input

## Troubleshooting

### Connection Issues
- Verify PostgreSQL is running
- Check database credentials in the connection string
- Ensure the `studentdb` database exists

### Permission Issues
- Verify the PostgreSQL user has necessary permissions
- Check if the user can create tables and insert data

### Module Issues
- Ensure `"type": "module"` is set in `package.json`
- Use Node.js version 14 or higher for ES module support