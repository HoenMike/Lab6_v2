<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Student and Course List</title>
        <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        />
        <style>
            .action-links a {
                margin-right: 10px;
                text-decoration: underline;
                color: blue;
            }
            .action-links a:last-child {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="row mb-4">
                <div class="col">
                    <h2>Student List</h2>
                </div>
            </div>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String connectionURL = "jdbc:mysql://localhost:3306/lab6";
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection(connectionURL, "hoenmike", "Crtm123123");
                            statement = connection.createStatement();
                            rs = statement.executeQuery("SELECT * FROM student");

                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("StudentID") + "</td>");
                                out.println("<td>" + rs.getString("StudentName") + "</td>");
                                out.println("<td class='action-links'>");
                                out.println("<a href='" + request.getContextPath() + "/StudentServlet?action=edit&studentID=" + rs.getInt("StudentID") + "'>Edit</a>");
                                out.println("<a href='" + request.getContextPath() + "/StudentServlet?action=delete&studentID=" + rs.getInt("StudentID") + "' onclick='return confirm(\"Are you sure you want to delete this student?\")'>Delete</a>");
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                            if (statement != null) try { statement.close(); } catch (Exception e) { e.printStackTrace(); }
                            if (connection != null) try { connection.close(); } catch (Exception e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>

            <div class="row mt-4">
                <div class="col">
                    <a
                        href="${pageContext.request.contextPath}/StudentServlet?action=new"
                        class="btn btn-primary"
                        >New Student</a
                    >
                    <a href="${pageContext.request.contextPath}/view/index.jsp" class="btn btn-secondary ml-2"
                        >Homepage</a
                    >
                </div>
            </div>

            <div class="row mt-5">
                <div class="col">
                    <h2>Course List</h2>
                </div>
            </div>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            connection = DriverManager.getConnection(connectionURL, "hoenmike", "Crtm123123");
                            statement = connection.createStatement();
                            rs = statement.executeQuery("SELECT * FROM course");

                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("CourseID") + "</td>");
                                out.println("<td>" + rs.getString("CourseName") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                            if (statement != null) try { statement.close(); } catch (Exception e) { e.printStackTrace(); }
                            if (connection != null) try { connection.close(); } catch (Exception e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>