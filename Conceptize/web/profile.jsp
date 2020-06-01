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
        <title>Conceptize | User Profile</title>
        <link rel="icon" href="./WebsiteUsage/logo.svg" type="image/png">
        <form id="goto-product-submit" action="ProductServlet" method="post">
            <input hidden name="action" value="product">
            <input hidden id="pid-input" name="pid" value="0">
        </form>
        <form id="goto-product-edit" action="ProductServlet" method="post">
            <input hidden name="action" value="product-edit">
            <input hidden id="pid-input2" name="pid" value="0">
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
                                <div class="input-group-append">
                                    <button onclick="searchProduct()" class="btn btn-info" type="button"><i class="fas fa-search"></i></button>
                                </div>
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
                <%User profileUser = User.getUser(request.getParameter("uid"));%>
                <div class="container" style="padding: 20px;">
                    <div style="text-align:center">
                        <%if (profileUser.getPicid() != null) {%>
                        <div class="pfp" style="background-image: url(<%=profileUser.getPicid()%>);" id="img"></div>
                        <%} else {%>
                        <div class="pfp" style="background-image: url(http://s3.amazonaws.com/37assets/svn/765-default-avatar.png);" id="img"></div>
                        <%}%>
                        <br><h1><%=profileUser.getUid()%></h1>
                        Member since: <%=profileUser.getRegdate()%>
                    </div>
                </div>
                <div style="padding: 20px"></div>
                <div id="profile-info" class="container" >
                    <div class="row">
                        <button onclick="profileSwitch(0);" style="width:50%;" type="button" class="btn btn-secondary">About</button>
                        <button onclick="profileSwitch(1);" style="width:50%;" type="button" class="btn btn-secondary">Products</button>
                    </div>
                    <div style="background-color:#eeeeee;" class="row">
                        <div class="col-12">
                            <div>Name</div>
                            <%if (profileUser.getName() != null) {%>
                            <textarea readonly style="width:100%;" type="text"><%=profileUser.getName()%></textarea>
                            <%} else {%>
                            <textarea readonly style="width:100%;" type="text"></textarea>
                            <%}%>
                        </div>
                    </div>
                    <div style="background-color:#eeeeee;" class="row">
                        <div class="col-12">
                            <div>About</div>
                            <%if (profileUser.getAbout() != null) {%>
                            <textarea readonly style="width:100%;" type="text"><%=profileUser.getAbout()%></textarea>
                            <%} else {%>
                            <textarea readonly style="width:100%;" type="text"></textarea>
                            <%}%>
                        </div>
                    </div>
                    <div style="background-color:#eeeeee;" class="row">
                        <div class="col-12">
                            <div>Interests</div>
                            <%if (profileUser.getInterests() != null) {%>
                            <textarea readonly style="width:100%;" type="text"><%=profileUser.getInterests()%></textarea>
                            <%} else {%>
                            <textarea readonly style="width:100%;" type="text"></textarea>
                            <%}%>
                        </div>
                    </div>
                    <div class="row"></div>
                </div>
                <div id="profile-products" class="container">
                    <div class="row">
                        <button onclick="profileSwitch(0);" style="width:50%;" type="button" class="btn btn-secondary">About</button>
                        <button onclick="profileSwitch(1);" style="width:50%;" type="button" class="btn btn-secondary">Products</button>
                    </div>
                    <% 
                        ArrayList<ArrayList<Product>> products = profileUser.getProducts();
                        pageContext.setAttribute("products", products);
                    %>
                        <% if (products != null) {%>
                            <c:forEach items="${products}" var="prods">
                                <div style="background-color:#eeeeee;" class="row">
                                    <div class="col-6">
                                        <% if (user.getUid().equals(profileUser.getUid())) {%>
                                       <div style="cursor:pointer;" onclick="loadEditProductPage('${prods.get(0).getPid()}')" class="container">
                                        <%} else {%>
                                        <div style="cursor:pointer;" onclick="loadProductPage('${prods.get(0).getPid()}')" class="container">
                                        <%}%>
                                           <div class="row">
                                               <img class="checkout-pic" src="${prods.get(0).getImg()}"/>
                                               <div class="profile-product-text">${prods.get(0).getTitle()}</div>
                                           </div>
                                       </div>
                                   </div>
                                   <c:if test="${prods.get(1) != null}">
                                        <div class="col-6">
                                            
                                        <% if (user.getUid().equals(profileUser.getUid())) {%>
                                       <div style="cursor:pointer;" onclick="loadEditProductPage('${prods.get(1).getPid()}')" class="container">
                                        <%} else {%>
                                        <div style="cursor:pointer;" onclick="loadProductPage('${prods.get(1).getPid()}')" class="container">
                                        <%}%>
                                                
                                                <div class="row">
                                                    <img class="checkout-pic" src="${prods.get(1).getImg()}"/>
                                                    <div class="profile-product-text">${prods.get(1).getTitle()}</div>
                                                </div>
                                            </div>
                                        </div>   
                                   </c:if>
                                </div>
                            </c:forEach>
                        <%}%>
                    <div class="row" style="padding-bottom: 50px"></div>
                </div>
            </div>

            <div class="page-footer footer_div">
                <footer class="footer bg-mute mt-auto">
                    <div class="text-center">Copyright &copy; Seviss 2019</div>
                </footer>
            </div>
        <script>
            var input = document.getElementById("search-bar");
            input.addEventListener("keyup", function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    document.getElementById("search-btn").click();
                }
            });
        </script>                    
        </div>
    </body>
</html>
