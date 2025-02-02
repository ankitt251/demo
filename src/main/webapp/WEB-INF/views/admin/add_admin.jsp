<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Add Admin</title>
    <link rel="stylesheet" href="path/to/bootstrap.css"> <!-- Ensure Bootstrap CSS is included -->
</head>
<body>
    <section>
        <div class="container mt-5 p-5">
            <div class="row">
                <div class="col-md-7 p-2 offset-md-2">
                    <div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
                        <div class="card-header text-center">
                            <p class="fs-4 text-center">Add Admin</p>

                            <% 
                                String succMsg = (String) session.getAttribute("succMsg");
                                String errorMsg = (String) session.getAttribute("errorMsg");
                                if (succMsg != null) {
                            %>
                                <p class="text-success fw-bold"><%= succMsg %></p>
                                <% session.removeAttribute("succMsg"); %>
                            <% 
                                } 
                                if (errorMsg != null) {
                            %>
                                <p class="text-danger fw-bold"><%= errorMsg %></p>
                                <% session.removeAttribute("errorMsg"); %>
                            <% 
                                } 
                            %>
                        </div>
                        <div class="card-body">
                            <form action="<c:url value='/admin/save-admin' />" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col">
                                        <label class="form-label">Full Name</label>
                                        <input required class="form-control" name="name" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">Mobile Number</label>
                                        <input required class="form-control" name="mobileNumber" type="number">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input required class="form-control" name="email" type="email">
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <label class="form-label">Address</label>
                                        <input required class="form-control" name="address" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">City</label>
                                        <input required class="form-control" name="city" type="text">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <label class="form-label">State</label>
                                        <input required class="form-control" name="state" type="text">
                                    </div>

                                    <div class="col">
                                        <label class="form-label">Pincode</label>
                                        <input required class="form-control" name="pincode" type="number">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col">
                                        <label class="form-label">Password</label>
                                        <input required class="form-control" name="password" type="password">
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Confirm Password</label>
                                        <input required class="form-control" name="cpassword" type="password">
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Profile Image</label>
                                    <input class="form-control" name="img" type="file">
                                </div>
                                
                                <button type="submit" class="btn bg-primary text-white col-md-12">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
