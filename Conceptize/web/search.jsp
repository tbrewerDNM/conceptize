<%@page import="java.util.ArrayList"%>
<%@page import="beans.Product"%>
<%@page import="beans.User"%>
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
        <title>Conceptize | Search</title>
        <link rel="icon" href="./WebsiteUsage/logo.svg" type="image/png">
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
                            <%user = (User) User.getUser(session.getAttribute("LOGIN_USER").toString());%>
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
            <div class="container" style="background-color:white;border:1px solid lightgray;padding-bottom:0px">
                <div class="row" style="padding-top:10px;padding-bottom:10px;padding-left:5px;border-bottom:1px solid lightgray">Showing results for&nbsp;<span id="search-term" class="text-danger">"<%=request.getParameter("text")%>"</span>&nbsp; and category &nbsp;<span id="cat-term" class="text-danger">"<%=Product.cat2str(request.getParameter("cat"))%>"</span></div>
                <div class="row" style="padding-bottom:20px; padding-top:10px">
                    <div class="col-3 col-sm-3 col-md-2 col-lg-2 col-xl-2" style="border-right:2px solid lightgray;">
                        <div class="search-cats">
                            <div style="padding-top:20px">
                                <h5>Categories</h5><hr>
                            </div>
                            <div>
                                <ul class="temp" id="category-link">
                                    <li style="cursor:pointer;" onclick="searchProd('', '7')"><span>All</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '1')"><span>Design</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '2')"><span>Digital Marketing</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '3')"><span>Original Characters</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '4')"><span>Writing</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '5')"><span>Inventions</span></li>
                                    <li style="cursor:pointer;" onclick="searchProd('', '6')"><span>Music</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-9 col-sm-9 col-md-10 col-lg-10 col-xl-10 medium-only">
                        <table>
                            <tr>
                            <div id="search-products-container" class="container">
                                <%
                                    ArrayList<ArrayList<Product>> products = Product.searchDoubles(request.getParameter("text"), request.getParameter("cat"));
                                    ArrayList<Product> mprods = Product.search(request.getParameter("text"), request.getParameter("cat"));
                                    //ArrayList<ArrayList<Product>> products = Product.searchDoubles("neptune","7");
                                    pageContext.setAttribute("products", products);
                                    pageContext.setAttribute("mprods", mprods);
                                %>
                                <c:forEach items="${products}" var="prods">
                                    <div class="row">
                                        <div class="text-center col-md-3 col-sm-6">
                                            <img style="cursor:pointer;" onclick="loadProductPage(${prods.get(0).getPid()})" class="search-img" src="${prods.get(0).getImg()}" style="border-radius:10px;"/>
                                        </div>
                                        <div class="col-md-3 col-sm-6 checkout-product-text">
                                            <strong>${prods.get(0).getTitle()}</strong><br>
                                            ${prods.get(0).getPrice()} | By <a href="#" onclick="loadProfilePage('${prods.get(0).getUid()}')">${prods.get(0).getUid()}</a>
                                        </div>
                                        <c:if test="${prods.get(1) != null}">
                                            <div class="col-md-3 col-sm-6">
                                                <div class="text-center medium-only">
                                                    <img style="cursor:pointer;" onclick="loadProductPage(${prods.get(1).getPid()})" class="search-img " src="${prods.get(1).getImg()}" style="border-radius:10px;"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3 col-sm-6 checkout-product-text">
                                                <div class="medium-only">
                                                    <strong>${prods.get(1).getTitle()}</strong><br>
                                                    <span>${prods.get(1).getPrice()} | By <a href="#" onclick="loadProfilePage('${prods.get(1).getUid()}')">${prods.get(1).getUid()}</a></span>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${prods.get(1) == null}">
                                            <div style="visibility:none;" class="col-md-3 col-sm-6"}>
                                                <div class="medium-only">
                                                    <img style="visibility:none;" class="checkout-pic" src="" style="border-radius:10px;"/>
                                                </div>
                                            </div>
                                            <div style="visibility:none;" class="col-md-3 col-sm-6 checkout-product-text">
                                                <div style="visibility:none;" class="medium-only">
                                                    <span style="visibility:none;"><strong></strong><br></span>
                                                    <span style="visibility:none;"><a href="#"></a></span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                            </tr>
                        </table>
                    </div>
                    <div class="col-9 col-sm-9 col-md-10 col-lg-10 col-xl-10 small-only">
                        <table>
                            <tr>
                            <div id="search-products-container" class="container">
                                <c:forEach items="${mprods}" var="prod">
                                    <div class="row">
                                        <div class="col-md-3 col-sm-6">
                                            <img style="cursor:pointer;" onclick="loadProductPage(${prod.getPid()})" class="checkout-pic" src="${prod.getImg()}" style="border-radius:10px;"/>
                                        </div>
                                        <div class="col-md-3 col-sm-6 checkout-product-text">
                                            <strong>${prod.getTitle()}</strong><br>
                                            ${prod.getPrice()} | By <a href="#">${prod.getUid()}</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            </tr>
                        </table>
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
