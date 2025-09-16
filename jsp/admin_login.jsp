<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
String error = "";
if("POST".equalsIgnoreCase(request.getMethod())) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    try {
        Connection con = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            session.setAttribute("admin", username);
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            error = "Invalid credentials";
        }
        con.close();
    } catch(Exception e) { error = "Error logging in."; }
}
%>
<html>
<head>
<title>Admin Login</title>
<style>
body { font-family: Arial; background: #f2f2f2; }
.card { background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; margin: 60px auto; padding: 30px; width: 350px; }
.button { background: #007bff; color: #fff; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; }
.error { color: red; }
</style>
</head>
<body>
<div class="card">
<h2>Admin Login</h2>
<form method="post">
    <label>Username: <input type="text" name="username" required /></label><br><br>
    <label>Password: <input type="password" name="password" required /></label><br><br>
    <button class="button" type="submit">Login</button>
</form>
<% if(!error.isEmpty()) { %><p class="error"><%= error %></p><% } %>
</div>
</body>
</html>