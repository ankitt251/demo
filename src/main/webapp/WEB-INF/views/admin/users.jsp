<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.ecom.service.CommnServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecom.model.UserDtls" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>User Management</title>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="card card-sh">
                <div class="card-header text-center">
                    <p class="fs-4">
                        <c:choose>
                            <c:when test="${userType == 1}">Users</c:when>
                            <c:when test="${userType == 2}">Admin</c:when>
                        </c:choose>
                    </p>

                    <%
                        // Retrieve the Spring application context and get the service bean
                        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
                        CommnServiceImpl commnServiceImpl = (CommnServiceImpl) ctx.getBean("commnServiceImpl");
                    %>

                    <!-- Success Message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                        <%
                            // Remove the success message from the session
                            commnServiceImpl.removeSessionMessage();
                        %>
                    </c:if>

                    <!-- Error Message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                        <%
                            // Remove the error message from the session
                            commnServiceImpl.removeSessionMessage();
                        %>
                    </c:if>
                </div>

                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sl No</th>
                                <th scope="col">Profile</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Mobile No</th>
                                <th scope="col">Address</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}" varStatus="c">
                                <tr>
                                    <th scope="row">${c.count}</th>
                                    <td><img src="${pageContext.request.contextPath}/img/profile_img/${u.profileImage}" width="70px" height="70px"></td>
                                    <td>${u.name}</td>
                                    <td>${u.email}</td>
                                    <td>${u.mobileNumber}</td>
                                    <td>${u.address}, ${u.city}, ${u.state}, ${u.pincode}</td>
                                    <td>${u.isEnable}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/updateSts?status=true&id=${u.id}&type=${userType}" class="btn btn-sm btn-primary">Active</a> 
                                        <a href="${pageContext.request.contextPath}/admin/updateSts?status=false&id=${u.id}&type=${userType}" class="btn btn-sm btn-danger">Inactive</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</body>
</html>