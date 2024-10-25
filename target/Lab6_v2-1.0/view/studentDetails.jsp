<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>Student Details</title>
		<link
			rel="stylesheet"
			href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
		/>
	</head>
	<body>
		<div class="container mt-5">
			<div class="card">
				<div class="card-body">
					<h2 class="card-title mb-4">Student Details</h2>
					<!-- Student Information -->
					<div class="row mb-4">
						<div class="col-md-6">
							<p><strong>Student ID:</strong> ${student.id}</p>
							<p><strong>Student Name:</strong> ${student.name}</p>
						</div>
					</div>
					<!-- Course Registration Form -->
					<div class="mb-4">
						<h3>Add New Course</h3>
						<form
							action="${pageContext.request.contextPath}/StudentServlet"
							method="post"
							class="form-inline"
						>
							<input type="hidden" name="studentID" value="${student.id}" />
							<input type="hidden" name="action" value="addCourse" />
							<div class="form-group mr-2">
								<select name="courseId" class="form-control" <c:if test="${empty availableCourses}">disabled</c:if>>
									<c:choose>
										<c:when test="${not empty availableCourses}">
											<c:forEach items="${availableCourses}" var="course">
												<option value="${course.id}">${course.name}</option>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<option value="">No courses available</option>
										</c:otherwise>
									</c:choose>
								</select>
							</div>
							<button type="submit" class="btn btn-primary" <c:if test="${empty availableCourses}">disabled</c:if>>
								Add Course
							</button>
						</form>
						<c:if test="${empty availableCourses}">
							<small class="text-muted mt-2 d-block">This student is enrolled in all available courses.</small>
						</c:if>
					</div>
					<!-- Registered Courses Table -->
					<div>
						<h3>Registered Courses</h3>
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Course ID</th>
									<th>Course Name</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${registeredCourses}" var="course">
									<tr>
										<td>${course.id}</td>
										<td>${course.name}</td>
										<td>
											<form
												action="${pageContext.request.contextPath}/StudentServlet"
												method="post"
												style="display: inline"
											>
												<input type="hidden" name="studentID" value="${student.id}" />
												<input type="hidden" name="courseId" value="${course.id}" />
												<input type="hidden" name="action" value="removeCourse" />
												<button type="submit" class="btn btn-link text-danger">Remove</button>
											</form>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty registeredCourses}">
									<tr>
										<td colspan="3" class="text-center">No courses registered yet</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!-- Navigation -->
					<div class="mt-4">
						<a href="${pageContext.request.contextPath}/view/index.jsp" class="btn btn-secondary"
							>Back to Homepage</a
						>
					</div>
				</div>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	</body>
</html>