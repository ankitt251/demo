<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../base.jsp" %>
<%@ page import="java.util.List" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>All Orders</title>
</head>
<body>
    <section>
        <div class="container-fluid mt-5 p-1">
            <div class="row">
                <p class="text-center fs-3 mt-2">All Orders</p>
                <hr>
                <a href="/admin/" class="text-decoration-none"><i class="fa-solid fa-arrow-left"></i> Back</a>

                <!-- Success message -->
                <c:if test="${not empty sessionScope.succMsg}">
                    <p class="text-success fw-bold text-center">${sessionScope.succMsg}</p>
                    <c:set var="null" value="${sessionScope.succMsg}" scope="session" />
                </c:if>

                <!-- Error message -->
                <c:if test="${not empty sessionScope.errorMsg}">
                    <p class="text-danger fw-bold text-center">${sessionScope.errorMsg}</p>
                    <c:set var="null" value="${sessionScope.errorMsg}" scope="session" />
                </c:if>

                <div class="col-md-4 p-4">
                    <form action="/admin/search-order" method="get">
                        <div class="row">
                            <div class="col">
                                <input type="text" class="form-control" name="orderId" placeholder="Enter order id">
                            </div>
                            <div class="col">
                                <button class="btn btn-primary col">Search</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="col-md-12 ps-4 pe-4">
                    <table class="table table-bordered card-sh">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Order Id</th>
                                <th scope="col">Deliver Details</th>
                                <th scope="col">Date</th>
                                <th scope="col">Product Details</th>
                                <th scope="col">Price</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <!-- If search result exists -->
                            <c:if test="${srch}">
                                <c:choose>
                                    <c:when test="${not empty orderDtls}">
                                        <tr>
                                            <th scope="row">${orderDtls.orderId}</th>
                                            <td>Name: ${orderDtls.orderAddress.firstName} ${orderDtls.orderAddress.lastName}<br>
                                                Email: ${orderDtls.orderAddress.email}<br>
                                                Mobno: ${orderDtls.orderAddress.mobileNo}<br>
                                                Address: ${orderDtls.orderAddress.address}<br>
                                                City: ${orderDtls.orderAddress.city}<br>
                                                State: ${orderDtls.orderAddress.state}, ${orderDtls.orderAddress.pincode}
                                            </td>
                                            <td>${orderDtls.orderDate}</td>
                                            <td>${orderDtls.product.title}</td>
                                            <td>Quantity: ${orderDtls.quantity}<br>
                                                Price: ${orderDtls.price}<br>
                                                Total Price: ${orderDtls.quantity * orderDtls.price}
                                            </td>
                                            <td>${orderDtls.status}</td>
                                            <td>
                                                <form action="/admin/update-order-status" method="post">
                                                    <div class="row">
                                                        <div class="col">
                                                            <select class="form-control" name="st">
                                                                <option>--select--</option>
                                                                <option value="1">In Progress</option>
                                                                <option value="2">Order Received</option>
                                                                <option value="3">Product Packed</option>
                                                                <option value="4">Out for Delivery</option>
                                                                <option value="5">Delivered</option>
                                                                <option value="6">Cancelled</option>
                                                            </select>
                                                        </div>
                                                        <input type="hidden" name="id" value="${orderDtls.id}">
                                                        <div class="col">
                                                            <c:choose>
                                                                <c:when test="${orderDtls.status == 'Cancelled' || orderDtls.status == 'Delivered'}">
                                                                    <button class="btn btn-primary btn-sm col disabled">Update</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-sm btn-primary">Update</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="fs-3 text-center text-danger">${errorMsg}</p>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                            <!-- Display all orders if no search -->
                            <c:if test="${not srch}">
                                <c:forEach var="o" items="${orders}">
                                    <tr>
                                        <th scope="row">${o.orderId}</th>
                                        <td>Name: ${o.orderAddress.firstName} ${o.orderAddress.lastName}<br>
                                            Email: ${o.orderAddress.email}<br>
                                            Mobno: ${o.orderAddress.mobileNo}<br>
                                            Address: ${o.orderAddress.address}<br>
                                            City: ${o.orderAddress.city}<br>
                                            State: ${o.orderAddress.state}, ${o.orderAddress.pincode}
                                        </td>
                                        <td>${o.orderDate}</td>
                                        <td>${o.product.title}</td>
                                        <td>Quantity: ${o.quantity}<br>
                                            Price: ${o.price}<br>
                                            Total Price: ${o.quantity * o.price}
                                        </td>
                                        <td>${o.status}</td>
                                        <td>
                                            <form action="/admin/update-order-status" method="post">
                                                <div class="row">
                                                    <div class="col">
                                                        <select class="form-control" name="st">
                                                            <option>--select--</option>
                                                            <option value="1">In Progress</option>
                                                            <option value="2">Order Received</option>
                                                            <option value="3">Product Packed</option>
                                                            <option value="4">Out for Delivery</option>
                                                            <option value="5">Delivered</option>
                                                            <option value="6">Cancelled</option>
                                                        </select>
                                                    </div>
                                                    <input type="hidden" name="id" value="${o.id}">
                                                    <div class="col">
                                                        <c:choose>
                                                            <c:when test="${o.status == 'Cancelled' || o.status == 'Delivered'}">
                                                                <button class="btn btn-primary btn-sm col disabled">Update</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-sm btn-primary">Update</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>

                    <!-- Pagination section -->
                    <c:if test="${not srch}">
                        <div class="row">
                            <div class="col-md-4">Total Orders: ${totalElements}</div>
                            <div class="col-md-6">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <li class="page-item ${isFirst ? 'disabled' : ''}">
                                            <a class="page-link" href="/admin/orders?pageNo=${pageNo-1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${pageNo+1 == i ? 'active' : ''}">
                                                <a class="page-link" href="/admin/orders?pageNo=${i-1}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <li class="page-item ${isLast ? 'disabled' : ''}">
                                            <a class="page-link" href="/admin/orders?pageNo=${pageNo+1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
