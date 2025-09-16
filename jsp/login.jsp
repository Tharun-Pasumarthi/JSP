<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
String message = "";
if("POST".equalsIgnoreCase(request.getMethod())) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            session.setAttribute("user_id", rs.getInt("id"));
            session.setAttribute("user_name", rs.getString("name"));
            session.setAttribute("user_email", rs.getString("email"));
            response.sendRedirect("user_home.jsp");
        } else {
            message = "Invalid email or password.";
        }
        con.close();
    } catch(Exception e) { message = "Error: " + e.getMessage(); }
}
%>
<html>
<head>
<title>User Login</title>
<style>
body { font-family: 'Segoe UI', Arial, sans-serif; background: #f2f2f2; margin: 0; }
.login-card { background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #bbb; margin: 60px auto; padding: 32px; width: 350px; }
h2 { color: #007bff; margin-bottom: 24px; }
input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 4px; }
.button { background: #007bff; color: #fff; border: none; border-radius: 4px; padding: 10px 20px; cursor: pointer; font-weight: bold; width: 100%; }
.register-link { display: block; margin-top: 18px; text-align: center; color: #007bff; text-decoration: none; font-weight: bold; }
.register-link:hover { text-decoration: underline; }
p { color: #dc3545; font-weight: bold; }
</style>
</head>
<body>
<div class="login-card">
<h2>User Login</h2>
<form method="post">
    <input type="email" name="email" placeholder="Email" required />
    <input type="password" name="password" placeholder="Password" required />
    <button class="button" type="submit">Login</button>
</form>
<a class="register-link" href="register.jsp">Don't have an account? Register</a>
<p><%= message %></p>
</div>
</body>
</html>
