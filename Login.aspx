<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="FarmZone.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content="Farm Zone eCommerce application for Farmers to sell their products directly to Customers"/>
    <meta name="author" content="Anamika and friends"/>
    

    <link rel="apple-touch-icon" sizes="57x57" href="img/Favicon/apple-icon-57x57.png"/>
    <link rel="apple-touch-icon" sizes="60x60" href="img/Favicon/apple-icon-60x60.png"/>
    <link rel="apple-touch-icon" sizes="72x72" href="img/Favicon/apple-icon-72x72.png"/>
    <link rel="apple-touch-icon" sizes="76x76" href="img/Favicon/apple-icon-76x76.png"/>
    <link rel="apple-touch-icon" sizes="114x114" href="img/Favicon/apple-icon-114x114.png"/>
    <link rel="apple-touch-icon" sizes="120x120" href="img/Favicon/apple-icon-120x120.png"/>
    <link rel="apple-touch-icon" sizes="144x144" href="img/Favicon/apple-icon-144x144.png"/>
    <link rel="apple-touch-icon" sizes="152x152" href="img/Favicon/apple-icon-152x152.png"/>
    <link rel="apple-touch-icon" sizes="180x180" href="img/Favicon/apple-icon-180x180.png"/>
    <link rel="icon" type="image/png" sizes="192x192"  href="img/Favicon/android-icon-192x192.png"/>
    <link rel="icon" type="image/png" sizes="32x32" href="img/Favicon/favicon-32x32.png"/>
    <link rel="icon" type="image/png" sizes="96x96" href="img/Favicon/favicon-96x96.png"/>
    <link rel="icon" type="image/png" sizes="16x16" href="img/Favicon/favicon-16x16.png"/>
    <meta name="msapplication-TileColor" content="#ffffff"/>
    <meta name="msapplication-TileImage" content="/ms-icon-144x144.png"/>
    <meta name="theme-color" content="#ffffff"/>

    <title>Farm Zone Login</title>


    <!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/sweetalert2.min.css" rel="stylesheet" />
    <link href="css/signin.css" rel="stylesheet" />
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      .center {
        margin: auto;
        width: 100%;
        border: 2px solid #2a4679;
        padding: 5px;
        background-color:white;
        border-radius:10px;
        -webkit-filter: drop-shadow(5px 5px 5px #909090 );
        filter: drop-shadow(5px 5px 5px #909090);
        }
    </style>
    <script type = "text/javascript">
        function changeHashOnLoad() {
            window.location.href += "#";
            setTimeout("changeHashAgain()", "50");
            $('#q').focus();
        }

        function changeHashAgain() {
            window.location.href += "1";
        }

        var storedHash = window.location.hash;
        window.setInterval(function () {
            if (window.location.hash != storedHash) {
                window.location.hash = storedHash;
            }
        }, 50);
        
    </script>
</head>
<body class="text-center" onload="changeHashOnLoad();">
    <main class="form-signin">
  <form>
      <div class="center">
          <img class="mb-4" src="img/Logo.png" alt="" width="72" height="57"/>
    <h1 class="h3 mb-3 fw-normal">Farm Zone sign in</h1>
    <div class="form-floating" style="width:90%;margin-left:auto;margin-right:auto;">
      <input type="text" class="form-control" id="q" placeholder="your username"/>
      <label for="q">Username</label>
    </div>
    <div class="form-floating mt-3" style="width:90%;margin-left:auto;margin-right:auto;">
      <input type="password" class="form-control" id="r" placeholder="Password"/>
      <label for="r">Password</label>
    </div>

      <div class="row">
          <div class="col-6">
              <div class="checkbox mb-3">
                  <label>
                      <input id="remember_me" type="checkbox" value="remember-me" />
                      Remember me
                  </label>
              </div>
          </div>
          <div class="col-6">
              <a href="#" style="float: right;"  data-bs-toggle="modal" data-bs-target="#divForgetPW">Forget Password?</a>
          </div>
      </div>
    
    <a id="btnLogin" class="w-100 btn btn-lg btn-primary" href="#" onclick="login(); return false;">Sign in</a>
    <p class="text-center mt-4">Not a member? <a data-toggle="tab" href="#"  data-bs-toggle="modal" data-bs-target="#divRegisterModal">Register</a></p>
    <p class="mt-3 mb-3 text-muted">&copy; 2022 Farm Zone</p>
      </div>
<!-- start divForgetPW Modal -->
<div class="modal fade" id="divForgetPW" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Forgot your Password?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align:left;">
          <div class="row">
              <div class="mb-3">
                  <label for="txtUserNameForForgetPW" class="form-label">Enter your Username</label>
                  <input type="text" class="form-control" id="txtUserNameForForgetPW" />
              </div>
          </div>
          <div class="row">
              <div class="mb-3">
                  <label for="txtEmailForForgetPW" class="form-label">Enter your Email address</label>
                  <input type="email" class="form-control" id="txtEmailForForgetPW" aria-describedby="emailHelp" />
                  <div id="emailHelp" class="form-text"><span style="color:red;">*</span>&nbsp;We'll never share your email with anyone else.</div>
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="sendnewpasswordonforgotpassword(); return false;">Send me new password</button>
      </div>
    </div>
  </div>
</div>
<!-- end divCart Modal -->  
<!-- start divRegister Modal -->
<div class="modal fade" id="divRegisterModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">New to Farm Zone?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="row" style="text-align:left;">
              <div class="mb-2">
                  <label for="divrbs" class="form-label">User Role</label>
                  <div id="divrbs">
                      <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="rbUserRoleOptions" id="rbBuyer" value="4" />
                      <label class="form-check-label" for="rbBuyer">Buyer</label>
                  </div>
                  <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="rbUserRoleOptions" id="rbFarmer" value="3" />
                      <label class="form-check-label" for="rbFarmer">Farmer</label>
                  </div>
                  </div>
              </div>
              <hr />
              <div class="mb-2">
                  <label for="exampleInputEmail1" class="form-label">Enter your Email address</label>
                  <input type="email" class="form-control" id="txtEmailToRegister" />
              </div>
              <div class="mb-2">
                  <label for="txtUserName" class="form-label">Enter Username</label>
                  <input type="text" class="form-control" id="txtUserName" />
              </div>
              <div class="mb-2">
                  <label for="txtPW" class="form-label">Password</label>
                  <input type="password" class="form-control" id="txtPW" />
              </div>
              <div class="mb-2">
                  <label for="txtPWCfm" class="form-label">Confirm Password</label>
                  <input type="password" class="form-control" id="txtPWCfm" />
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="registeruser(); return false;">Register</button>
      </div>
    </div>
  </div>
</div>
<!-- end divRegister Modal -->
  </form>
</main>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/feather.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script src="js/fzone.js"></script>
    <script type="text/javascript">
        //this is to delete all the cache history
        history.pushState(null, document.title, location.href);
        history.back();
        history.forward();
        window.onpopstate = function () {
            history.go(1);
        };
        $(document).ready(function () {
            //if remember me checked earlier then the username and password retrieve from localstorage
            if (localStorage.chkbx && localStorage.chkbx != '') {
                $('#remember_me').attr('checked', 'checked');
                $('#q').val(localStorage.usrname);
                $('#r').val(localStorage.pass);
            } else {
                $('#remember_me').removeAttr('checked');
                $('#q').val('');
                $('#r').val('');
            }
        });
        $('#remember_me').click(function () {
            if ($('#remember_me').is(':checked')) {
                // save username and password
                localStorage.usrname = $('#q').val();
                localStorage.pass = $('#r').val();
                localStorage.chkbx = $('#remember_me').val();
            } else {
                localStorage.usrname = '';
                localStorage.pass = '';
                localStorage.chkbx = '';
            }
        });
        $('#q').keypress(function (e) {
            //if press Enter key from keyboard
            if (e.keyCode == 13) {
                e.preventDefault();
                $("#r").focus();
                event.returnValue = false;
                event.cancel = true;
                return false;
            }
        });
        $('#r').keypress(function (e) {
            //if press Enter key from keyboard perform btnLogin button press function
            if (e.keyCode == 13) {
                $("#btnLogin").click();
            }
        });
        $(document).on('show.bs.modal', '#divRegisterModal', function () {
            //when register modal pop up, all fields should be blank
            $('#rbBuyer').prop('checked', false);
            $('#rbFarmer').prop('checked', false);
            $('#txtEmailToRegister').val('');
            $('#txtUserName').val('');
            $('#txtPW').val('');
            $('#txtPWCfm').val('');
        })
    </script>

</body>
</html>
