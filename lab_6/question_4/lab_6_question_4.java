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
            String ot_query = "select * from emp_proj_overtime order by empno";
            PreparedStatement overtime_pstm = con.prepareStatement(ot_query);
            ResultSet rs = overtime_pstm.executeQuery();

            // Display the overtime hours and overtime pay for each project that and employee is working on
            // Provided that they have any overtime at all
            System.out.println("EMPLOYEE PROJECT OVERTIME: ");

            while (rs.next())
            {
                int empno = rs.getInt("empno"); // Employee ID
                int projno = rs.getInt("projno"); // Project number
                int hourot = rs.getInt("hourot"); // Employye's overtime hours for the project

                String hourly_rate_query = "select hourly_rate from hourly_pay where empno = " + empno;
                PreparedStatement hourly_ot_pstm = con.prepareStatement(hourly_rate_query);
                ResultSet rs_hourly = hourly_ot_pstm.executeQuery();
                rs_hourly.next();

                // Employee's overtime pay = twice their hourly rate multiplied by their number of overtime hours
                BigDecimal ot_pay = new BigDecimal(rs_hourly.getString("hourly_rate"));
                BigDecimal ot_hours = new BigDecimal(hourot);
                BigDecimal twice = new BigDecimal("2");
                ot_pay = ot_pay.multiply(twice.multiply(ot_hours));

                // Print the employee's ID, the project they are working on, their overtime hours for that project
                // and their hourly overtime pay rate
                System.out.print("EMPNO: " + empno);
                System.out.print(", PROJNO: " + projno);
                System.out.print(", OVERTIME HOURS: " + hourot);
                System.out.println(", OVERTIME PAY: $" + ot_pay);
            }

            rs.close();

            // Display the total overtime hours and total overtime pay for each employee
            System.out.println("\n" + "TOTAL OVERTIME HOURS AND TOTAL OVERTIME PAY: ");
            
            // Select distince employee numbers from EMP_PROJ_OVERTIME
            String total_query = "select distinct empno from emp_proj_overtime";
            PreparedStatement total_ot = con.prepareStatement(total_query);
            ResultSet rs_total = total_ot.executeQuery();

            while(rs_total.next())
            {
                int total_empno = rs_total.getInt("empno");

                // Get employee's total overtime hours
                String get_all = "select sum(hourot) from emp_proj_overtime where empno = " + total_empno;
                PreparedStatement total_emps = con.prepareStatement(get_all);
                ResultSet rs_total_hours = total_emps.executeQuery();
                rs_total_hours.next();
                int total_emp_ot_hours = rs_total_hours.getInt(1);

                // Get employees hourly pay rate
                String get_total_pay = "select hourly_rate from hourly_pay where empno = " + total_empno;
                PreparedStatement total_pay_statement = con.prepareStatement(get_total_pay);
                ResultSet rs_total_pay = total_pay_statement.executeQuery();
                rs_total_pay.next();

                // Calculate employee's total overtime pay
                BigDecimal pay_rate = new BigDecimal(rs_total_pay.getString("hourly_rate"));
                BigDecimal total_ot_pay = new BigDecimal(total_emp_ot_hours);
                BigDecimal two = new BigDecimal("2");
                total_ot_pay = total_ot_pay.multiply(two.multiply(pay_rate));
                
                // Display results
                System.out.print("EMPNO: " + total_empno + ", ");
                System.out.print("TOTAL OVERTIME HOURS: " + total_emp_ot_hours + ", ");
                System.out.println("TOTAL OVERTIME PAY: $" + total_ot_pay);
            }

            rs_total.close();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
}