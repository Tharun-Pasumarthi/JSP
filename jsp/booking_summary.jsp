<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
String roomId = request.getParameter("room_id");
String nightsParam = request.getParameter("nights");
String totalParam = request.getParameter("total");
int nights = 1;
double total = 0.0;
boolean success = false;
if(roomId == null || roomId.isEmpty() || nightsParam == null || nightsParam.isEmpty() || totalParam == null || totalParam.isEmpty()) {
    out.print("<p>Missing booking details. Please go back and try again.</p>");
} else {
    try {
        nights = Integer.parseInt(nightsParam);
        total = Double.parseDouble(totalParam);
        String userName = "Guest"; // Replace with session user if login implemented
        Connection con = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("INSERT INTO bookings (room_id, user_name, nights, total_amount) VALUES (?, ?, ?, ?)");
        ps.setInt(1, Integer.parseInt(roomId));
        ps.setString(2, userName);
        ps.setInt(3, nights);
        ps.setDouble(4, total);
        int rows = ps.executeUpdate();
        if(rows > 0) success = true;
        // Update room availability
        PreparedStatement ps2 = con.prepareStatement("UPDATE rooms SET availability = availability - 1 WHERE id = ?");
        ps2.setInt(1, Integer.parseInt(roomId));
        ps2.executeUpdate();
        con.close();
    } catch(Exception e) { out.print("<p>Error booking room.</p>"); }
}
%>
<html>
<head>
<title>Booking Summary</title>
<style>
body { font-family: Arial; background: #e9ffe9; }
.card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 40px auto; padding: 30px; width: 400px; text-align: center; }
.button { background: #007bff; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; }
</style>
</head>
<body>
<div class="card">
<% if(success) { %>
    <h2>Booking Confirmed!</h2>
    <p>Thank you for booking. Total Amount Paid: $<%= total %></p>
    <a href="user_home.jsp" class="button">Back to Home</a>
<% } else { %>
    <h2>Booking Failed</h2>
    <a href="user_home.jsp" class="button">Try Again</a>
<% } %>
</div>
</body>
</html>