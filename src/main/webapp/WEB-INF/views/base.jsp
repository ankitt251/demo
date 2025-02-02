<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>RevShop - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/base.css">
    <!-- Added Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
</head>
<body>
    <!-- Start Navbar -->
    <nav class="navbar navbar-expand-lg navbar-modern fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fa-solid fa-cart-shopping"></i> RevShop</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <c:choose>
                        <c:when test="${empty user}">
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/"><i class="fa-solid fa-house"></i> Home</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${user.role == 'ROLE_ADMIN'}">
                                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/admin/"><i class="fa-solid fa-house"></i> Home</a></li>
                            </c:if>
                            <c:if test="${user.role == 'ROLE_USER'}">
                                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/"><i class="fa-solid fa-house"></i> Home</a></li>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="/products">Product</a></li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Category</a>
                        <ul class="dropdown-menu">
                            <c:forEach var="category" items="${categories}">
                                <li><a class="dropdown-item" href="/products?category=${category.name}">${category.name}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <c:choose>
                        <c:when test="${empty user}">
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/signin"><i class="fa-solid fa-right-to-bracket"></i> LOGIN</a></li>
                            <li class="nav-item"><a class="nav-link active" aria-current="page" href="/register">REGISTER</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${user.role == 'ROLE_USER'}">
                                <li class="nav-item"><a class="nav-link active" aria-current="page" href="/user/cart"><i class="fa-solid fa-cart-shopping"></i> Cart [ ${countCart} ]</a></li>
                            </c:if>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-user"></i> ${user.name}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${user.role == 'ROLE_USER'}">
                                        <li><a class="dropdown-item" href="/user/profile">Profile</a></li>
                                    </c:if>
                                    <c:if test="${user.role == 'ROLE_ADMIN'}">
                                        <li><a class="dropdown-item" href="/admin/profile">Profile</a></li>
                                    </c:if>
                                    <c:if test="${user.role == 'ROLE_USER'}">
                                        <li><a class="dropdown-item" href="/user/user-orders">My Orders</a></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <div>
        <!-- Content to be included here -->
    </div>

    <!-- Start Footer -->
    <footer class="footer bg-dark text-white text-center py-3">
    	Copyright &copy; 2024 - RevShop. All Rights Reserved.
    </footer>
  
    <!-- End Footer -->

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
