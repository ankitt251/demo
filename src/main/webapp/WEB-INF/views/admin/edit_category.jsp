<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.ecom.service.CommnServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Edit Category</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <section>
        <div class="container-fluid p-5 mt-5">
            <div class="row">
                <div class="col-md-3 offset-md-5">
                    <div class="card card-sh">
                        <div class="card-header text-center">
                            <p class="fs-4">Edit Category</p>
                            
                            <!-- Display success message -->
                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                                <c:set var="dummy" value="${fn:escapeXml(sessionScope.removeSessionMessage())}" />
                            </c:if>

                            <!-- Display error message -->
                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                                <c:set var="dummy" value="${fn:escapeXml(sessionScope.removeSessionMessage())}" />
                            </c:if>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/updateCategory" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="${category.id}">
                                <div class="mb-3">
                                    <label>Enter Category</label>
                                    <input type="text" name="name" value="${category.name}" class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label>Status</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="true" name="isActive" id="flexRadioDefault1" <c:if test="${category.isActive}">checked</c:if>>
                                        <label class="form-check-label" for="flexRadioDefault1">Active</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" value="false" name="isActive" id="flexRadioDefault2" <c:if test="${!category.isActive}">checked</c:if>>
                                        <label class="form-check-label" for="flexRadioDefault2">Inactive</label>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label>Upload Image</label>
                                    <input type="file" name="file" class="form-control">
                                </div>
                                <img src="${pageContext.request.contextPath}/img/category_img/${category.imageName}" width="100px" height="100px">
                                <button class="btn btn-primary col-md-12 mt-2">Update</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
