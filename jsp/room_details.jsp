<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
String roomId = request.getParameter("room_id");
int nights = 1;
if(request.getParameter("nights") != null) nights = Integer.parseInt(request.getParameter("nights"));
double taxRate = 0.12; // 12% tax
%>
<html>
<head>
<title>Room Details</title>
<style>
body { font-family: Arial; background: #f9f9f9; }
.card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 40px auto; padding: 30px; width: 400px; }
.button { background: #28a745; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; }
</style>
</head>
<body>
<%
Connection con = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms WHERE id=?");
    ps.setInt(1, Integer.parseInt(roomId));
    ResultSet rs = ps.executeQuery();
    if(rs.next()) {
        double price = rs.getDouble("price_per_night");
        double subtotal = price * nights;
        double tax = subtotal * taxRate;
            double total = subtotal + tax; // Calculate total including tax
%>
    <div class="card">
        <h2><%= rs.getString("room_type") %></h2>
        <p><%= rs.getString("description") %></p>
            <p>Price/Night: ₹<%= String.format("%.2f", price) %></p>
        <form method="get">
            <label>Nights: <input type="number" name="nights" value="<%= nights %>" min="1" /></label>
            <input type="hidden" name="room_id" value="<%= roomId %>" />
            <button class="button" type="submit">Recalculate</button>
        </form>
        <hr>
            <p>Subtotal: ₹<%= String.format("%.2f", subtotal) %></p>
            <p>Tax (12%): ₹<%= String.format("%.2f", tax) %></p>
            <h3>Total: ₹<%= String.format("%.2f", total) %></h3>
        <form action="booking_summary.jsp" method="post">
            <input type="hidden" name="room_id" value="<%= roomId %>" />
            <input type="hidden" name="nights" value="<%= nights %>" />
            <input type="hidden" name="total" value="<%= total %>" />
            <button class="button" type="submit">Buy</button>
        </form>
    </div>
<%
    }
    con.close();
} catch(Exception e) { out.print("<p>Error loading room details.</p>"); }
%>
</body>
</html>