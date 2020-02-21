/*
Name: Andrew Loop-Perez
ID: 006198799
Course: CSE 572 Winter 2020
Assignment: Lab #6 Quesiton #1

1. Use provided examples to write A java program that takes input of empNo 
   from the terminal and retrieve employee data from employee table
*/

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.*;

class Question_1
{
    public static void main(String args[]) 
    {
        try
        {
            System.out.println("Enter Employee ID: ");
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            String name = reader.readLine();

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aloopperez", "la8799");
            String query = "select * from emp where empno = " + name;
            PreparedStatement pstm_employees = con.prepareStatement(query);
            ResultSet rs_employees = pstm_employees.executeQuery();
    
            System.out.println("\n" + "Emplyoee Information: ");
            while (rs_employees.next())
            {
                System.out.println("Employee ID:" + rs_employees.getString(1));
 				System.out.println("Name: " + rs_employees.getString(3) + ", " + rs_employees.getString(2));
 				System.out.println("Address: " + rs_employees.getString(4));
 				System.out.println("Sex: " + rs_employees.getString(5));
                System.out.println("Salary: " + rs_employees.getString(6));
                System.out.println("Position: " + rs_employees.getString(7));
                System.out.println("Department Number: " + rs_employees.getString(8));
                System.out.println("Email: " + rs_employees.getString(9));
                System.out.println("Birth Date: " + rs_employees.getString(10));
                System.out.println("Hire Date: " + rs_employees.getString(11) +"\n");
            }
        
        }   
        catch(Exception e)
        {
            System.out.println(e);
        } 
    }
}






