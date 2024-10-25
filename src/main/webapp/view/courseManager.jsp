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
				cursor: pointer;
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
								<a onclick="openEditModal(${course.id}, '${course.name}')">Edit</a>
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
					<button class="btn btn-primary" onclick="openAddModal()">New Course</button>
					<a href="${pageContext.request.contextPath}/view/index.jsp" class="btn btn-secondary ml-2"
						>Back to Homepage</a
					>
				</div>
			</div>
		</div>

		<!-- Add Course Modal -->
		<div class="modal fade" id="addCourseModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add New Course</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="${pageContext.request.contextPath}/CourseServlet" method="post">
						<div class="modal-body">
							<input type="hidden" name="action" value="add" />
							<div class="form-group">
								<label for="courseName">Course Name:</label>
								<input type="text" class="form-control" id="courseName" name="name" required />
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Add Course</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Edit Course Modal -->
		<div class="modal fade" id="editCourseModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Edit Course</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="${pageContext.request.contextPath}/CourseServlet" method="post">
						<div class="modal-body">
							<input type="hidden" name="action" value="update" />
							<input type="hidden" name="id" id="editCourseId" />
							<div class="form-group">
								<label for="editCourseName">Course Name:</label>
								<input type="text" class="form-control" id="editCourseName" name="name" required />
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Update Course</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

		<script>
			function openAddModal() {
				$("#addCourseModal").modal("show");
			}

			function openEditModal(id, name) {
				document.getElementById("editCourseId").value = id;
				document.getElementById("editCourseName").value = name;
				$("#editCourseModal").modal("show");
			}
		</script>
	</body>
</html>
