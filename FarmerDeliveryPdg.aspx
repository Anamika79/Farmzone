<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FarmerDeliveryPdg.aspx.vb" Inherits="FarmZone.FarmerDeliveryPdg" %>

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

    <title>Farm Zone Orders</title>


    <!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/dashboard.css" rel="stylesheet" />
    <link href="css/select2.css" rel="stylesheet" />
    <link href="css/select2-bootstrap-5-theme.css" rel="stylesheet" />
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
      .select2-selection__rendered {
            line-height: 36px !important;
        }
        .select2-container .select2-selection--single {
            height: 36px !important;
        }
    .modal-full {
    min-width: 60%;
    margin: auto;
    margin-top: 10px;
    height: 100%;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="#">Farm Zone</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search"/>
  <div class="navbar-nav">
    <div class="nav-item text-nowrap">
      <a class="nav-link px-3" href="Default.aspx">Sign out</a>
    </div>
  </div>
</header>

<div class="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
      <div class="position-sticky pt-3">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="FarmerHome.aspx">
              <span data-feather="home"></span>
              Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#">
              <span data-feather="file"></span>
              Orders
              &nbsp;&nbsp;<span id="spnDeliveryPdg" class="start-100 translate-middle badge rounded-pill bg-danger">4</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="FarmerProducts.aspx">
              <span data-feather="shopping-cart"></span>
              Stocks
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span data-feather="users"></span>
              Customers
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span data-feather="bar-chart-2"></span>
              Reports
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <span data-feather="layers"></span>
              Product Request
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h4">Your pending delivery details</h1>
      </div>
        <div class="card">
  <div class="card-header">
    Invoices
  </div>
  <div class="card-body">
    <div class="table-responsive">
        <table id="tblPendingInvoices" class="table table-striped table-sm">
          <thead>
            <tr style="text-align:center;">
              <th scope="col">Invoice No</th>
              <th scope="col">Date Of Invoice</th>
              <th scope="col">Delivery To</th>
                <th scope="col">Delivery Address</th>
              <th scope="col">Amount</th>
              <th scope="col">View</th>
              <th scope="col">Delivery</th>
            </tr>
          </thead>
          <tbody>
            
          </tbody>
        </table>
      </div>
  </div>
</div>
    </main>
  </div>
</div>

      
<%-- Modal for PDF--%>
<div class="modal fade" id="ModalForPDF" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-full">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Invoice</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div id="divPdf" style="height: 650px; width: 100%;"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<%--End of Modal for PDF--%>

    </form>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/feather.min.js"></script>
    <script src="js/dashboard.js"></script>
    <script src="js/apexcharts.js"></script>
    <script src="js/select2.full.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script src="js/pdfobject.js"></script>
    <script src="js/fzone.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            loadpendinginvoicestodelivery();
            $('.select2class').select2({
                tags: "true",
                dropdownParent: $('.modal')
            });
            var userid = readCookie('farmzoneuserid');
            var pdgcount = farmerloaddeliverypendingcount(userid);
            if (pdgcount != '0') {
                $('#spnDeliveryPdg').html(pdgcount);
            }
        });
    </script>
</body>
</html>