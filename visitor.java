package visitor;

import java.sql.*;
import java.util.*;

public class VisitorApp {
    private String name, email, mobile, qualification, yop, city;

    // Getters and Setters
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public void setQualification(String qualification) { this.qualification = qualification; }
    public void setYop(String yop) { this.yop = yop; }
    public void setCity(String city) { this.city = city; }

    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getMobile() { return mobile; }
    public String getQualification() { return qualification; }
    public String getYop() { return yop; }
    public String getCity() { return city; }

    // Database Connection
    private static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
           		
           		//"jdbc:mysql://127.0.0.1:3306/pcsdatabase", "pcsbng", "pcsadmin@4321"
           		"jdbc:mysql://127.0.0.1:3306/visitor_tracking", "visitor_user", "mypassword123"
                    );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Insert new visitor
    public static void insertVisitor(VisitorApp bean) {
        try (Connection conn = getConnection()) {
            if (conn == null) {
                System.out.println("❌ DB connection failed.");
                return;
            }

            String query = "INSERT INTO visitors (name, email, mobile, qualification, yop, city, visit_date) " +
                           "VALUES (?, ?, ?, ?, ?, ?, CURDATE())";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getEmail());
            ps.setString(3, bean.getMobile());
            ps.setString(4, bean.getQualification());
            ps.setString(5, bean.getYop());
            ps.setString(6, bean.getCity());

            int result = ps.executeUpdate();
            System.out.println(result > 0 ? "✅ Visitor inserted." : "❌ Visitor insertion failed.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Validate admin login
    public static boolean validateAdmin(String email, String pass) {
        try (Connection conn = getConnection()) {
            String query = "SELECT * FROM admin WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Forgot password - fetch from DB
    public static String getPassword(String email) {
        try (Connection conn = getConnection()) {
            String query = "SELECT password FROM admin WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("password");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all visitors grouped by date (yyyy-MM-dd)
    public static Map<String, List<VisitorApp>> getVisitorsByDate() {
        Map<String, List<VisitorApp>> map = new LinkedHashMap<>();
        try (Connection conn = getConnection()) {
        	String query = "SELECT * FROM visitors ORDER BY visit_date ASC, id ASC";
;
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.sql.Date sqlDate = rs.getDate("visit_date");
                String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(sqlDate);

                VisitorApp v = new VisitorApp();
                v.setName(rs.getString("name"));
                v.setEmail(rs.getString("email"));
                v.setMobile(rs.getString("mobile"));
                v.setQualification(rs.getString("qualification"));
                v.setYop(rs.getString("yop"));
                v.setCity(rs.getString("city"));

                map.computeIfAbsent(date, k -> new ArrayList<>()).add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}