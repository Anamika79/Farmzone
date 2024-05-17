<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home.aspx.vb" Inherits="FarmZone.Home" %>

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

    <title>Farm Zone Home</title>


    <!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="css/sweetalert2.min.css" rel="stylesheet" />
<link href="css/dashboard.css" rel="stylesheet" />
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
      .size-28{
        width: 28px;
        height: 28px;
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
            <a class="nav-link active" aria-current="page" href="#">
              <span data-feather="home"></span>
              Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="BuyerDeliveryDue.aspx">
              <span data-feather="layers"></span>
              Delivery Due
                &nbsp;&nbsp;<span id="spnDeliveryDue" class="start-100 translate-middle badge rounded-pill bg-danger"></span>
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Click any product to see details</h1>
           <div class="btn-toolbar mb-2 mb-md-0">
          <div class="btn-group me-2">
              <button type="button" class="btn btn-primary position-relative" data-bs-toggle="modal" data-bs-target="#divCart">
  <span data-feather="shopping-cart"></span>
  <span id="spnCartCounter" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"></span>
</button>
          </div>
        </div>
      </div>

      <div class="accordion" id="accordionExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        Available Products
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            <div class="container mt-3">
                <div id="DivContainer" runat="server" class="row">
                    
                </div>
                
            </div>
        </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button id="btnProductDetails" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        Product Details
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <h2 id="hProductHeading">Details</h2>
      <div class="table-responsive">
        <table id="tblProductDetails" class="table table-striped">
          <thead>
            <tr style="text-align:center;">
              <th scope="col">Farmer</th>
              <th scope="col">Quantity</th>
              <th scope="col">Rate/Unit</th>
              <th scope="col">Remarks</th>
              <th scope="col">Image</th>
              <th scope="col">Add to Cart</th>

            </tr>
          </thead>
          <tbody>
            
          </tbody>
        </table>
      </div>
      </div>
    </div>
  </div>
  
</div>

      
    </main>
  </div>
</div>

<!-- start divCart Modal -->
<div class="modal fade" id="divCart" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Added Products</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="row">
              <div class="col-12">
                  <table id="tblAddedToCartProducts" class="table table-striped">
                      <thead>
                          <tr style="text-align: center;">
                              <th scope="col">S.NO</th>
                              <th scope="col">ITEM</th>
                              <th scope="col">QUANTITY</th>
                              <th scope="col">RATE/UNIT</th>
                              <th scope="col">TOTAL</th>
                              <th scope="col">DEL</th>
                              <th scope="col" style="display:none;">StockId</th>
                          </tr>
                      </thead>
                      <tbody>
                      </tbody>
                      <tfoot>
                          <tr>
                              <th colspan="4" scope="col">GRAND TOTAL</th>
                              <th scope="col" style="text-align:right;"><label id="lblGTotal">0</label></th>
                              <th scope="col"></th>
                          </tr>
                      </tfoot>
                  </table>
              </div>
          </div>
          <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <label>Delivery To:</label><input id="txtDeliveryTo" type="text" class="form-control"/>
                    </div>
                </div>
            </div>
          <div class="row">
                <div class="col-lg-12">
                    <div class="form-group">
                        <label>Delivery Address:</label><input id="txtDeliveryAddress" type="text" class="form-control"/>
                    </div>
                </div>
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="buyerorderproducts(); return false;">Order</button>
      </div>
    </div>
  </div>
</div>
<!-- end divCart Modal -->
<!-- start divAddToCart Modal -->
<div class="modal fade" id="divAddToCartModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Add to Cart</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <label id="lblStockId" style="display:none;"></label>
          <div class="row" style="text-align:left;">
              <div class="mb-2">
                  <label for="txtProduct" class="form-label">Name of Product</label>
                  <input type="text" class="form-control" id="txtProduct" readonly="readonly"/>
              </div>
              <div class="mb-2">
                  <label for="txtUOM" class="form-label">Unit of Measurement</label>
                  <input type="text" class="form-control" id="txtUOM" readonly="readonly" />
              </div>
              <div class="mb-2">
                  <label for="txtAvailableQty" class="form-label">Availalbe Quantity</label>
                  <input type="text" class="form-control" id="txtAvailableQty" readonly="readonly" />
              </div>
              <div class="mb-2">
                  <label for="txtRate" class="form-label">Rate per Unit</label>
                  <input type="text" class="form-control" id="txtRate"  readonly="readonly"/>
              </div>
              <div class="mb-2">
                  <label for="txtRequiredQty" class="form-label">Required Quantity</label>
                  <input type="text" class="form-control" id="txtRequiredQty" onkeypress="return isNumberKeyWithTwoDigits(event,this)"/>
              </div>
              <div class="mb-2">
                  <label for="txtTotalAmount" class="form-label">Total Amount</label>
                  <input type="text" class="form-control" id="txtTotalAmount"  readonly="readonly"/>
              </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="addtocart(); return false;">Add to Cart</button>
      </div>
    </div>
  </div>
</div>
<!-- end divAddToCart Modal -->

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
        <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/feather.min.js"></script>
        <script src="js/sweetalert2.min.js"></script>
        <script src="js/dashboard.js"></script>
        <script src="js/pdfobject.js"></script>
        <script src="js/fzone.js"></script>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            
            var userid = readCookie('farmzoneuserid');
            var pdgcount = buyerloaddeliveryduecount(userid);
            if (pdgcount != '0') {
                $('#spnDeliveryDue').html(pdgcount);
            }
            $("#txtRequiredQty").keyup(function () {
                var qty = 0;
                if ($('#txtRequiredQty').val() == '') {
                    qty = 0;
                }
                else {
                    qty = $('#txtRequiredQty').val();
                }
                var rate = $('#txtRate').val();
                var totamt = parseFloat(qty) * parseFloat(rate);
                $('#txtTotalAmount').val(totamt.toFixed(2));
            });
        })
    </script>
    
</body>
</html>
