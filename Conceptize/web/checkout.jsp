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
        <title>Conceptize | Checkout</title>
        <link rel="icon" href="./WebsiteUsage/logo.svg" type="image/png">
    <form id="checkout-submit" action="OrderServlet" method="post">
        <input hidden name="action" value="order">
        <input hidden name="pid" value=<%=request.getParameter("pid")%>>
    </form>
    <form id="create-product-submit" action="ProductServlet" method="post">
        <input hidden name="action" value="create-product">
        <input hidden id="submit-title" name="title" value="">
        <input hidden id="submit-cat" name="cat" value="7">
        <input hidden id="submit-price" name="price" value="0">
        <input hidden id="submit-nego" name="negotiable" value="1">
        <input hidden id="submit-desc" name="description" value="">
    </form>
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
    <%Product product = Product.getProduct(request.getParameter("pid"));%>
    <%if (product != null) {%>
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
            <div>
                <div class="container"style="padding-top:20px;">
                    <div class="row">
                        <div style="border:1px solid black;" class="col-sm-6 col-lg-6 col-lx-6 col-md-6">
                            <div class="container" style="padding-bottom:0px">
                                <div class="row" style="padding-top:10px;padding-bottom:0px;border-bottom:1px solid lightgray">
                                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 checkout-product-text">
                                        <h5 style="display:inline">Items</h5>
                                    </div>
                                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 "></div>
                                    <div class="col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 checkout-product-text">
                                        <strong>Price</strong>
                                    </div>
                                </div>
                                <div class="row" style="padding-top:10px;">
                                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                        <div class="chk-img"><img class="w-100 checkout-pic" style="border-radius:5px" src="<%=product.getImg()%>"/></div>
                                    </div>
                                    <div class="col-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 checkout-product-text">
                                        <span class="w-100 checkout-title"><%=product.getTitle()%></span>
                                    </div>
                                    <div class="col-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 checkout-product-text">
                                        <span class="checkout-price"><%=product.getPrice()%></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-1 col-lg-1 col-lx-1 col-md-1"></div>
                        <div  class="col-sm-4 col-md-4 col-lg-4 col-xl-4">
                            <div class="medium-only" style="border:1px solid black;padding:20px;">
                                <div><strong>Order Summary</strong><hr></div>
                                <table>
                                    <tr>
                                    <span class="checkout-title"><%=product.getTitle()%></span>&nbsp;
                                    <span class="checkout-price"><%=product.getPrice()%></span>
                                    <br/>
                                    </tr>
                                </table>
                                <hr/>
                                <span>Order Total: <span class="checkout-price"><%=product.getPrice()%></span></span><br/>
                                <div style="padding-top:2vh">
                                    <a href="index.jsp">
                                        <button class="btn btn-secondary btn-sm">Cancel</button>
                                    </a>
                                    <button onclick="document.getElementById('checkout-submit').submit()" class="btn btn-secondary btn-sm">Place Order</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="small-only">
                            <div style="border:1px solid black;padding:10px" class="col-md-4">
                                <div><strong>Order Summary</strong><hr></div>
                                <table>
                                    <tr>
                                    <span class="checkout-title"><%=product.getTitle()%>></span>&nbsp;
                                    <span class="checkout-price"><%=product.getPrice()%></span>
                                    <br/>
                                    </tr>
                                </table>
                                <hr/>
                                <span>Order Total: <span class="checkout-price"><%=product.getPrice()%></span></span><br/>
                                <div style="padding-top:2vh">
                                    <a href="index.jsp">
                                        <button class="btn btn-secondary btn-sm">Cancel</button>
                                    </a>
                                    <button class="btn btn-secondary btn-sm" onclick="document.getElementById('checkout-submit').submit()">Place Order</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-footer footer_div">
            <footer class="footer bg-mute mt-auto">
                <div class="text-center">Copyright &copy; Seviss 2019</div>
            </footer>
        </div>
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
