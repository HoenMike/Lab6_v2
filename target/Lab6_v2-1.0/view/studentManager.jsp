<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Student Manager</title>
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
			<!-- Student List Section -->
			<div class="row mb-4">
				<div class="col">
					<h2>Student List</h2>
				</div>
			</div>

			<!-- Student Table -->
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
								<a onclick="openEditModal(${student.id}, '${student.name}')">Edit</a>
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

			<!-- Navigation -->
			<div class="row mt-4">
				<div class="col">
					<button class="btn btn-primary" onclick="openAddModal()">New Student</button>
					<a href="${pageContext.request.contextPath}/view/index.jsp" class="btn btn-secondary ml-2"
						>Back to Homepage</a
					>
				</div>
			</div>
		</div>

		<!-- Add Student Modal -->
		<div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Add New Student</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="${pageContext.request.contextPath}/StudentServlet" method="post">
						<div class="modal-body">
							<input type="hidden" name="action" value="add" />
							<div class="form-group">
								<label for="newStudentId">Student ID:</label>
								<input type="text" class="form-control" id="newStudentId" name="id" required />
							</div>
							<div class="form-group">
								<label for="studentName">Student Name:</label>
								<input type="text" class="form-control" id="studentName" name="name" required />
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Add Student</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Edit Student Modal -->
		<div class="modal fade" id="editStudentModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Edit Student</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="${pageContext.request.contextPath}/StudentServlet" method="post">
						<div class="modal-body">
							<input type="hidden" name="action" value="update" />
							<div class="form-group">
								<label for="editStudentId">Student ID:</label>
								<input type="text" class="form-control" id="editStudentId" name="id" required />
							</div>
							<div class="form-group">
								<label for="editStudentName">Student Name:</label>
								<input type="text" class="form-control" id="editStudentName" name="name" required />
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Update Student</button>
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
				$("#addStudentModal").modal("show");
			}

			function openEditModal(id, name) {
				document.getElementById("editStudentId").value = id;
				document.getElementById("editStudentName").value = name;
				$("#editStudentModal").modal("show");
			}
		</script>
	</body>
</html>