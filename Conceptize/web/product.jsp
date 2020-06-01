<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="beans.Product"%>
<%@page import="beans.User"%>
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
        <title>Conceptize | Product</title>
        <link rel="icon" href="./WebsiteUsage/logo.svg" type="image/png">
    <form id="product-submit" action="OrderServlet" method="post">
        <input hidden name="action" value="checkout">
        <input hidden name="pid" value="<%=request.getParameter("pid")%>">
    </form>
    <form id="goto-profile" action="ProfileServlet" method="post">
        <input hidden name="action" value="profile">
        <input id="uid-input" hidden name="uid" value="">
    </form>
    <form id="goto-product-submit" action="ProductServlet" method="post">
        <input hidden name="action" value="product">
        <input hidden id="pid-input" name="pid" value="0">
    </form>
    <form id="goto-search" action="SearchServlet" method="post">
        <input hidden name="action" value="search">
        <input hidden id="search-text-input" name="text" value="">
        <input hidden id="search-cat-input" name="cat" value="7">
    </form>
    <form id="goto-edit-profile" action="ProfileServlet" method="post">
        <input hidden name="action" value="gotoEdit">
    </form>
    <form id="goto-edit-product" action="ProductServlet" method="post">
        <input hidden name="action" value="create-product">
    </form>
</head>
<body>
    <%Product product = Product.getProduct(request.getParameter("pid"));%>
    <% if (product == null && session.getAttribute("NEW_PRODUCT") != null) { %>
    <% product = Product.getProduct((int) session.getAttribute("NEW_PRODUCT"));
        }%>
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

            <%if (product != null) {%>
            <div class="container" style="padding-top:10px">
                <div class="small-only">
                    <div class="row">
                        <div class="col-sm-12">
                            <section class="product-meta">
                                <div class="container">

                                    <div class="row">
                                        <div class="col-12">
                                            <div class="product-title" style="text-align:center"><%=product.getTitle()%></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div style="text-align:center;" class="col-12">
                                            <span class="product-creator">By <span onclick="loadProfilePage('<%=product.getUid()%>')"><%=product.getUid()%></span></span><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div style="margin:auto;left:30vw;" class="product-prices">
                                                <div class="product-price-text">Price: <%=product.getPrice()%></div>
                                                <%if (product.isNegotiable()) {%>
                                                <div class="product-nego-text">Negotiable: Yes</div>
                                                <%} else {%>
                                                <div class="product-nego-text">Negotiable: No</div>
                                                <%}%>
                                                <hr>
                                                <div class="product-btn-wrap">
                                                    <%if (user != null && !product.getUid().equals(user.getUid())) {%>
                                                    <button class="product-btn btn btn-default" onclick="document.getElementById('product-submit').submit()">Checkout</button>
                                                    <%} else {%>
                                                    <button class="product-btn btn btn-default" onclick="alert('Unable to purchase own product')">Checkout</button>
                                                    <%}%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br/>
                            </section>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <section class="product-pics">
                            <div id="product-carousel" class="carousel slide" data-ride="carousel">
                                <!-- The slideshow -->
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img class="product-image" src="<%=product.getImg()%>" alt="Product Image">
                                    </div>
                                    <div class="carousel-item">
                                        <img class="product-image" src="<%=product.getImg()%>" alt="Product Image">
                                    </div>
                                    <div class="carousel-item">
                                        <img class="product-image" src="<%=product.getImg()%>" alt="Product Image">
                                    </div>
                                </div>
                            </div>
                            <div class="container">
                                <div class="row">
                                    <div class="col-3">
                                        <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                                            <span class="carousel-control-prev-icon"></span>
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <div style="height:5vw;top:4vw;">
                                            <!-- Indicators -->
                                            <ul hidden class="carousel-indicators">
                                                <li data-target="#product-carousel" data-slide-to="0" class="active"></li>
                                                <li data-target="#product-carousel" data-slide-to="1"></li>
                                                <li data-target="#product-carousel" data-slide-to="2"></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <!-- Left and right controls -->
                                        <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                                            <span class="carousel-control-next-icon"></span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="col-md-6 medium-only">
                        <div class="product-title"><%=product.getTitle()%></div>
                        <span class="product-creator">By <span onclick="loadProfilePage('<%=product.getUid()%>')"><%=product.getUid()%></span></span>
                        <br/>
                        <div class="product-prices">
                            <div class="product-price-text">Price: <%=product.getPrice()%></div>
                            <%if (product.isNegotiable()) {%>
                            <div class="product-nego-text">Negotiable: Yes</div>
                            <%} else {%>
                            <div class="product-nego-text">Negotiable: No</div>
                            <%}%>
                            <hr>
                            <%if (user != null && !product.getUid().equals(user.getUid())) {%>
                            <button class="product-btn btn btn-default" onclick="document.getElementById('product-submit').submit()">Checkout</button>
                            <%} else {%>
                            <button class="product-btn btn btn-default" onclick="alert('Unable to purchase own product')">Checkout</button>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <section class="product-desc">
                            <div>Description</div>
                            <hr/>
                            <div class="product-user-html">
                                <%=product.getDesc()%>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer bg-mute mt-auto">
            <div class="text-center">Copyright &copy; Seviss 2019</div>
        </footer>
    </div>
    <%} else {%>
    <meta http-equiv = "refresh" content = "0; url = error.jsp" />
    <%}%>
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
