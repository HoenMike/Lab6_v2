<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
					<c:forEach items="${students}" var="student">
						<tr>
							<td>${student.id}</td>
							<td>${student.name}</td>
							<td class="action-links">
								<a
									href="${pageContext.request.contextPath}/StudentServlet?action=view&studentID=${student.id}"
									>View</a
								>
								<a
									href="${pageContext.request.contextPath}/StudentServlet?action=edit&studentID=${student.id}"
									>Edit</a
								>
								<a
									href="${pageContext.request.contextPath}/StudentServlet?action=delete&id=${student.id}"
									onclick="return confirm('Are you sure you want to delete this student?')"
									>Delete</a
								>
							</td>
						</tr>
					</c:forEach>
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
					<c:forEach items="${courses}" var="course">
						<tr>
							<td>${course.id}</td>
							<td>${course.name}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	</body>
</html>
