<%@ include file="../WEB-INF/dbconfig.jsp" %>
<%@ page import="java.sql.*" %>
<%
String message = "";
if("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password); // For production, hash the password!
        ps.executeUpdate();
        message = "Registration successful! Please <a href='login.jsp'>login</a>.";
        con.close();
    } catch(Exception e) { message = "Error: " + e.getMessage(); }
}
%>
<html>
<head>
<title>Register</title>
<style>
body { font-family: 'Segoe UI', Arial, sans-serif; background: #f2f2f2; margin: 0; }
.register-card { background: #fff; border-radius: 10px; box-shadow: 0 2px 12px #bbb; margin: 60px auto; padding: 32px; width: 350px; }
h2 { color: #007bff; margin-bottom: 24px; }
input[type="text"], input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 4px; }
.button { background: #007bff; color: #fff; border: none; border-radius: 4px; padding: 10px 20px; cursor: pointer; font-weight: bold; width: 100%; }
.login-link { display: block; margin-top: 18px; text-align: center; color: #007bff; text-decoration: none; font-weight: bold; }
.login-link:hover { text-decoration: underline; }
p { color: #dc3545; font-weight: bold; }
</style>
</head>
<body>
<div class="register-card">
<h2>User Registration</h2>
<form method="post">
    <input type="text" name="name" placeholder="Name" required />
    <input type="email" name="email" placeholder="Email" required />
    <input type="text" name="phone" placeholder="Phone" />
    <input type="password" name="password" placeholder="Password" required />
    <button class="button" type="submit">Register</button>
</form>
<a class="login-link" href="login.jsp">Already have an account? Login</a>
<p><%= message %></p>
</div>
</body>
</html>
