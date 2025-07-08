<!DOCTYPE html>
<html>
<head>
    <title>Visitors Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<!-- jsPDF & html2canvas for PDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<!-- SheetJS for Excel -->
<script src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>

<%@ page import="java.util.*,visitor.VisitorApp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Calendar now = Calendar.getInstance();
String action = request.getParameter("action");
String selectedDate = request.getParameter("date");
String city = request.getParameter("city");
int CurrentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
int recordsPerPage = 31;

int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : now.get(Calendar.YEAR);
int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : now.get(Calendar.MONTH);

Map<String, List<VisitorApp>> visitorsMap = VisitorApp.getVisitorsByDate();
List<VisitorApp> allVisitors = new ArrayList<>();

if ("all".equals(action)) {
    for (List<VisitorApp> list : visitorsMap.values()) {
        allVisitors.addAll(list);
    }
    selectedDate = null;
} else if (selectedDate != null && request.getParameter("date") != null) {
    allVisitors = visitorsMap.getOrDefault(selectedDate, new ArrayList<>());
} else if (request.getParameter("year") != null && request.getParameter("month") != null) {
    for (String date : visitorsMap.keySet()) {
        if (date.startsWith(String.format("%04d-%02d", year, month + 1))) {
            allVisitors.addAll(visitorsMap.get(date));
        }
    }
    selectedDate = null;
} else {
    selectedDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    allVisitors = visitorsMap.getOrDefault(selectedDate, new ArrayList<>());
}

if (city != null && !city.isEmpty()) {
    List<VisitorApp> filteredByCity = new ArrayList<>();
    for (VisitorApp v : allVisitors) {
        if (city.equalsIgnoreCase(v.getCity())) {
            filteredByCity.add(v);
        }
    }
    allVisitors = filteredByCity;
}

int totalRecords = allVisitors.size();
int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
int startIndex = (CurrentPage - 1) * recordsPerPage;
int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
%>
<script>
function downloadTableAsPDF() {
    const tableContainer = document.querySelector('.table-container');
    html2canvas(tableContainer).then(canvas => {
        const imgData = canvas.toDataURL('image/png');
        const { jsPDF } = window.jspdf;
        const pdf = new jsPDF('p', 'mm', 'a4');
        const width = pdf.internal.pageSize.getWidth();
        const height = (canvas.height * width) / canvas.width;
        pdf.addImage(imgData, 'PNG', 0, 10, width, height);
        pdf.save("Visitors_Report.pdf");
    });
}
function downloadTableAsExcel() {
    const table = document.querySelector('.table-container table');
    const wb = XLSX.utils.table_to_book(table, { sheet: "Visitors" });
    XLSX.writeFile(wb, "Visitors_Report.xlsx");
}
</script>


