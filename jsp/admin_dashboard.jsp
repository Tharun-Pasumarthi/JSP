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
StringBuilder userBookings = new StringBuilder();
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
    // Show user bookings with user name and contact
    ResultSet rs5 = st.executeQuery("SELECT b.id, u.name, u.email, u.phone, b.room_id, b.nights, b.total_amount FROM bookings b JOIN users u ON b.user_id = u.id");
    userBookings.append("<table style='width:100%;border-collapse:collapse;margin-top:30px;'>");
    userBookings.append("<tr style='background:#007bff;color:#fff;'><th>Booking ID</th><th>User Name</th><th>Email</th><th>Phone</th><th>Room ID</th><th>Nights</th><th>Total</th></tr>");
    while(rs5.next()) {
        userBookings.append("<tr style='background:#f9f9f9;'><td>").append(rs5.getInt("id")).append("</td><td>")
        .append(rs5.getString("name")).append("</td><td>")
        .append(rs5.getString("email")).append("</td><td>")
        .append(rs5.getString("phone")).append("</td><td>")
        .append(rs5.getInt("room_id")).append("</td><td>")
        .append(rs5.getInt("nights")).append("</td><td>")
    .append("&#8377; ").append(String.format("%.2f", rs5.getDouble("total_amount"))).append("</td></tr>");
    }
    userBookings.append("</table>");
    con.close();
} catch(Exception e) { out.print("<p>Error loading analytics.</p>"); }
%>
<html>
<head>
<title>Admin Dashboard</title>
<style>
body { font-family: 'Segoe UI', Arial, sans-serif; background: #f2f2f2; margin: 0; }
.navbar { background: #007bff; color: #fff; padding: 16px 32px; display: flex; justify-content: space-between; align-items: center; }
.navbar a { color: #fff; text-decoration: none; font-weight: bold; margin-left: 20px; }
.card { background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #bbb; margin: 40px auto; padding: 32px; width: 90%; max-width: 900px; }
h2 { color: #007bff; margin-bottom: 24px; }
.metric { background: #e9ffe9; border-radius: 6px; padding: 12px; margin: 12px 0; font-size: 20px; }
table { width: 100%; border-collapse: collapse; margin-top: 18px; }
th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
th { background: #007bff; color: #fff; }
tr:nth-child(even) { background: #f9f9f9; }
.logout-btn { background: #dc3545; color: #fff; border: none; border-radius: 4px; padding: 8px 18px; cursor: pointer; font-weight: bold; }
</style>
</head>
<body>
<div class="navbar">
    <span style="font-size:1.3em;font-weight:bold;">Admin Dashboard</span>
    <form action="logout.jsp" method="post" style="margin:0;display:inline;">
        <button class="logout-btn" type="submit">Logout</button>
    </form>
</div>
<div class="card">
<h2>Analytics Dashboard</h2>
<div class="metric">Total Bookings: <b><%= totalBookings %></b></div>
<div class="metric">Total Revenue: <b>&#8377; <%= String.format("%.2f", totalRevenue) %></b></div>
<div class="metric">Most Booked Room Type: <b><%= mostBookedType %></b></div>
<h3>Current Room Availability</h3>
<%= roomAvailability.toString() %>
<h3 style="margin-top:32px;">User Bookings</h3>
<%= userBookings.toString() %>
</div>
</body>
</html>