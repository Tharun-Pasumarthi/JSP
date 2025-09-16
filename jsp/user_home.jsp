<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Hotel Room Booking - Home</title>
<style>
body { font-family: 'Segoe UI', Arial, sans-serif; background: #f2f2f2; margin: 0; }
.navbar { background: #007bff; color: #fff; padding: 16px 32px; display: flex; justify-content: space-between; align-items: center; }
.navbar a { color: #fff; text-decoration: none; font-weight: bold; margin-left: 20px; }
.room-card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 20px; padding: 20px; display: inline-block; width: 300px; }
.button { background: #007bff; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; }
.logout-btn { background: #dc3545; color: #fff; border: none; border-radius: 4px; padding: 8px 18px; cursor: pointer; font-weight: bold; }
</style>
</head>
<body>
<div class="navbar">
    <span style="font-size:1.3em;font-weight:bold;">Welcome, <%= session.getAttribute("user_name") != null ? session.getAttribute("user_name") : "User" %></span>
    <form action="user_logout.jsp" method="post" style="margin:0;display:inline;">
        <button class="logout-btn" type="submit">Logout</button>
    </form>
</div>
<h2 style="margin-top:32px;">Available Rooms</h2>
<%
Connection con = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM rooms WHERE availability > 0");
    while(rs.next()) {
%>
    <div class="room-card">
        <h3><%= rs.getString("room_type") %></h3>
        <p><%= rs.getString("description") %></p>
    <p>Price/Night: &#8377; <%= String.format("%.2f", rs.getDouble("price_per_night")) %></p>
        <form action="room_details.jsp" method="get">
            <input type="hidden" name="room_id" value="<%= rs.getInt("id") %>" />
            <button class="button" type="submit">View</button>
        </form>
    </div>
<%
    }
    con.close();
} catch(Exception e) { out.print("<p>Error loading rooms.</p>"); }
%>
</body>
</html>