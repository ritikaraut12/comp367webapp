<%@ page import="java.time.LocalTime" %>
<html>
<head>
    <title>Greeting Page</title>
</head>
<body>
    <%
        LocalTime currentTime = LocalTime.now();
        String greeting = (currentTime.getHour() < 12) ? "Good morning" : "Good afternoon";
    %>
    <h1><%= greeting %>, Ritika Raut! Welcome to COMP367</h1>
</body>
</html>
