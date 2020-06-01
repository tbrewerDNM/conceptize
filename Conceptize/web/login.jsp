<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="login.css">

    <title>Conceptize | Login</title>
    <link rel="icon" href="./WebsiteUsage/logo.png" type="image/png">

    <!-- CDN stuff for Bootstrap -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body class="theme-open-up">
    <div id="react_root">
        <div>
            <div class="base">
                <div></div>
                <div class="theme-open-up outer">
                    <div class="texture"></div>
                    <div class="login-outer">
                        <div class="login-box">
                            <div class="login-area">
                                <form class="form-lg" action="AuthServlet" method="post" onSubmit="return checkForm(this)">
                                    <input type="hidden" name="action" value="login">
                                    <header class="logo-area">
                                        <a class="logo-margins" href="index.jsp"><img src="./WebsiteUsage/logo.svg" alt="Logo"><span id="brand">onceptize</span></a>
                                    </header>
                                    <div class="form-vertical">
                                        <div>
                                            <div>
                                                <label for="username">
                                                    <div style="color:white">Username</div>
                                                    <div>
                                                        <input autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" required="" name="username" type="text" value="" id='username'>
                                                    </div>
                                                </label>
                                            </div>
                                            <div>
                                                <label for="password">
                                                    <div style="color:white">Password</div>
                                                    <div>
                                                        <input required="" name="password" type="password" value="" id='password'>
                                                    </div>
                                                </label>
                                            </div>
                                        </div>
                                        <p>
                                            <a style="color:cyan" class="create_link" href="register.jsp">Create Account</a>
                                        </p>
                                    </div>
                                    <footer class="login-btn-area">
                                        <div>
                                            <button type="submit" name="submit" class="btn btn-success login-btn">
                                                <span class="login-btn-text">Login</span>
                                            </button>
                                        </div>
                                    </footer>
                                    <div id="login-error">
                                        <b>${LOGIN_ERROR}</b>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
<script>
    function checkForm(form)
    {
        // regular expression to match only alphanumeric characters and spaces
        var re = /^[\w ]+$/;

        // validation fails if the input doesn't match our regular expression
        if (!re.test(form.username.value)) {
            alert("Error: username contains invalid characters!\nOnly alphanumeric characters are allowed.");
            form.username.focus();
            return false;
        } else if (!re.test(form.password.value)) {
            alert("Error: password contains invalid characters!\nOnly alphanumeric characters are allowed.");
            form.password.focus();
            return false;
        }

        // validation was successful
        return true;
    }
</script>

</html>
