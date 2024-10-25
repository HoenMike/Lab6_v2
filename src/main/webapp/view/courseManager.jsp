<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Course Manager</title>
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
			<!-- Course List Section -->
			<div class="row mb-4">
				<div class="col">
					<h2>Course List</h2>
				</div>
			</div>

			<!-- Course Table -->
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Course ID</th>
						<th>Course Name</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${courses}" var="course">
						<tr>
							<td>${course.id}</td>
							<td>${course.name}</td>
							<td class="action-links">
								<a
									href="${pageContext.request.contextPath}/CourseServlet?action=edit&courseId=${course.id}"
									>Edit</a
								>
								<a
									href="${pageContext.request.contextPath}/CourseServlet?action=delete&id=${course.id}"
									onclick="return confirm('Are you sure you want to delete this course?')"
									>Delete</a
								>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- Navigation -->
			<div class="row mt-4">
				<div class="col">
					<a
						href="${pageContext.request.contextPath}/CourseServlet?action=new"
						class="btn btn-primary"
						>New Course</a
					>
					<a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary ml-2"
						>Back to Homepage</a
					>
				</div>
			</div>
		</div>

		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	</body>
</html>
