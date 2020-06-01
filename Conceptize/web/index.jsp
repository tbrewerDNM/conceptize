<%@page import="java.util.ArrayList"%>
<%@page import="beans.Product"%>
<%@page import="beans.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>Conceptize</title>
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
            <div class="container-fluid" style="height:auto">
                <div class="row" style="padding-bottom:5;">
                    <div class="container" id="home-header" style="width:100%">
                        <nav class="navbar-header">
                            <a class="navbar-brand" href="index.jsp"><img src="./WebsiteUsage/logo.svg"/><span id="brand">onceptize</span></a>
                                <%User user = null;%>
                                <%if (session.getAttribute("LOGIN_USER") != null) {%>
                                <%user = User.getUser(session.getAttribute("LOGIN_USER").toString());%>
                            <span class="dropdown"><a href="#" class="dropdown-toggle" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-portrait"></i> <%=user.toString()%> <b class="caret"></b></a>
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
                        </nav>
                        <div class="jumbotron">
                            <div class="row">
                                <div class="col-xl-2 col-lg-2 col-md-2"></div>
                                <h1 style="font-weight:700" class="col-xl-6 col-lg-6 col-md-8">I N N O V A T I O N<br> <span style="font-weight:200">Just one click away</span></h1>
                            </div>
                            <div class="row">
                                <div class="col-xl-2 col-lg-2 col-md-2"></div>
                                <div class="input-group col-xl-6 col-lg-6 col-md-8">
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
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="container">
                        <div style="position:relative;left:10px;padding-bottom:10px; font-weight:bold"><h3>Recommended</h3><h6 style="color:gray;padding-top:0px">Based on recent searches</h6></div>
                        <div style="width:100%;height: 37vh;" id="demo" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ul hidden class="carousel-indicators">
                                <li  data-target="#demo" data-slide-to="0" class="active"></li>
                                <li data-target="#demo" data-slide-to="1"></li>
                                <li data-target="#demo" data-slide-to="2"></li>
                            </ul>
                            <!-- The slideshow -->
                            <div class="carousel-inner">
                                <%ArrayList<Product> prods = Product.getRandomProducts("3");%>
                                <div class="carousel-item active">
                                    <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                        <img onclick="loadProductPage(<%=prods.get(0).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(0).getImg()%>" alt="tmp">
                                        <div class="card-body">
                                            <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(0).getTitle()%><hr></h5>
                                            <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(0).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(0).getPrice()%></span></p>
                                        </div>
                                    </div>
                                    <span class="medium-only">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(1).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(1).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(1).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(1).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(1).getPrice()%></span></p>
                                            </div>
                                        </div>
                                    </span>
                                    <span class="large-only">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(2).getPid()%>)" class="embed-responsive-item card-img-top carousel-img" src="<%=prods.get(2).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(2).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(2).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(2).getPrice()%></span></p>
                                            </div>
                                        </div>
                                    </span>
                                </div>

                                <c:forEach var = "i" begin = "1" end = "2">
                                    <%prods = Product.getRandomProducts("3");%>
                                    <div class="carousel-item">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(0).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(0).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(0).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(0).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(0).getPrice()%></span></p>
                                            </div>
                                        </div>
                                        <span class="medium-only">
                                            <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                                <img onclick="loadProductPage(<%=prods.get(1).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(1).getImg()%>" alt="tmp">
                                                <div class="card-body">
                                                    <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(1).getTitle()%><hr></h5>
                                                    <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(1).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(1).getPrice()%></span></p>
                                                </div>
                                            </div>
                                        </span>
                                        <span class="large-only">
                                            <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                                <img onclick="loadProductPage(<%=prods.get(0).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(2).getImg()%>" alt="tmp">
                                                <div class="card-body">
                                                    <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(2).getTitle()%><hr></h5>
                                                    <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(2).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(2).getPrice()%></span></p>
                                                </div>
                                            </div>
                                        </span>
                                    </div>
                                </c:forEach>

                                <!-- Left and right controls -->
                                <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                    <span  class="carousel-control-prev-icon"></span>
                                </a>
                                <a class="carousel-control-next" href="#demo" data-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </a>
                            </div>
                        </div>
                        <div style="position:relative;left:10px;padding-top:20px;padding-bottom:10px; font-weight:bold"><h3>Hot <i class="fas fa-fire"></i></h3><h6 style="color:gray;padding-top:0px">Based on trending searches</h6></div>
                        <div style="width:100%;height:37vh;" id="demo2" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                            <ul hidden class="carousel-indicators">
                                <li data-target="#demo2" data-slide-to="0" class="active"></li>
                                <li data-target="#demo2" data-slide-to="1"></li>
                                <li data-target="#demo2" data-slide-to="2"></li>
                            </ul>

                            <!-- The slideshow -->
                            <div class="carousel-inner">
                                <%prods = Product.getRandomProducts("3");%>
                                <div class="carousel-item active">
                                    <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                        <img onclick="loadProductPage(<%=prods.get(0).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(0).getImg()%>" alt="tmp">
                                        <div class="card-body">
                                            <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(0).getTitle()%><hr></h5>
                                            <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(0).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(0).getPrice()%></span></p>
                                        </div>
                                    </div>
                                    <span class="medium-only">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(1).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(1).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(1).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(1).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(1).getPrice()%></span></p>
                                            </div>
                                        </div>
                                    </span>
                                    <span class="large-only">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(2).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(2).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(2).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(2).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(2).getPrice()%></span></p>
                                            </div>
                                        </div>
                                    </span>
                                </div>

                                <c:forEach var = "i" begin = "1" end = "2">
                                    <%prods = Product.getRandomProducts("3");%>
                                    <div class="carousel-item">
                                        <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                            <img onclick="loadProductPage(<%=prods.get(0).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(0).getImg()%>" alt="tmp">
                                            <div class="card-body">
                                                <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(0).getTitle()%><hr></h5>
                                                <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(0).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(0).getPrice()%></span></p>
                                            </div>
                                        </div>
                                        <span class="medium-only">
                                            <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                                <img onclick="loadProductPage(<%=prods.get(1).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(1).getImg()%>" alt="tmp">
                                                <div class="card-body">
                                                    <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(1).getTitle()%><hr></h5>
                                                    <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(1).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(1).getPrice()%></span></p>
                                                </div>
                                            </div>
                                        </span>
                                        <span class="large-only">
                                            <div class="card" style="cursor:pointer;width:200px; height:250px; overflow:hidden">
                                                <img onclick="loadProductPage(<%=prods.get(2).getPid()%>)" class="card-img-top carousel-img" src="<%=prods.get(2).getImg()%>" alt="tmp">
                                                <div class="card-body">
                                                    <h5 class="card-title" style="font-weight:400; padding-left: 10px;width:75%;"><%=prods.get(2).getTitle()%><hr></h5>
                                                    <p class="card-text" style="font-weight:300; padding-top:none"><%=prods.get(2).getShortDesc()%><span style="font-weight:500"> Price: <%=prods.get(2).getPrice()%></span></p>
                                                </div>
                                            </div>
                                        </span>
                                    </div>
                                </c:forEach> 

                                <!-- Left and right controls -->
                                <a class="carousel-control-prev" href="#demo2" data-slide="prev">
                                    <span  class="carousel-control-prev-icon"></span>
                                </a>
                                <a class="carousel-control-next" href="#demo2" data-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="container" id="home-content">
                        <div class="container-fluid">
                            <div style="position:relative;left:10px;padding-top:5px;padding-bottom:10px; font-weight:bold"><h3>Explore by Category</h3></div>
                            <div class="card-deck">
                                <div class="card home-card" style="cursor:pointer;padding-top:10px;left:0px;background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '1')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/design.png" alt="design logo"/>
                                        <div class="home-card-text">Design</div>
                                    </div>
                                </div>
                                <div class="card home-card" style="cursor:pointer;padding-top:10px;left:0px;background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '2')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/digital_marketing.png" alt="digital marketing logo"/>
                                        <div class="home-card-text">Digital Marketing</div>
                                    </div>
                                </div>
                                <div class="card home-card" style="cursor:pointer;padding-top:10px;left:0px;background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '3')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/character_design.png" alt="original characters logo"/>
                                        <div class="home-card-text">Original Characters</div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-deck">
                                <div class="card home-card" style="cursor:pointer;padding-top:20px;left:0px; background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '4')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/writing.png" alt="writing logo"/>
                                        <div class="home-card-text">Writing</div>
                                    </div>
                                </div>
                                <div class="card home-card" style="cursor:pointer;padding-top:20px;left:0px;background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '5')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/inventions.png" alt="inventions logo"/>
                                        <div class="home-card-text">Inventions</div>
                                    </div>
                                </div>
                                <div class="card home-card" style="cursor:pointer;padding-top:20px;left:0px;background-color:transparent">
                                    <div style="cursor:pointer;" onclick="searchProd('', '6')" class="card-body text-center">
                                        <img class="home-card-img" src="./WebsiteUsage/music.png" alt="music logo"/>
                                        <div class="home-card-text">Music</div>
                                    </div>
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
