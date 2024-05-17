﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FarmerHome.aspx.vb" Inherits="FarmZone.FarmerHome" %>

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

    <title>Farm Zone Farmer's Panel</title>


    <!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet"/>
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
            <a class="nav-link" href="FarmerDeliveryPdg.aspx">
              <span data-feather="file"></span>
              Orders
              &nbsp;&nbsp;<span id="spnDeliveryPdg" class="start-100 translate-middle badge rounded-pill bg-danger"></span>
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

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h4">Farmers' Dashboard</h1>
      </div>
        <div class="row row-cols-1 row-cols-md-4 g-4">
            <div class="col">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-header">Delivery</div>
                    <div class="card-body">
                        <h5 class="card-title">83</h5>
                        <p class="card-text">Total orders delivered as of now.</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-white bg-success mb-3">
                    <div class="card-header">Orders</div>
                    <div class="card-body">
                        <h5 class="card-title">4</h5>
                        <p class="card-text">Total orders pending with you to deliver.</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-white bg-danger mb-3">
                    <div class="card-header">Products</div>
                    <div class="card-body">
                        <h5 class="card-title">6</h5>
                        <p class="card-text">Total products in your stock ready for delivery</p>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card text-dark bg-warning mb-3">
                    <div class="card-header">Customers</div>
                    <div class="card-body">
                        <h5 class="card-title">14</h5>
                        <p class="card-text">Total Customers in association with you.</p>
                    </div>
                </div>
            </div>
        </div>
      <div class="row">
          <div class="col-lg-6 col-sm-12">
              <div class="card border-primary mb-3">
                  <div class="card-header">Month-wise Invoices</div>
                  <div class="card-body text-primary">
                      <div id="divSaleChart"></div>
                  </div>
              </div>
          </div>
          <div class="col-lg-6 col-sm-12">
              <div class="card border-danger mb-3">
                  <div class="card-header">Product-wise Sale</div>
                  <div class="card-body text-danger">
                      <div id="divProductChart"></div>
                  </div>
              </div>
          </div>
      </div>
    <div class="row">
        <div class="col-12 col-md-6 col-lg-6 mt-3">
                        <div class="card bg-info">                            
                            <div class="card-content">
                                <div class="card-body p-4">   
                                    <div class="d-md-flex">
                                        <div class="my-auto">
                                            <img src="img/mosttrending.png" alt="author" width="48" class="my-auto"/>
                                        </div>
                                        <div class="content px-md-3 my-3 my-md-0">                                           
                                            <span class="mb-0 font-w-600 h5">Most trending product in Farm Zone</span><br/>
                                            <p class="mb-0 font-w-500 tx-s-12">Coconut : Out of 1200 Kg, 900 Kg has been sold out as of now. (83%)</p>                                                    
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-6 mt-3">
                        <div class="card bg-secondary">                            
                            <div class="card-content">
                                <div class="card-body p-4">   
                                    <div class="d-md-flex">
                                        <div class="my-auto">
                                            <img src="img/leasttrending.png" alt="author" width="48"  class="my-auto"/>
                                        </div>
                                        <div class="content px-md-3 my-3 my-md-0 text-white">                                           
                                            <span class="mb-0 font-w-600 h5">Least trending product in Farm Zone</span><br/>
                                            <p class="mb-0 font-w-500 tx-s-12">Tara Root:  Out of 200 Kg, 80 Kg has been sold out as of now. (48%)</p>                                                    

                                        </div>
                                        
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
    </div>
      
    </main>
  </div>
</div>



        <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/feather.min.js"></script>
        <script src="js/dashboard.js"></script>
        <script src="js/apexcharts.js"></script>
        <script src="js/fzone.js"></script>
    </form>

    <script type="text/javascript">
        
        $(document).ready(function () {
            var userid = readCookie('farmzoneuserid');
            var pdgcount = farmerloaddeliverypendingcount(userid);
            if (pdgcount != '0') {
                $('#spnDeliveryPdg').html(pdgcount);
            }
            loadsaleschart();
            loadproductwisechart();
        });
        
    </script>
</body>
</html>