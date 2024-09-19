<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - RevShop</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/icons/user-1.svg">
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-modern">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-store"></i>
                    <span>Rev</span>
                    <span>Shop</span>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/">HOME</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/register">SIGN UP</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container login-container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card card-modern">
                    <div class="card-body">
                        <h2 class="card-title text-center">Login</h2>
                        <form action="<%= request.getContextPath() %>/login" method="post">
                            <div class="form-group">
                                <label for="userType">Login as:</label>
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" id="customer" name="userType" value="customer" checked>
                                    <label class="form-check-label" for="customer">Customer</label>
                                </div>
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" id="admin" name="userType" value="admin">
                                    <label class="form-check-label" for="admin">Admin</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember Me</label>
                            </div>
                            <button type="submit" class="btn btn-modern btn-block">Login</button>
                            <p class="text-center mt-3"><a href="<%= request.getContextPath() %>/forgot-password">Forgot Password?</a></p>
                            <p class="text-center mt-2">Don't have an account? <a href="<%= request.getContextPath() %>/register">Register</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="bg-light text-center py-3 mt-5">
        <p>&copy; 2024 RevShop. All rights reserved.</p>
    </footer>

    <!-- Bootstrap and FontAwesome JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
