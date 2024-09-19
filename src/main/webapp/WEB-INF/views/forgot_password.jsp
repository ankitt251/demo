<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="/css/forgot_password.css">
</head>
<body>
    <section class="forgot-password-section">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h1>Forgot Password</h1>

                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="message success">${sessionScope.succMsg}</p>
                        <c:remove var="succMsg" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="message error">${sessionScope.errorMsg}</p>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>
                </div>
                <div class="card-body">
                    <form action="/forgot-password" method="post">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input id="email" required="required" class="form-control" name="email" type="email" placeholder="Enter your email">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn-submit">Send</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
