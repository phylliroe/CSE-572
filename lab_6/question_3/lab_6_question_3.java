/*
Name: Andrew Loop-Perez
ID: 006198799
Course: CSE 572 Winter 2020
Assignment: Lab #6 Quesiton #3

3. Use provided examples to write A java program that takes inputs 
   from the terminal and update the emp_proj table.
*/

import java.sql.*;
import java.util.Scanner;

class Question_3
{
    public static void main(String args[])
    {
       try
       {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aloopperez", "la8799");

            Scanner scanner = new Scanner(System.in);

            int empno, projno, new_hours;
            String update = "update emp_proj set hoursworked = ";

            // Prompt the user for the ID of the employee they wish to update
            System.out.println("Enter the ID of the employee you wish to update: ");
            empno = Integer.parseInt(scanner.nextLine());

            // Prompt the user for the project number
            System.out.println("Enter the project number: ");
            projno = Integer.parseInt(scanner.nextLine());

            // Prompt the user for the employee hours for the project
            System.out.println("Enter the employee's new hours: ");
            new_hours = Integer.parseInt(scanner.nextLine());

            // Create the statement
            update = update + new_hours + " where empno = " + empno + " and projno = " + projno;

            // Execute the update statement
            PreparedStatement emp_proj_statement = con.prepareStatement(update);
            emp_proj_statement.executeUpdate();
            //System.out.println("Done!");
       }
        catch(Exception e)
        {
           System.out.println(e);
        }
    }
}