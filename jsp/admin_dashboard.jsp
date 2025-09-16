<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("admin") == null) {
    response.sendRedirect("admin_login.jsp");
    return;
}
int totalBookings = 0;
double totalRevenue = 0;
String mostBookedType = "";
int maxCount = 0;
StringBuilder roomAvailability = new StringBuilder();
try {
    Connection con = null;
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM bookings");
    if(rs1.next()) totalBookings = rs1.getInt(1);
    ResultSet rs2 = st.executeQuery("SELECT SUM(total_amount) FROM bookings");
    if(rs2.next()) totalRevenue = rs2.getDouble(1);
    ResultSet rs3 = st.executeQuery("SELECT room_type, COUNT(*) as cnt FROM bookings JOIN rooms ON bookings.room_id=rooms.id GROUP BY room_type ORDER BY cnt DESC LIMIT 1");
    if(rs3.next()) mostBookedType = rs3.getString("room_type");
    ResultSet rs4 = st.executeQuery("SELECT room_type, availability FROM rooms");
    roomAvailability.append("<table style='width:100%;border-collapse:collapse;'>");
    roomAvailability.append("<tr style='background:#007bff;color:#fff;'><th>Room Type</th><th>Available</th></tr>");
    while(rs4.next()) {
        roomAvailability.append("<tr style='background:#f9f9f9;'><td>").append(rs4.getString("room_type")).append("</td><td>").append(rs4.getInt("availability")).append("</td></tr>");
    }
    roomAvailability.append("</table>");
    con.close();
} catch(Exception e) { out.print("<p>Error loading analytics.</p>"); }
%>
<html>
<head>
<title>Admin Dashboard</title>
<style>
body { font-family: Arial; background: #f2f2f2; }
.card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 40px auto; padding: 30px; width: 600px; }
h2 { color: #007bff; }
.metric { background: #e9ffe9; border-radius: 6px; padding: 10px; margin: 10px 0; font-size: 18px; }
</style>
</head>
<body>
<div class="card">
<h2>Analytics Dashboard</h2>
<div class="metric">Total Bookings: <b><%= totalBookings %></b></div>
<div class="metric">Total Revenue: <b>$<%= totalRevenue %></b></div>
<div class="metric">Most Booked Room Type: <b><%= mostBookedType %></b></div>
<h3>Current Room Availability</h3>
<%= roomAvailability.toString() %>
</div>
</body>
</html>