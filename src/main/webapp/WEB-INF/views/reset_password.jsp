<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="/css/reset_password.css">
</head>
<body>
    <section class="reset-password-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6 image-container">
                    <img alt="E-commerce" src="img/ecom.png" class="ecom-image">
                </div>
                <div class="col-md-6 form-container">
                    <div class="card">
                        <div class="card-header">
                            <h1>Reset Password</h1>

                            <c:if test="${not empty sessionScope.succMsg}">
                                <p class="message success">${sessionScope.succMsg}</p>
                                <c:set var="sessionScope.succMsg" value="" />
                            </c:if>

                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p class="message error">${sessionScope.errorMsg}</p>
                                <c:set var="sessionScope.errorMsg" value="" />
                            </c:if>
                        </div>
                        <div class="card-body">
                            <form action="/reset-password" method="post" id="resetPassword" novalidate>
                                <div class="form-group">
                                    <label for="pass">New Password</label>
                                    <input id="pass" class="form-control" name="password" type="password" placeholder="Enter new password" required>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPass">Confirm Password</label>
                                    <input id="confirmPass" class="form-control" name="confirmPassword" type="password" placeholder="Confirm new password" required>
                                </div>

                                <input type="hidden" value="${param.token}" name="token">

                                <button type="submit" class="btn-submit">Reset Password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
