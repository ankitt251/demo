<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Cart Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script>
        function updateQuantity(cartId, element) {
            const quantity = parseInt(element.value);
            const totalPriceElement = document.getElementById(`totalPrice_${cartId}`);
            const pricePerItem = parseFloat(element.dataset.price);
            if (!isNaN(quantity) && quantity > 0) {
                totalPriceElement.textContent = (quantity * pricePerItem).toFixed(2);
                document.getElementById('updateCartQuantity').value = quantity;
            }
        }

        function updateCart() {
            document.getElementById('cartForm').submit();
        }
    </script>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-5">
            <div class="card card-sh">
                <div class="card-header text-center">
                    <p class="fs-4">Cart Page</p>

                    <!-- Display success message -->
                    <c:if test="${not empty sessionScope.succMsg}">
                        <p class="text-success fw-bold">${sessionScope.succMsg}</p>
                        <c:remove var="sessionScope.succMsg" />
                    </c:if>

                    <!-- Display error message -->
                    <c:if test="${not empty sessionScope.errorMsg}">
                        <p class="text-danger fw-bold">${sessionScope.errorMsg}</p>
                        <c:remove var="sessionScope.errorMsg" />
                    </c:if>
                </div>

                <div class="card-body">
                    <form id="cartForm" action="${pageContext.request.contextPath}/user/updateCart" method="post">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sl No</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col" class="text-center">Quantity</th>
                                    <th scope="col">Total Price</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cart" items="${carts}" varStatus="status">
                                    <tr>
                                        <th scope="row">${status.index + 1}</th>
                                        <td>
                                            <img src="${pageContext.request.contextPath}/img/product_img/${cart.product.image}" width="70px" height="70px">
                                        </td>
                                        <td>${cart.product.title}</td>
                                        <td>${cart.product.discountPrice}</td>
                                        <td class="text-center">
                                            <input type="number" name="quantity[${cart.id}]" value="${cart.quantity}" min="1" data-price="${cart.product.discountPrice}" class="form-control" style="width: 100px;" onchange="updateQuantity(${cart.id}, this)">
                                        </td>
                                        <td id="totalPrice_${cart.id}">${cart.totalPrice}</td>
                                        <td>
                                            <button type="submit" name="remove[${cart.id}]" class="btn btn-danger">Remove</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td colspan="5" class="fw-bold text-end">Total Price</td>
                                    <td class="fw-bold">&#8377; ${totalOrderPrice}</td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-warning">Proceed Payment</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
