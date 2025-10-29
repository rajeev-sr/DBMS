
import { Client } from 'pg'
import readline from "readline";

const DatabaseUrl="postgresql://postgres:Rajeev16034@localhost/studentdb"
const client = new Client(DatabaseUrl)
client.connect().catch(err => {
  console.error('Failed to connect to database:', err);
  process.exit(1);
});

//Task 1: Table Creation (DDL)
export default async function tableCreation(tableName,columnDescription){
    // Create table
    const createQuery = `CREATE TABLE IF NOT EXISTS ${tableName} (${columnDescription})`
    await client.query(createQuery)
    // Confirm creation
    const checkQuery = `
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' AND table_name = $1
    `
    const res = await client.query(checkQuery, [tableName])
    if (res.rows.length > 0) {
      console.log(`Table "${tableName}" created successfully.`)
    } else {
      console.log(`Table "${tableName}" was not created.`)
    }

}


//Task 2: Data Insertion and Manipulation (DML)

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function ask(question) {
  return new Promise((resolve) => rl.question(question, resolve));
}

async function insertStudents() {

  const n = parseInt(await ask("How many students do you want to add? "));
  for (let i = 0; i < n; i++) {
    const id = parseInt(await ask(`Enter ID for student ${i + 1}: `));
    const name = await ask(`Enter name for student ${i + 1}: `);
    const age = parseInt(await ask(`Enter age for student ${i + 1}: `));
    const department = await ask(`Enter department for student ${i + 1}: `);
    await client.query(
      "INSERT INTO students (id,name, age, department) VALUES ($1, $2, $3, $4)",
      [id,name, age, department]
    );
    console.log(`Student ${name} inserted.`);
  }
}

async function updateDepartment() {
  const name = await ask("Enter the name of the student to update: ");
  const department = await ask("Enter the new department: ");
  const res = await client.query(
    "UPDATE students SET department = $1 WHERE name = $2",
    [department, name]
  );
  if (res.rowCount > 0) {
    console.log("Department updated.");
  } else {
    console.log("No student found with that name.");
  }
}

async function deleteStudent() {
  const id = parseInt(await ask("Enter the ID of the student to delete: "));
  const res = await client.query("DELETE FROM students WHERE id = $1", [id]);
  if (res.rowCount > 0) {
    console.log("Student deleted.");
  } else {
    console.log("No student found with that ID.");
  }
}

//Task 3: Query Operations
async function displayAllStudents() {
  const res = await client.query("SELECT * FROM students");
  console.log("\nAll Students:");
  res.rows.forEach(row => console.log(row));
}

async function displayByDepartment() {
  const dept = await ask("Enter department to filter: ");
  const res = await client.query("SELECT * FROM students WHERE department = $1", [dept]);
  console.log(`\nStudents in department "${dept}":`);
  res.rows.forEach(row => console.log(row));
}

async function displayAverageAgeByDepartment() {
  const res = await client.query(
    "SELECT department, AVG(age) AS average_age FROM students GROUP BY department"
  );
  console.log("\nAverage age by department:");
  res.rows.forEach(row => 
    console.log(`Department: ${row.department}, Average Age: ${parseFloat(row.average_age).toFixed(2)}`)
  );
}

async function displayByNamePattern() {
  const letter = await ask("Enter starting letter for student names: ");
  const pattern = letter + "%";
  const res = await client.query(
    "SELECT * FROM students WHERE name LIKE $1",
    [pattern]
  );
  console.log(`\nStudents whose names start with "${letter}":`);
  res.rows.forEach(row => console.log(row));
}

//Task 4: User Interaction and Menu Design
async function queryMenu() {
  let q;
  do {
    q = await ask(
      "\nQuery Options:\n1. Display all students\n2. Display by department\n3. Display average age by department\n4. Find students by name pattern\n5. Back to main menu\nEnter choice: "
    );
    if (q === "1") {
      await displayAllStudents();
    } else if (q === "2") {
      await displayByDepartment();
    } else if (q === "3") {
      await displayAverageAgeByDepartment();
    } else if (q === "4") {
      await displayByNamePattern();
    }
  } while (q !== "5");
}

async function mainMenu() {
  let choice;
  do {
    choice = await ask(
      "\nMain Menu:\n1. Create Table\n2. Insert Student\n3. Update Student\n4. Delete Student\n5. Query Data\n6. Exit\nEnter your choice: "
    );
    if (choice === "1") {
      const tableName = await ask("Enter table name: ");
      const columns = await ask("Enter column definitions (e.g., id SERIAL PRIMARY KEY, name VARCHAR(100), age INT, department VARCHAR(100)): ");
      await tableCreation(tableName, columns);
    } else if (choice === "2") {
      await insertStudents();
    } else if (choice === "3") {
      await updateDepartment();
    } else if (choice === "4") {
      await deleteStudent();
    } else if (choice === "5") {
      await queryMenu();
    }
  } while (choice !== "6");
  rl.close();
  await client.end();
}

mainMenu();