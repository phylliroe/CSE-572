import java.sql.*;

class Question_4
{
    public static void main(String args[])
    {
        //System.out.println("question 4");
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aloopperez", "la8799");

            String ot_query = "select * from emp_proj_overtime";
            PreparedStatement overtime_pstm = con.prepareStatement(ot_query);
            ResultSet rs = overtime_pstm.executeQuery();

            System.out.println("EMPLOYEE OVERTIME: ");
            while (rs.next())
            {
                int empno = rs.getInt("empno");
                int projno = rs.getInt("projno");
                int hourot = rs.getInt("hourot");

                System.out.print("EMPNO: " + empno);
                System.out.print(", PROJNO: " + projno);
                System.out.println(", OVERTIME HOURS: " + hourot);

            }

            rs.close();
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }
}