<style>
body { font-family: Arial; background: linear-gradient(to bottom, #87cefa, #f1a5c2); margin: 0; padding: 0; }
header { background-color: #2c3e50; padding: 20px; color: white; font-size: 24px; display: flex; justify-content: space-between; align-items: center; }
.city-select {
 background-color: #3498db;
  color: white;
  padding: 8px; 
  font-size: 14px; 
  margin-right: 10px;
   border-radius: 5px; 
   }

.form-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.form-bar form {
    margin: 0;
}

.form-bar button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
}

.form-bar button:hover {
    background-color: #2980b9;
}

.all-data-btn {
    background-color: #28a745;
}

.all-data-btn:hover {
    background-color: #218838;
}

/* ✅ Red logout button */
.logout-btn {
    background-color: red !important;
    color: white;
    border: none;
    padding: 10px 16px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
}

.logout-btn:hover {
    background-color: darkred;
}



.container { display: flex; padding: 40px; gap: 60px; box-sizing: border-box; }
.calendar, .table-container { background: white; padding: 20px; border-radius: 10px; }
.calendar { width: 50%; margin-right: 20px; }
.table-container { width: 100%; }
table { width: 100%; border-collapse: collapse; }
table, th, td { border: 1px solid #ddd; }
th, td { padding: 10px; text-align: left; }
.pagination { text-align: center; margin-top: 10px; }
.pagination a { margin: 0 5px; padding: 8px 16px; background-color: #2c3e50; color: white; text-decoration: none; border-radius: 5px; }
</style>
<body>
<header>
    Visitors Dashboard
    <div class="form-bar">
        <!-- All Data Button -->
        <form method="get" style="margin: 0;">
            <input type="hidden" name="action" value="all">
            <button type="submit" class="all-data-btn">All Data</button>
        </form>

        <!-- Download Excel -->
        <button type="button" onclick="downloadTableAsExcel()">Download Excel</button>

        <!-- Download PDF -->
        <button type="button" onclick="downloadTableAsPDF()">Download PDF</button>

        <!-- City Dropdown -->
        <form method="get" style="margin: 0;">
            <select name="city" onchange="this.form.submit()" class="city-select">
                <option value="">All Cities</option>
                <option value="Bangalore" <%= "Bangalore".equals(city) ? "selected" : "" %>>Bangalore</option>
                <option value="Noida" <%= "Noida".equals(city) ? "selected" : "" %>>Noida</option>
                <option value="Kolkata" <%= "Kolkata".equals(city) ? "selected" : "" %>>Kolkata</option>
            </select>
        </form>

        <!-- Logout Button -->
        <form action="logout.jsp" method="post" style="margin: 0;">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</header>

<div class="container">
    <div class="calendar">
        <form method="get">
            Year:
            <select name="year">
                <%
                    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                    for (int y = 2015; y <= currentYear; y++) {
                %>
                <option value="<%= y %>" <%= (y == year ? "selected" : "") %>><%= y %></option>
                <% } %>
            </select>
            Month:
            <select name="month">
                <% String[] months = new java.text.DateFormatSymbols().getMonths();
                   for (int i = 0; i < 12; i++) { %>
                   <option value="<%=i%>" <%= (i==month ? "selected" : "") %>><%=months[i]%></option>
                <% } %>
            </select>
            <input type="hidden" name="city" value="<%= city != null ? city : "" %>">
            <button type="submit">Go</button>
        </form>
        <table>
            <tr>
                <th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>
            </tr>
            <%
                Calendar cal = Calendar.getInstance();
                cal.set(year, month, 1);
                int firstDay = cal.get(Calendar.DAY_OF_WEEK);
                int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
                int currentDay = 1;
                for (int row = 0; row < 6; row++) {
                    out.println("<tr>");
                    for (int col = 1; col <= 7; col++) {
                        if ((row == 0 && col < firstDay) || currentDay > daysInMonth) {
                            out.println("<td></td>");
                        } else {
                            cal.set(Calendar.DAY_OF_MONTH, currentDay);
                            String linkDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
                            String todayDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
                            boolean isToday = linkDate.equals(todayDate);
                            String tdStyle = isToday ? "style='background-color: #f1a5c2; font-weight: bold;'" : "";
                            out.println("<td " + tdStyle + "><a href='?year=" + cal.get(Calendar.YEAR) + "&month=" + cal.get(Calendar.MONTH) + "&date=" + linkDate + "&city=" + (city != null ? city : "") + "'>" + currentDay + "</a></td>");
                            currentDay++;
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
    </div>
    <div class="table-container">
        <h3>
            <% if (selectedDate != null && request.getParameter("date") != null) { %>
                Date: <%= selectedDate %>
            <% } else if (request.getParameter("year") != null && request.getParameter("month") != null) { %>
                Month: <%= months[month] %> <%= year %>
            <% } else if ("all".equals(action)) { %>
                Showing All Records
            <% } else { %>
                Today: <%= selectedDate %>
            <% } %>
            | Total: <%= totalRecords %>
        </h3>
        <table>
            <tr><th>#</th><th>Name</th><th>Email</th><th>Mobile</th><th>Qualification</th><th>City</th><th>YOP</th></tr>
            <% if (totalRecords == 0) { %>
                <tr><td colspan="7">No data available</td></tr>
            <% } else {
                for (int i = startIndex; i < endIndex; i++) {
                    VisitorApp v = allVisitors.get(i);
            %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= v.getName() %></td>
                    <td><%= v.getEmail() %></td>
                    <td><%= v.getMobile() %></td>
                    <td><%= v.getQualification() %></td>
                    <td><%= v.getCity() %></td>
                    <td><%= v.getYop() %></td>
                </tr>
            <% }} %>
        </table>
        <div class="pagination">
            <% if (CurrentPage > 1) { %>
                <a href="?year=<%=year%>&month=<%=month%><% if (selectedDate != null) { %>&date=<%=selectedDate%><% } %><% if (city != null) { %>&city=<%=city%><% } %>&page=<%=CurrentPage - 1%>">&laquo; Prev</a>
            <% } %>
            <% if (CurrentPage < totalPages) { %>
                <a href="?year=<%=year%>&month=<%=month%><% if (selectedDate != null) { %>&date=<%=selectedDate%><% } %><% if (city != null) { %>&city=<%=city%><% } %>&page=<%=CurrentPage + 1%>">Next &raquo;</a>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>