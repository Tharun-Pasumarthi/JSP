<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>Hotel Room Booking - Home</title>
<style>
body { font-family: Arial; background: #f2f2f2; }
.room-card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 20px; padding: 20px; display: inline-block; width: 300px; }
.button { background: #007bff; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; }
</style>
</head>
<body>
<h2>Available Rooms</h2>
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
        <p>Price/Night: $<%= rs.getDouble("price_per_night") %></p>
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