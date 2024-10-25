package controller;

import dao.CourseDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.Student;

/**
 * Servlet implementation class StudentServlet
 */
@WebServlet(name = "StudentServlet", urlPatterns = {"/StudentServlet"})
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listStudentsAndCourses(request, response);
                    break;
                case "view":
                    viewStudent(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                default:
                    listStudentsAndCourses(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "view":
                    int studentID = Integer.parseInt(request.getParameter("studentID"));
                    viewStudentDetails(studentID, request, response);
                    break;
                case "add":
                    addStudent(request, response);
                    break;
                case "update":
                    updateStudent(request, response);
                    break;
                case "addCourse":
                    addCourseRegistration(request, response);
                    break;
                case "removeCourse":
                    removeCourseRegistration(request, response);
                    break;
                default:
                    response.sendRedirect("StudentServlet?action=list");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Invalid student ID format");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("view/studentManager.jsp").forward(request, response);
    }

    private void viewStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("studentID"));
        viewStudentDetails(id, request, response);
    }

    private void viewStudentDetails(int studentID, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Student student = studentDAO.getStudent(studentID);
        if (student != null) {
            List<Course> registeredCourses = studentDAO.getRegisteredCourses(studentID);
            List<Course> availableCourses = studentDAO.getAvailableCourses(studentID);

            request.setAttribute("student", student);
            request.setAttribute("registeredCourses", registeredCourses);
            request.setAttribute("availableCourses", availableCourses);
            request.getRequestDispatcher("view/studentDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect("view/index.jsp");
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        Student student = new Student();
        student.setName(name);
        studentDAO.addStudent(student);
        response.sendRedirect("StudentServlet?action=list");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        Student student = new Student();
        student.setId(id);
        student.setName(name);
        studentDAO.updateStudent(student);
        response.sendRedirect("StudentServlet?action=list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect("StudentServlet?action=list");
    }

    private void addCourseRegistration(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentID = Integer.parseInt(request.getParameter("studentID"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        studentDAO.addCourseRegistration(studentID, courseId);
        response.sendRedirect("StudentServlet?action=view&studentID=" + studentID);
    }

    private void removeCourseRegistration(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int studentID = Integer.parseInt(request.getParameter("studentID"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        studentDAO.removeCourseRegistration(studentID, courseId);
        response.sendRedirect("StudentServlet?action=view&studentID=" + studentID);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("studentID"));
        Student student = studentDAO.getStudent(id);
        request.setAttribute("student", student);
        request.getRequestDispatcher("view/studentForm.jsp").forward(request, response);
    }

    private void listStudentsAndCourses(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("students", students);
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("view/studentManager.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
