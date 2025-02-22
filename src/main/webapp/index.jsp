<%
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
    if (hour < 12) {
        out.println("<h1>Good morning, Ritika Raut. Welcome to COMP367</h1>");
    } else {
        out.println("<h1>Good afternoon, Ritika Raut. Welcome to COMP367</h1>");
    }
%>
