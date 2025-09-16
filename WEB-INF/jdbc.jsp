<%@ page import="java.sql.*" %>
<%
Connection con = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(dbURL, dbUser, dbPass);
    // ... use con ...
} catch(Exception e) {
    out.print("<p>Error connecting to database.</p>");
}
%>