<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="FarmZone._Default" %>

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

    <title>Farm Zone</title>


    <!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/sweetalert2.min.css" rel="stylesheet" />
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


    </style>

    
    <!-- Custom styles for this template -->
    <link href="css/product.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
    <header class="bd-header bg-dark py-3 d-flex align-items-stretch border-bottom border-dark sticky-top">
  <div class="container-fluid d-flex align-items-center">
    <h1 class="d-flex align-items-center fs-4 text-white mb-0">
      <img src="img/Logo.png" width="38" height="30" class="me-3" alt="Farm Zone"/>
      Farm zone

    </h1>
    <a href="#" class="ms-auto link-light"   data-bs-toggle="modal" data-bs-target="#divRegisterModal">Register</a>
  </div>
</header>
    <main>
        <div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
            <div class="col-md-12 p-lg-12 mx-auto my-1">
                <img src="img/Logo.png" height="60" class="me-3" alt="Farm Zone" />
                <h1 class="display-4 fw-normal">Farm Zone</h1>
                <p class="lead fw-normal">
                    Production of good quality product is a necessary condition but not a sufficient criterion for profitability. 
                    Most agricultural products go through several hands before reaching the consumer. 
                    As a result, costs involved in handling, storing, transporting, and distributing food products also increases.
                </p>
                <p class="lead fw-normal">We introducing 'Farm Zone' where both farmer and customer can interact directly without any middleman. </p>
                <a class="btn btn-outline-secondary" href="Login.aspx#">Login to start your business</a>&nbsp;&nbsp;
                <a class="btn btn-outline-primary" href="#"   data-bs-toggle="modal" data-bs-target="#divRegisterModal">New to Farm Zone? Click here to Register</a>
            </div>

        </div>

        <hr class="my-1" />
        <div id="DivContainer" runat="server" class="row row-cols-1 row-cols-md-4 g-4 p-4">
            
        </div>
        <div class="row" data-masonry='{"percentPosition": true }'>
        </div>

    </main>

    <footer class="container py-5">
        <div class="row">
            <div class="col-12 col-md" style="text-align:center;">
                <p class="mt-5 mb-3 text-muted">&copy; 2022 Farm Zone</p>
            </div>
        </div>
    </footer>
<!-- start divRegister Modal -->
<div class="modal fade" id="divRegisterModal">
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
                  <label for="txtEmailToRegister" class="form-label">Enter your Email address</label>
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
</form>
<!-- end divRegister Modal -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/masonry.pkgd.min.js"></script>
    <script src="js/feather.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script src="js/fzone.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            
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
