<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../base.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<!-- Add any required CSS or JS files here -->
</head>
<body>
	<section>
		<div class="container p-5 mt-3">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card card-sh">
						<div class="card-header text-center">
							<p class="fs-4">Add Product</p>

							<!-- Success Message -->
							<c:if test="${not empty sessionScope.succMsg}">
								<p class="text-success fw-bold">${sessionScope.succMsg}</p>
								<%
								session.removeAttribute("succMsg");
								%>
							</c:if>

							<!-- Error Message -->
							<c:if test="${not empty sessionScope.errorMsg}">
								<p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
								<%
								session.removeAttribute("errorMsg");
								%>
							</c:if>

						</div>
						<div class="card-body">
							<form
								action="${pageContext.request.contextPath}/admin/saveProduct"
								method="post" enctype="multipart/form-data">
								<div class="mb-3">
									<label>Enter Title</label> <input type="text" name="title"
										class="form-control">
								</div>

								<div class="mb-3">
									<label>Enter Description</label>
									<textarea rows="3" class="form-control" name="description"></textarea>
								</div>

								<div class="mb-3">
									<label>Category</label> <select class="form-control"
										name="category">
										<option>--select--</option>
										<!-- Iterating through categories using JSTL -->
										<c:forEach var="c" items="${categories}">
											<option value="${c.name}">${c.name}</option>
										</c:forEach>
									</select>
								</div>


								<div class="mb-3">
									<label>Enter Price</label> <input type="number" name="price"
										class="form-control">
								</div>

								<div class="mb-3">
									<label>Status</label>
									<div class="form-check">
										<input class="form-check-input" type="radio" checked
											value="true" name="isActive" id="flexRadioDefault1">
										<label class="form-check-label" for="flexRadioDefault1">Active</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="isActive"
											value="false" id="flexRadioDefault2"> <label
											class="form-check-label" for="flexRadioDefault2">Inactive</label>
									</div>
								</div>

								<div class="row">
									<div class="mb-3 col">
										<label>Enter Stock</label> <input type="text" name="stock"
											class="form-control">
									</div>
									<div class="mb-3 col">
										<label>Upload Image</label> <input type="file" name="file"
											class="form-control">
									</div>
								</div>

								<button class="btn btn-primary col-md-12">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html> 
