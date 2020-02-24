/*
Name: Andrew Loop-Perez
ID: 006198799
Course: CSE 572 Winter 2020
Assignment: Lab #6 Quesiton #2

2. Use provided examples to write A java program that takes inputs 
   from the terminal and insert or update the employees table.
*/

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.Buffer;
import java.sql.*;
import java.util.Scanner;

class Question_2
{
    public static void main(String args[]) 
    {
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aloopperez", "la8799");

            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            Scanner scanner = new Scanner(System.in);

            // Prompt the user to enter 1 to insert into the EMP table
            // or 2 to update an existing entry in the EMP table
            System.out.println("Enter 1 to Insert or 2 to Update: ");
            int action = Integer.parseInt(scanner.nextLine());

            System.out.println(" ");
            
            // Insert new row into EMP table
            if (action == 1)
            {
                // Prompt the user for the table's various fields. 
                System.out.println("Enter Employee Number: ");
                int empno = Integer.parseInt(scanner.nextLine());
                
                System.out.println("Enter Employee First Name: ");
                String fname = scanner.nextLine(); 

                System.out.println("Enter Employee Last Name: ");
                String lname = scanner.nextLine(); 

                System.out.println("Enter Employee Address: ");
                String address = scanner.nextLine(); 

                System.out.println("Enter Employee's Sex (M/F): ");
                String sex = scanner.nextLine(); 

                System.out.println("Enter Employee Position: ");
                String position = scanner.nextLine(); 

                System.out.println("Enter Employee Salary: ");
                int salary = Integer.parseInt(scanner.nextLine());

                System.out.println("Enter Employee's Department Number: ");
                int deptno = Integer.parseInt(scanner.nextLine());

                System.out.println("Enter Employee's Email");
                String email = scanner.nextLine(); 

                System.out.println("Enter Employee's Birth Date (mm/dd/yyyy): ");
                String birth_date = scanner.nextLine(); 

                System.out.println("Enter Employee's Hire Date (mm/dd/yyyy): ");
                String hire_date = scanner.nextLine();
                
                // Create the SQL statement
                String insert = "insert into emp " + 
                                "(empno, fname, lname, address, sex, salary, position, deptno, email, birth_date, hire_date) " + 
                                "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement emp_insert_statement = con.prepareStatement(insert);

                // Add the user's entered values into the statement
                emp_insert_statement.setInt(1, empno);
                emp_insert_statement.setString(2, fname);
                emp_insert_statement.setString(3, lname);
                emp_insert_statement.setString(4, address);
                emp_insert_statement.setString(5, sex);
                emp_insert_statement.setInt(6, salary);
                emp_insert_statement.setString(7, position);
                emp_insert_statement.setInt(8, deptno);
                emp_insert_statement.setString(9, email);
                emp_insert_statement.setString(10, birth_date);
                emp_insert_statement.setString(11, hire_date);

                // Insert the values
                emp_insert_statement.executeUpdate();
                System.out.println("Values inserted into EMP table");
            }
            // Update existing values
            else if (action == 2)
            {
                // Create the beginning of the update statement
                String update = "update emp set ";

                // Prompt the user for the ID of the employee they wish to update
                System.out.println("Enter the ID of the Employee you want to upate: ");
                int empno_update = Integer.parseInt(scanner.nextLine());

                // Prompt the user to enter the name of the column they want to update
                System.out.println("Enter the name of the column: ");
                String update_column = scanner.nextLine();

                // Prompt the user for the new value
                System.out.println("Enter the new value: ");
                String update_value = scanner.nextLine();

                // Add the user input to the update statement
                update = update + update_column + " = '" + update_value + "' where empno = " + empno_update;
                //System.out.println(update);

                // Run the update statement
                PreparedStatement emp_update_pstmt = con.prepareStatement(update);
                emp_update_pstmt.executeUpdate();
                System.out.println("EMP table has been updated");
            }
            else 
            {
                System.out.println("Invalid option. Please try again.");
            }
        }
        catch(Exception e)
        {
            System.out.println(e);
        }

    }
}








