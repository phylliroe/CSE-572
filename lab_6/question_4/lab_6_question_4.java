/*
Name: Andrew Loop-Perez
ID: 006198799
Course: CSE 572 Winter 2020
Assignment: Lab #6 Question 4


4. Display overtime pay for each employees on projects that employee assigned to and 
   calculate the total of overtime hours and amount to pay.
*/

import java.sql.*;
import java.math.BigDecimal;

class Question_4
{
    public static void main(String args[])
    {
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aloopperez", "la8799");

            // Select all elements from the EMP_PROJ_OVERTIME table
            String ot_query = "select * from emp_proj_overtime";
            PreparedStatement overtime_pstm = con.prepareStatement(ot_query);
            ResultSet rs = overtime_pstm.executeQuery();

            System.out.println("EMPLOYEE OVERTIME: ");
            
            while (rs.next())
            {
                int empno = rs.getInt("empno"); // Employee ID
                int projno = rs.getInt("projno"); // Project number
                int hourot = rs.getInt("hourot"); // Employye's overtime hours for the project

                // Get the employee's hourly pay rate from the HOURLY_RATE view
                String hourly_rate_query = "select hourly_rate from hourly_pay where empno = " + empno;
                PreparedStatement hourly_ot_pstm = con.prepareStatement(hourly_rate_query);
                ResultSet rs_hourly = hourly_ot_pstm.executeQuery();
                rs_hourly.next();

                // Employee's overtime pay = twice their hourly rate multiplied by their number of overtime hours
                BigDecimal ot_pay = new BigDecimal(rs_hourly.getString("hourly_rate"));
                BigDecimal ot_hours = new BigDecimal(hourot);
                BigDecimal twice = new BigDecimal("2");
                ot_pay = twice.multiply(ot_pay.multiply(ot_hours));

                // Print the employee's ID, the project they are working on, their overtime hours for that project
                // and their hourly overtime pay rate
                System.out.print("EMPNO: " + empno);
                System.out.print(", PROJNO: " + projno);
                System.out.print(", OVERTIME HOURS: " + hourot);
                System.out.println(", OVERTIME PAY: $" + ot_pay);

                rs_hourly.close();
            }

            rs.close();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
}