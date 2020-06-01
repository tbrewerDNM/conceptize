<%@page import="beans.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.User"%>
<%@page import="beans.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/355024952d.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
        <script src="scripts.js"></script>
        <form id="goto-product-submit" action="ProductServlet" method="post">
            <input hidden name="action" value="product">
            <input hidden id="pid-input" name="pid" value="0">
        </form>
        <form id="goto-search" action="SearchServlet" method="post">
            <input hidden name="action" value="search">
            <input hidden id="search-text-input" name="text" value="">
            <input hidden id="search-cat-input" name="cat" value="7">
            <input hidden id="change-cat-input" name="change" value="1">
        </form>
        <form id="goto-profile" action="ProfileServlet" method="post">
            <input hidden name="action" value="profile">
            <input id="uid-input" hidden name="uid" value="">
        </form>
        <form id="goto-edit-profile" action="ProfileServlet" method="post">
            <input hidden name="action" value="gotoEdit">
        </form>
        <form id="goto-edit-product" action="ProductServlet" method="post">
            <input hidden name="action" value="create-product">
        </form>         
    </head>
    <body>
        <div id="page-container">
        <div id="content-wrap">
            <div class="container-fluid" id="navigation-header" style="padding-bottom:2px;">
                <nav class="navbar-header">
                    <div class="row" style="padding-bottom:0px !important">
                        <div class="input-group col-md-3 col-lg-2 col-xl-2"><a class="navbar-brand" href="index.jsp" style="float:none"><img src="./WebsiteUsage/logo.svg"/><span id="brand">onceptize</span></a></div>
                        <div class="input-group mb-3 col-md-6 col-lg-7 col-xl-8" style="padding-top:10px;">
                            <div class="input-group-prepend">
                                <div class="dropdown">
                                    <button id="home-dropdown" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <%=Product.cat2str((String) session.getAttribute("SEARCH_CATEGORY"))%>
                                    </button>
                                    <div class="dropdown-menu">
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">All</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Design</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Digital Marketing</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Original Characters</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Writing</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Inventions</a>
                                        <a onclick="changeCategory('home-dropdown', this)" class="dropdown-item" href="#">Music</a>
                                    </div>
                                </div>
                            </div>
                            <input id="search-bar" type="text" class="form-control" placeholder="Search" name="search">
                            <div class="input-group-append">
                                <button id="search-btn" onclick="searchProduct()" class="btn btn-info" type="button"><i class="fas fa-search"></i></button>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3 col-xl-2" style="padding-top:10px;float:none;text-align:right;">
                            <%User user = null;%>
                            <%if (session.getAttribute("LOGIN_USER") != null) {%>
                            <%user = User.getUser(session.getAttribute("LOGIN_USER").toString());%>
                            <span class="dropdown"><a href="#" class="dropdown-toggle" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-portrait"></i> <%=user.getUid()%> <b class="caret"></b></a>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    <span class="dropdown-item" onclick="loadProfilePage('<%=user.getUid()%>')">My Profile</span>
                                    <span class="dropdown-item" onclick="document.getElementById('goto-edit-profile').submit()">Edit Profile</span>
                                    <span class="dropdown-item" onclick="document.getElementById('goto-edit-product').submit()">Upload Product</span>
                                    <span class="dropdown-item" onclick="document.getElementById('logout').submit()">Log Out</span>
                                </div> | <a href="orders.jsp"><strong><%=user.getCoins()%></strong> coins</a>
                            </span>
                            <form id="logout" action="AuthServlet" method="post">
                                <input type="hidden" name="action" value="logout">
                            </form>
                            <%} else {%>
                            <span><a href="login.jsp"><i class="fas fa-portrait"></i> Sign In</a> | <a href="register.jsp"><strong>Join</strong></a></span>
                            <%}%>
                        </div>
                    </div>
                </nav>
            </div>
                <div class="container" style="padding-top: 50px;padding-left:10px;padding-right:10px;">
                        <div class="row">
                                        <div class="col-md-7 col-lg-7 col-xl-7" style="border: 1px solid lightgray;background-color:white;">
                                            <div class="row" style="border-bottom: 1px solid lightgray; padding-bottom: 0px; padding-top: 10px;padding-left:5px"><h2>Previous Orders</h2></div>
                                            <div class="row" style="padding-bottom:20px"></div>
                                            <%
                                                user = (User)session.getAttribute("LOGIN_USER");
                                                ArrayList<Order> orders = user.getOrders();
                                                ArrayList<Order> buyers = user.getBuyers();
                                                pageContext.setAttribute("orders", orders);
                                                pageContext.setAttribute("buyers", buyers);
                                            %>                                            
                                            <c:forEach var="ords" items="${orders}">
                                                <c:set var="ord" value="${ords}"/>
                                                <%
                                                Order ord = (Order)pageContext.getAttribute("ord");
                                                Product product = Product.getProduct(ord.getPid());
                                                %>
                                                <div class="row" style="padding-left: 5px;"><strong>Order ID: #${ords.getOid()}</strong></div>
                                                <div class="row" id="item" style="background-color: white; padding-bottom:0px;padding-top:10px">
                                                    <div class="col-4 col-lg-4 col-xl-4">
                                                            <img style="cursor:pointer;" onclick="loadProductPage('${ords.getPid()}')" class="w-100 checkout-pic" src="<%=product.getImg()%>" style="border-radius:10px;"/><br>
                                                            <strong><%=product.getTitle()%></strong><br>
                                                            By <a href="#" onclick="loadProfilePage('<%=product.getUid()%>')"><%=product.getUid()%></a>
                                                    </div>
                                                    <div class="col-4 col-lg-4 col-xl-4 checkout-product-text">
                                                        <strong>Order Completed:</strong> ${ords.getMakedate()}
                                                    </div>
                                                    <div class="col-3 col-lg-3 col-xl-3 checkout-product-text">
                                                        <h4 style="color:red;">-<%=product.getPrice()%> Coins</h4>
                                                    </div>
                                                </div>
                                                <hr>
                                            </c:forEach>                                         
                                        </div>
                                        <div class="col-md-1 col-lg-1 col-xl-1"></div>
                                        <div class="col-md-4 col-lg-4 col-xl-4">
                                                <div class="row" style="padding-bottom: 0px;">
                                                        <h3>Buyers</h3>
                                                </div>
                                                        <div class="row" style="padding-bottom: 0px;">
                                                            <div class="row" id="item" style="background-color: white; padding:10px;border:1px solid lightgray">
                                                                <c:forEach var="buyer" items="${buyers}">
                                                                    <c:set var="ord" value="${buyer}"/>
                                                                    <%
                                                                    Order buy = (Order)pageContext.getAttribute("ord");
                                                                    User buser = User.getUser(buy.getUid());
                                                                    Product product2 = Product.getProduct(buy.getPid());
                                                                    %>                                                                    
                                                                    <div class="col-4 col-lg-6 col-xl-6">
                                                                            <div class="pfp2" style="background-image: url(<%=buser.getPicid()%>);" id="img"></div><br>
                                                                            <a href="#" onclick="loadProfilePage('${buyer.getUid()}')">${buyer.getUid()}</a>
                                                                    </div>
                                                                    <div class="col-4 col-lg-6 col-xl-6 checkout-product-text">
                                                                        <h5><%=product2.getTitle()%></h5><hr>
                                                                        <h4 style="color:green;"<span>+</span><%=product2.getPrice()%> Coins</h4>
                                                                    </div>
                                                                <hr>
                                                                </c:forEach>
                                                                </div>
                                                        </div>
                                        </div>

                        </div>
                </div>
           <div class="page-footer footer_div">
            <footer class="footer bg-mute mt-auto" style="position:fixed">
                <div class="text-center">Copyright &copy; Seviss 2019</div>
            </footer>
        </div>
    </body>
    <script>
        var input = document.getElementById("search-bar");
        input.addEventListener("keyup", function (event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById("search-btn").click();
            }
        });
    </script>
</html>
