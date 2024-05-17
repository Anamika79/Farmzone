<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FarmerProducts.aspx.vb" Inherits="FarmZone.FarmerProducts" %>

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

    <title>Farm Zone Stock</title>


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
            <a class="nav-link" href="FarmerDeliveryPdg.aspx">
              <span data-feather="file"></span>
              Orders
              &nbsp;&nbsp;<span id="spnDeliveryPdg" class="start-100 translate-middle badge rounded-pill bg-danger"></span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#">
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
        <h1 class="h4">Your stock details</h1>
        <a href="#" class="btn btn-primary" onclick="farmerloadmodalforaddnewproduct(); return false;"><span data-feather="plus" style="color:white;"></span> &nbsp;Add new Product</a>
      </div>
        <div id="divProducts" runat="server" class="row row-cols-1 row-cols-md-4 g-4 p-4">
            
        </div>
    </main>
  </div>
</div>



<!-- start divEditProduct Modal -->
<div class="modal fade" id="divEditProductModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Edit Product</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                <p>You can not change Rate or decrease quantity as this product is already published.</p>
                <p>You can increase the quantity and/or change remarks and/or change image.</p>
            </div>
            <label id="lblActualQty" style="display:none;">0</label>
            <label id="lblStock" style="display:none;">0</label>
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group">
                        <label>Product:</label><input id="txtProductToEdit" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group required">
                        <label>UOM:</label><input id="txtUOMToEdit" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group required">
                        <label>Rate/Unit:</label><input id="txtRateToEdit" type="text" class="form-control" readonly="readonly" />
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Quantity:</label><input id="txtQtyToEdit" class="form-control" onkeypress="return isNumberKeyWithTwoDigits(event,this)" />
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="form-group required">
                        <label>Remarks:</label><input id="txtRemarksToEdit" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <label for="formFileToEdit" class="form-label">Select Image (Png format, less than 1 Mb)</label>
                    <input class="form-control" type="file" id="formFileToEdit" />
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <button id="btnUpdateProduct" type="button" class="btn btn-primary" style="float: right;" onclick="farmerupdateproduct(); return false;">Update Product</button>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
<!-- end divEditProduct Modal -->   
<!-- start divAddProductModal Modal -->
<div class="modal fade" id="divAddProductModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Add new Product</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Select Product to add your stock. If your product is not available, please click 'Product Request' link to send a request to Administrator.
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group">
                        <label>Select Product:</label><asp:DropDownList ID="cmbProduct" CssClass="select2class" runat="server" Width="100%"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group required">
                        <label>UOM:</label><asp:DropDownList ID="cmbUOM" CssClass="select2class"  runat="server" Width="100%"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="form-group required">
                        <label>Rate/Unit:</label><input id="txtRate" class="form-control" onkeypress="return isNumberKeyWithTwoDigits(event,this)" />
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Quantity:</label><input id="txtQty" class="form-control" onkeypress="return isNumberKeyWithTwoDigits(event,this)" />
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="form-group required">
                        <label>Remarks:</label><input id="txtRemarks" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <label for="formFile" class="form-label">Select Image (Png format, less than 1 Mb)</label>
                    <input class="form-control" type="file" id="formFile" />
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <button id="btnAddProduct" type="button" class="btn btn-primary" style="float: right;" onclick="farmeraddproduct(); return false;">Add Product</button>
                </div>
            </div>
        </div>
    </div>
  </div>
</div>
<!-- end divAddProductModal Modal -->        


    </form>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/feather.min.js"></script>
    <script src="js/dashboard.js"></script>
    <script src="js/apexcharts.js"></script>
    <script src="js/select2.full.min.js"></script>
    <script src="js/sweetalert2.min.js"></script>
    <script src="js/fzone.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
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
        $('#cmbProduct').on('select2:select', function (e) {
            if ($('#cmbProduct').val() != '1') {
                var isitavailable = checkavailabilityofproduct($('#cmbProduct').val());
                if (isitavailable != '0') {
                    Swal.fire({
                        icon: 'error',
                        title: 'Farm Zone',
                        text: 'This Product is already available. \n Please click "Edit" link to edit.....!!!'
                    });
                    event.returnValue = false;
                    event.cancel = true;
                    return false;
                }
            }
        });
    </script>
</body>
</html>