function createCookie(name, value, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = date.toGMTString();
    }
    else
        document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}
function deleteAllCookies() {
    var cookies = document.cookie.split(";");
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        eraseCookie(cookie);
    }
}
//end of cookies
function login() {
    if ($('#q').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Username...!!!'
        });
        return false;
    }
    if ($('#r').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Password...!!!'
        });
        return false;
    }
    $("body").css("cursor", "progress");
    var URL = "Json.aspx?Option=GetAuthentication&UserName=" + $("#q").val() + "&UserPW=" + escape($("#r").val());
    $.getJSON(URL, function (data) {
        var strresult = data.UserAuthenticationState;//the output of this query will be 'userid#userrole'
        var credentials = new Array();
        credentials = strresult.split('#');//the output will be splitted with #
        $("body").css("cursor", "default");
        if (credentials[0] === 'CONNECTION_PROBLEM') {
            Swal.fire({
                icon: 'info',
                title: 'Farm Zone',
                text: 'Connection Problem or Server down. Please try later..!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        else if (credentials[0] == '0') {//wrong username or password or both
            Swal.fire({
                icon: 'info',
                title: 'Farm Zone',
                text: 'Invalid Credentials. Please check...!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        else {
            createCookie('farmzoneuserid', '' + credentials[0] + '', 0);
            createCookie('farmzoneuserroleid', '' + credentials[1] + '', 0);
            var verno = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
            if (credentials[1] == '3') { //userrole-Farmer
                window.location.href = "FarmerHome.aspx?v=" + verno;
            }
            else if (credentials[1] == '4') { //userrole-Buyer
                window.location.href = "Home.aspx?v=" + verno;
            }
            else {// 2- Admin
                window.location.href = "AdminHome.aspx?v=" + verno;
            }
            
        }
    });
}
function isEmail(email) {
    //this function will check whether the given email id constructed with @ and .com etc
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
}
function checkuserexist(username) {
    //we should not allow two users with same username. so this function will check whether the given username is exist in database or not
    var value = $.ajax({
        url: "json.aspx?Option=CheckUserExist&UserName=" + username,
        async: false
    }).responseText;
    return value;
}
function registeruser() {
    //this function is used to register the user.
    //validations**************
    if ($('#rbBuyer').prop('checked') === false && $('#rbFarmer').prop('checked') === false) {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please select either Buyer or Farmer...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtEmailToRegister').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Email Id...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if (isEmail($('#txtEmailToRegister').val()) === false) {
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Please enter valid Email Id...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtUserName').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Username...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var userexist = checkuserexist($('#txtUserName').val());
    if (userexist != '0') { // if output is 0 then username not exist if 1 then username exist
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'This Username is already exist. Please enter a different Username...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtPW').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Password...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtPWCfm').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please re-enter Confirm Password...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtPW').val() != $('#txtPWCfm').val()) {
        //check if both pw value and cfm password value is equal or not
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Password and Confirm password are not matching. Please check...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    //end of validations****************************
    //declare a variable to store Userroleid
    var userroleid = 0;
    if ($('#rbBuyer').prop('checked') === true) {
        userroleid = 4;
    }
    else {
        userroleid = 3;
    }
    //to send the registration details through ajax web method we will create an object and put all the related fields inside the object....
    var obj = {};
    //Fields required are: UserRoleId, EmailId,UserName,Password
    obj.UserRoleId = userroleid;
    obj.EmailId = $('#txtEmailToRegister').val();
    obj.UserName = $('#txtUserName').val();
    obj.Password = $('#txtPW').val();
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/RegisterUser",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            $('#divRegisterModal').modal('hide');
            Swal.fire({
                icon: 'success',
                title: 'Farm Zone',
                text: 'Registration successfull. Please login...!!!'
            });
        },
        error: function (err) {
            alert(err.statusText)
        }
    });
}
function logout() {
    eraseCookie('farmzoneuserid');
    var verno = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    window.location.href = "Default.aspx?v=" + verno;
}
function loadproductdetailstoaddtocart(productid) {
    $('#tblProductDetails tbody').html('');
    var URL1 = "JSON.aspx?Option=LoadDetailsOfProductOfAllFarmersForSale&ProductId=" + productid;
    $.getJSON(URL1, function (data) {
        if (data.length > 0) {
            $.each(data, function () {
                $('#hProductHeading').html(this.ProductName);
                //                                                                                                      Farmer,                     AvailableQty,                     RatePerUnit,             UOM,                     FarmerRemarks,                                                                StockId,
                $('#tblProductDetails tbody').append('<tr style="text-align:center;vertical-align:middle;"><td>' + this.Farmer + '</td><td>' + this.AvailableQty + '</td><td>' + this.RatePerUnit + '/' + this.UOM + '</td><td>' + this.FarmerRemarks + '</td><td><img alt="Product" src="img/FarmerProducts/' + this.StockId + '.png" width="100" height="100"/></td><td><a href="#" onclick="showmodaltoaddtocart(' + this.StockId + '); return false;"><i class="size-28" data-feather="plus-circle"></i></a></td></tr>');
                feather.replace();
            });
        }
    });
    $("#collapseTwo").collapse("show");
}
function showmodaltoaddtocart(stockid) {
    $('#txtProduct').val('');
    $('#txtUOM').val('');
    $('#txtRate').val('');
    $('#txtAvailableQty').val('');
    $('#txtRequiredQty').val('');
    $('#txtTotalAmount').val('');
    $('#lblStockId').text(stockid);
    var URL = "JSON.aspx?Option=LoadFarmerProductDetailsForEdit&StockId=" + stockid;
    $.getJSON(URL, function (data) {
        if (data.length > 0) {
            $.each(data, function () {
                //ProductName, UOM, RatePerUnit, FarmerRemarks, AvailableQty
                $('#txtProduct').val(this.ProductName);
                $('#txtUOM').val(this.UOM);
                $('#txtRate').val(this.RatePerUnit);
                $('#txtAvailableQty').val(this.AvailableQty);
            });
            
        }
    });
    //$('#spnCartCounter').html('8');
    $('#divAddToCartModal').modal('show');
    $('#txtRequiredQty').focus();
}
function addtocart() {
    if ($('#txtRequiredQty').val() == '' || $('#txtRequiredQty').val() == '0') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter quantity...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if (parseFloat($('#txtAvailableQty').val()) < parseFloat($('#txtRequiredQty').val())) {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter quantity less than or equal to available quantity...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var totitems = $('#spnCartCounter').html();
    if ($('#spnCartCounter').html() == '') {
        totitems = 0;
    }
    else {
        totitems = parseInt($('#spnCartCounter').html());
    }
    totitems += 1;
    $('#spnCartCounter').html(totitems);
    $('#tblAddedToCartProducts tbody').append('<tr style="text-align:center;"><td>0</td><td style="text-align:left;">' + $('#txtProduct').val() + '</td><td>' + $('#txtRequiredQty').val() + '</td><td>' + $('#txtRate').val() + '/' + $('#txtUOM').val() + '</td><td style="text-align:right;">' + $('#txtTotalAmount').val() + '</td><td><a href="#" onclick="deletefromcarttable(this); return false;"><i data-feather="x-circle" style="color:red;"></i></a></td><td style="display:none;">' + $('#lblStockId').text()  + '</td></tr>');
    feather.replace();
    var slno = 0;
    var gtot = 0;
    $('#tblAddedToCartProducts tbody tr').each(function () {
        slno += 1;
        gtot += parseFloat($(this).find('td:eq(4)').html());
        $(this).find('td:eq(0)').html(slno);
    });
    $('#lblGTotal').text(gtot.toFixed(2));
    $('#divAddToCartModal').modal('hide');
    $("#collapseOne").collapse("show");
}
function deletefromcarttable(thisrow) {
    var this_row = $(thisrow).parent().parent();
    $(this_row).remove();
    var slno = 0;
    var gtot = 0;
    $('#tblAddedToCartProducts tbody tr').each(function () {
        slno += 1;
        gtot += parseFloat($(this).find('td:eq(4)').html());
        $(this).find('td:eq(0)').html(slno);
    });
    $('#lblGTotal').text(gtot.toFixed(2));
    if (slno == '0') {
        $('#spnCartCounter').html('');
    }
    else {
        $('#spnCartCounter').html(slno);
    }
    
}
function checkuseremailidexistforforgotpassword(username,emailid) {
    //we should check whether this Emailid registered already or not to send new password to the user (Forget Password)
    var value = $.ajax({
        url: "json.aspx?Option=CheckUserEmailIdExist&UserName=" + username + "&EmailId=" + emailid,
        async: false
    }).responseText;
    return value;
}
function sendnewpasswordonforgotpassword() {
    if ($('#txtUserNameForForgetPW').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Username...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtEmailForForgetPW').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Email Id...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if (isEmail($('#txtEmailForForgetPW').val()) === false) {
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Please enter valid Email Id...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var emailidexist = checkuseremailidexistforforgotpassword($('#txtUserNameForForgetPW').val() ,$('#txtEmailForForgetPW').val());
    if (emailidexist == '0') { // if output is 0 then email not exist if 1 then email exist
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'This Email does not exist. Please enter a different Email Id...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    //If EmailId exist then we can generate a new random password and send to given emailid.
    //For this we need to buy domain name, email address (own),password (own), SMTPHost and SMTPPort from sendgrid.net or any other agencies.
    //This is currently not in our scope so we just show a successfull message here:
    $('#divForgetPW').modal('hide');
    Swal.fire({
        icon: 'success',
        title: 'Farm Zone',
        text: 'New password is being sent to given mailid. Please check your mail...!!!'
    });
}
var colors = [
    '#008FFB',
    '#00E396',
    '#FEB019',
    '#FF4560',
    '#775DD0',
    '#546E7A',
    '#26a69a',
    '#D10CE8'
]
function loadsaleschart() {
    var options = {
        series: [{
            data: [21, 22, 10, 28, 16, 21, 13, 30]
        }],
        chart: {
            height: 350,
            type: 'bar',
            events: {
                click: function (chart, w, e) {
                    // console.log(chart, w, e)
                }
            }
        },
        colors: colors,
        plotOptions: {
            bar: {
                columnWidth: '45%',
                distributed: true,
            }
        },
        dataLabels: {
            enabled: false
        },
        legend: {
            show: false
        },
        xaxis: {
            categories: [
                ['Jun', '2021'],
                ['Jul', '2021'],
                ['Aug', '2021'],
                ['Sep','2021'],
                ['Oct', '2021'],
                ['Nov', '2021'],
                ['Dec', '2021'],
                ['Jan', '2022'],
            ],
            labels: {
                style: {
                    colors: colors,
                    fontSize: '12px'
                }
            }
        }
    };

    var chart = new ApexCharts(document.querySelector("#divSaleChart"), options);
    chart.render();
}
function loadproductwisechart() {
    var options = {
        series: [14, 23, 21, 17, 15, 10, 12, 17, 21],
        chart: {
            height: 390,
            type: 'polarArea',
        },
        legend: {
            show: false,
            position: 'bottom',
            floating: true,
            verticalAlign: 'bottom',
            align: 'center'
        },
        stroke: {
            colors: ['#fff']
        },
        fill: {
            opacity: 0.8
        },
        responsive: [{
            breakpoint: 480,
            options: {
                chart: {
                    width: 200
                },
                legend: {
                    show: false,
                    position: 'bottom'
                }
            }
        }]
    };

    var chart = new ApexCharts(document.querySelector("#divProductChart"), options);
    chart.render();
}
function loadlatestproductid() {
    //Load productid of recently added product
    var value = $.ajax({
        url: "json.aspx?Option=LoadLatestProductId",
        async: false
    }).responseText;
    return value;
}
function addupdateproduct() {
    if ($('#txtProductName').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter Name of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var fileName;
    var fileUpload;
    var filedata;
    var fileuploadcontrol = $('#formFile');
    fileName = fileuploadcontrol.val().split("\\").pop();
    if ($('#cmbProduct').val() === '1') {
        var duplicateexist = 0;
        $('#cmbProduct option').each(function () {
            var exisitngitemname = $(this).text();
            if (exisitngitemname === $('#txtProductName').val().toUpperCase()) {
                duplicateexist += 1;
            }
        });
        if (duplicateexist != '0') {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'This Product already exist...!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        if (fileName === '') {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'Please select image file...!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        
    }
    if (fileName != '') {
        var extension = fileName.substr((fileName.lastIndexOf('.') + 1));
        if (extension.toUpperCase() != 'PNG') {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'Please select only png file...!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        fileUpload = fileuploadcontrol.get(0);
        var files = fileUpload.files;
        if (files[0].size > 1048576) {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'Please select File less than 1 Mb.....!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        filedata = new FormData();
        for (var i = 0; i < files.length; i++) {
            filedata.append(files[i].name, files[i]);
        }
    }
    $("#btnAddUpdateProduct").prop("disabled", true);
    var obj = {};
    //Fields required are: ProductId,NameOfProduct, UserId
    //If ProductId=1 then insert else update in stored Procedure
    var userid = readCookie('farmzoneuserid');
    obj.ProductId = $('#cmbProduct').val();
    obj.NameOfProduct = $('#txtProductName').val().toUpperCase();
    obj.UserId = userid;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/AddUpdateProduct",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            //Upload the image file
            var latestfileid = 0;
            if ($('#cmbProduct').val() == '1') {
                latestfileid = loadlatestproductid();
                $.ajax({
                    url: "FileUploadHandler.ashx?FileId=" + latestfileid + "&DocType=ProductMasterImage",
                    type: "POST",
                    data: filedata,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        var data = {
                            id: latestfileid,
                            text: '' + $('#txtProductName').val().toUpperCase() + ''
                        };
                        var newOption = new Option(data.text, data.id, false, false);
                        $("#cmbProduct").append(newOption).trigger('change');
                        Swal.fire({
                            icon: 'success',
                            title: 'Farm Zone',
                            text: 'Product added successfully...!!!'
                        });
                        $("#btnAddUpdateProduct").prop("disabled", false);
                        $('#txtProductName').val('');
                        $("#formFile").val(null);
                        $('#cmbProduct').val('1').trigger('change');
                        $('#btnAddUpdateProduct').text('Add Product');
                        $('#btnAddUpdateProduct').removeClass('btn-danger').addClass('btn-primary');
                        $('#staticBackdropLabel').html('Add new Product');
                    },
                    error: function (err) {
                        alert(err.statusText)
                    }
                });
            }
            else {
                latestfileid = $('#cmbProduct').val();
                if (fileName != '') {
                    $.ajax({
                        url: "FileUploadHandler.ashx?FileId=" + latestfileid + "&DocType=ProductMasterImage",
                        type: "POST",
                        data: filedata,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            // after update to database, remove existing product from Combo and then re-add to the Combo
                            var productid = $('#cmbProduct').val();
                            $("#cmbProduct option[value=" + productid + "]").remove();
                            var data = {
                                id: productid,
                                text: '' + $('#txtProductName').val().toUpperCase() + ''
                            };
                            var newOption = new Option(data.text, data.id, false, false);
                            $("#cmbProduct").append(newOption).trigger('change');

                            Swal.fire({
                                icon: 'success',
                                title: 'Farm Zone',
                                text: 'Product updated successfully...!!!'
                            });
                            $("#btnAddUpdateProduct").prop("disabled", false);
                            $('#txtProductName').val('');
                            $("#formFile").val(null);
                            $('#cmbProduct').val('1').trigger('change');
                            $('#btnAddUpdateProduct').text('Add Product');
                            $('#btnAddUpdateProduct').removeClass('btn-danger').addClass('btn-primary');
                            $('#staticBackdropLabel').html('Add new Product');
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }
                else {
                    var productid = $('#cmbProduct').val();
                    $("#cmbProduct option[value=" + productid + "]").remove();
                    var data = {
                        id: productid,
                        text: '' + $('#txtProductName').val().toUpperCase() + ''
                    };
                    var newOption = new Option(data.text, data.id, false, false);
                    $("#cmbProduct").append(newOption).trigger('change');

                    Swal.fire({
                        icon: 'success',
                        title: 'Farm Zone',
                        text: 'Product updated successfully...!!!'
                    });
                    $("#btnAddUpdateProduct").prop("disabled", false);
                    $('#txtProductName').val('');
                    $("#formFile").val(null);
                    $('#cmbProduct').val('1').trigger('change');
                    $('#btnAddUpdateProduct').text('Add Product');
                    $('#btnAddUpdateProduct').removeClass('btn-danger').addClass('btn-primary');
                    $('#staticBackdropLabel').html('Add new Product');
                }
            }
        },
        error: function (err) {
            alert(err.statusText)
        }
    });
}
function farmerloadmodalforaddnewproduct() {
    $('#cmbProduct').val('1').trigger('change');
    $('#cmbUOM').val('1').trigger('change');
    $('#txtRate').val('');
    $('#txtQty').val('');
    $('#txtRemarks').val('');
    $("#formFile").val(null);
    $('#divAddProductModal').modal('show');
    //$('#divProductMasterModal').modal('show');
}
function checkavailabilityofproduct(productid) {
    //if not available then 0 else 1
    var userid = readCookie('farmzoneuserid');
    var value = $.ajax({
        url: "json.aspx?Option=CheckAvailabilityOfProduct&ProductId=" + productid + "&UserId=" + userid,
        async: false
    }).responseText;
    return value;
}
function isNumberKeyWithTwoDigits(evt, element) {
    //This function used to allow only numbers with only two decimal places
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57) && !(charCode == 46 || charCode == 8))
        return false;
    else {
        var len = $(element).val().length;
        var index = $(element).val().indexOf('.');
        if (index > 0 && charCode == 46) {
            return false;
        }
        if (index > 0) {
            var CharAfterdot = (len + 1) - index;
            if (CharAfterdot > 3) {
                return false;
            }
        }

    }
    return true;
}
function farmeraddproduct() {
    if ($('#cmbProduct').val() == '1') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please select a Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
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
    if ($('#cmbUOM').val() == '1') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please select UOM...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtRate').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter unit rate of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtQty').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter quantity of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtRemarks').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter remarks of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var fileName;
    var fileUpload;
    var filedata;
    var fileuploadcontrol = $('#formFile');
    fileName = fileuploadcontrol.val().split("\\").pop();
    if (fileName === '') {
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Please select image file...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var extension = fileName.substr((fileName.lastIndexOf('.') + 1));
    if (extension.toUpperCase() != 'PNG') {
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Please select only png file...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    fileUpload = fileuploadcontrol.get(0);
    var files = fileUpload.files;
    if (files[0].size > 1048576) {
        Swal.fire({
            icon: 'error',
            title: 'Farm Zone',
            text: 'Please select File less than 1 Mb.....!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    filedata = new FormData();
    for (var i = 0; i < files.length; i++) {
        filedata.append(files[i].name, files[i]);
    }
    $("#btnAddUpdateProduct").prop("disabled", true);
    var obj = {};
    //Fields required are: ProductId, UOMId, RatePerUnit, TotalQty, FarmerRemarks, UserId
    var userid = readCookie('farmzoneuserid');
    obj.ProductId = $('#cmbProduct').val();
    obj.UOMId = $('#cmbUOM').val();
    obj.RatePerUnit = $('#txtRate').val();
    obj.TotalQty = $('#txtQty').val();
    obj.FarmerRemarks = $('#txtRemarks').val();
    obj.UserId = userid;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/FarmerAddProduct",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            //Upload the image file
            var stockid = 0;
            stockid = loadstockid(userid, $('#cmbProduct').val(), $('#cmbUOM').val());
            $.ajax({
                url: "FileUploadHandler.ashx?FileId=" + stockid + "&DocType=FarmerProductImage",
                type: "POST",
                data: filedata,
                contentType: false,
                processData: false,
                success: function (result) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Farm Zone',
                        text: 'Product added successfully...!!!'
                    });
                    var nameofproduct = $("#cmbProduct option:selected").text();
                    var qty = $('#txtQty').val() + ' ' + $("#cmbUOM option:selected").text();
                    $("#btnAddUpdateProduct").prop("disabled", false);
                    $('#cmbProduct').val('1').trigger('change');
                    $('#cmbUOM').val('1').trigger('change');
                    $('#txtRate').val('');
                    $('#txtQty').val('');
                    $('#txtRemarks').val('');
                    $("#formFile").val(null);
                    $('#divAddProductModal').modal('hide');
                    var htmlstr = '';
                    htmlstr = htmlstr + '<div class="col">';
                    htmlstr = htmlstr + '<div class="card h-100">';
                    htmlstr = htmlstr + '<img src="img/FarmerProducts/' + stockid + '.png" class="card-img-top" alt="' + nameofproduct + '" style="max-width: 300px; margin-left: auto; margin-right: auto;"/>';
                    htmlstr = htmlstr + '<div class="card-body">';
                    htmlstr = htmlstr + '<h5 class="card-title">' + nameofproduct + '</h5>';
                    htmlstr = htmlstr + '<p class="card-text">';
                    htmlstr = htmlstr + 'Available quantity: ' + qty + '</p></div>';
                    htmlstr = htmlstr + '<div class="card-footer">';
                    htmlstr = htmlstr + '<div class="row">';
                    htmlstr = htmlstr + '<div class="col-6">';
                    htmlstr = htmlstr + '<a href="#" title="Edit this Product" onclick="showmodalforeditproduct(' + stockid + '); return false;"><span data-feather="edit" style="color:dodgerblue;"></span></a>';
                    htmlstr = htmlstr + '</div>';
                    htmlstr = htmlstr + '<div class="col-6">';
                    htmlstr = htmlstr + '<a href="#" title="Delete this Product" onclick="showmodalfordeleteproduct(' + stockid + '); return false;"><span data-feather="x-circle" style="float:right;color:tomato;"></span></a>';
                    htmlstr = htmlstr + '</div>';
                    htmlstr = htmlstr + '</div>';
                    htmlstr = htmlstr + '</div>';
                    htmlstr = htmlstr + '</div>';
                    htmlstr = htmlstr + '</div>';
                    $('#divProducts').append(htmlstr);
                    feather.replace();
                },
                error: function (err) {
                    alert(err.statusText)
                }
            });
        },
        error: function (err) {
            alert(err.statusText)
        }
    });
}
function loadstockid(userid,productid,uomid) {
    //Load StockId from FarmerId, ProductId and UOMId
    var value = $.ajax({
        url: "json.aspx?Option=LoadStockId&FarmerId=" + userid + "&ProductId=" + productid + "&UOMId=" + uomid,
        async: false
    }).responseText;
    return value;
}
function showmodalforeditproduct(stockid) {
    $('#txtProductToEdit').val('');
    $('#txtUOMToEdit').val('');
    $('#txtRateToEdit').val('');
    $('#txtQtyToEdit').val('');
    $('#txtRemarksToEdit').val('');
    $('#formFileToEdit').val(null);
    $('#lblActualQty').text('0'); // This label will have the current quantity to validate (hidden)
    $('#lblStock').text(stockid);
    var URL = "JSON.aspx?Option=LoadFarmerProductDetailsForEdit&StockId=" + stockid;
    $.getJSON(URL, function (data) {
        if (data.length > 0) {
            $.each(data, function () {
                //ProductName, UOM, RatePerUnit, FarmerRemarks, AvailableQty
                $('#txtProductToEdit').val(this.ProductName);
                $('#txtUOMToEdit').val(this.UOM);
                $('#txtRateToEdit').val(this.RatePerUnit);
                $('#txtQtyToEdit').val(this.AvailableQty);
                $('#txtRemarksToEdit').val(this.FarmerRemarks);
                $('#lblActualQty').text(this.AvailableQty);
            });
        }
    });
    $('#divEditProductModal').modal('show');
}
function showmodalfordeleteproduct(stockid) {
    Swal.fire({
        icon: 'error',
        title: 'Farm Zone',
        text: 'This product still have some quantity available...!!!'
    });
}
function farmerupdateproduct() {
    if ($('#txtQtyToEdit').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter quantity of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if (parseFloat($('#txtQtyToEdit').val()) < parseFloat($('#lblActualQty').text())) {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter quantity more than or equal to ' + $('#lblActualQty').text()  + '...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtRemarksToEdit').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please enter remarks of Product...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var fileName;
    var fileUpload;
    var filedata;
    var fileuploadcontrol = $('#formFileToEdit');
    fileName = fileuploadcontrol.val().split("\\").pop();
    if (fileName != '') {
        var extension = fileName.substr((fileName.lastIndexOf('.') + 1));
        if (extension.toUpperCase() != 'PNG') {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'Please select only png file...!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        fileUpload = fileuploadcontrol.get(0);
        var files = fileUpload.files;
        if (files[0].size > 1048576) {
            Swal.fire({
                icon: 'error',
                title: 'Farm Zone',
                text: 'Please select File less than 1 Mb.....!!!'
            });
            event.returnValue = false;
            event.cancel = true;
            return false;
        }
        filedata = new FormData();
        for (var i = 0; i < files.length; i++) {
            filedata.append(files[i].name, files[i]);
        }
    }
    $("#btnUpdateProduct").prop("disabled", true);
    var obj = {};
    //Fields required are: StockId, UOMId, RatePerUnit, TotalQty, FarmerRemarks, UserId
    var userid = readCookie('farmzoneuserid');
    obj.StockId = $('#lblStock').text();
    obj.TotalQty = $('#txtQtyToEdit').val();
    obj.FarmerRemarks = $('#txtRemarksToEdit').val();
    obj.UserId = userid;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/FarmerUpdateProduct",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            if (fileName != '') {
                //Upload the image file
                $.ajax({
                    url: "FileUploadHandler.ashx?FileId=" + $('#lblStock').text() + "&DocType=FarmerProductImage",
                    type: "POST",
                    data: filedata,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        $('#divEditProductModal').modal('hide');
                        $("#btnUpdateProduct").prop("disabled", false);
                        Swal.fire({
                            icon: 'success',
                            title: 'Farm Zone',
                            text: 'Product updated successfully...!!!'
                        });
                    },
                    error: function (err) {
                        alert(err.statusText)
                    }
                });
            }
            else {
                $('#divEditProductModal').modal('hide');
                $("#btnUpdateProduct").prop("disabled", false);
                Swal.fire({
                    icon: 'success',
                    title: 'Farm Zone',
                    text: 'Product updated successfully...!!!'
                });
            }
        },
        error: function (err) {
            alert(err.statusText)
        }
    });
}
function buyerorderproducts() {
    if ($('#tblAddedToCartProducts tbody tr').length === 0) {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please add product(s) to order...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtDeliveryTo').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please add delivery to name...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    if ($('#txtDeliveryAddress').val() == '') {
        Swal.fire({
            icon: 'info',
            title: 'Farm Zone',
            text: 'Please add delivery address...!!!'
        });
        event.returnValue = false;
        event.cancel = true;
        return false;
    }
    var userid = readCookie('farmzoneuserid');
    var rows = [];
    var stockid = 0;
    var qty = 0;
    $('#tblAddedToCartProducts tbody tr').each(function () {
        stockid = $(this).find("td").eq(6).html();
        qty = $(this).find("td").eq(2).html();
        rows.push(stockid + '#' + qty);
    });
    var obj = {};
    //Fields required are: BuyerId, Products, DeliveryAddress
    var userid = readCookie('farmzoneuserid');
    obj.BuyerId = userid;
    obj.Products = rows.toString();
    obj.DeliveryTo = $('#txtDeliveryTo').val();
    obj.DeliveryAddress = $('#txtDeliveryAddress').val();
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/CreateBuyerInvoice",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            var filename = userid + '_BuyerInvoice.pdf';
            PDFObject.embed('Invoices/' + filename, "#divPdf");
            $('#txtDeliveryTo').val('');
            $('#txtDeliveryAddress').val('');
            $('#divCart').modal('hide');
            $('#spnCartCounter').html('');
            $('#tblAddedToCartProducts tbody').html('');
            $("#ModalForPDF").modal('show');
        },
        error: function (result) { alert(Error.toString()); }
    });
}
function farmerloaddeliverypendingcount(userid) {
    //Load pending count for side menu notification
    var value = $.ajax({
        url: "json.aspx?Option=FarmerLoadDeliveryPendingCount&FarmerId=" + userid,
        async: false
    }).responseText;
    return value;
}
function loadpendinginvoicestodelivery() {
    var userid = readCookie('farmzoneuserid');
    $('#tblPendingInvoices tbody').html('');
    var URL1 = "JSON.aspx?Option=LoadPendingInvoicesToDelivery&FarmerId=" + userid;
    $.getJSON(URL1, function (data) {
        if (data.length > 0) {
            $.each(data, function () {
                //                                                                                 OrderId,                     DateOfOrder,                     DeliveryTo,                     BuyerAddress,                 Amount
                $('#tblPendingInvoices tbody').append('<tr style="text-align:center;"><td>' + this.OrderId + '</td><td>' + this.DateOfOrder + '</td><td style="text-align:left;">' + this.DeliveryTo + '</td><td style="text-align:left;">' + this.BuyerAddress + '</td><td style="text-align:right;">Rs.' + this.Amount.toFixed(2) + '</td><td><a href="#" onclick="farmerviewinvoice(' + this.OrderId + '); return false;"><i data-feather="eye"></i></a></td><td><a href="#" onclick="farmerconfirmdelivery(' + this.OrderId + '); return false;"><i data-feather="truck"></i></a></td></tr>');
                feather.replace();
            });
        }
    });
}
function farmerviewinvoice(orderid) {
    var obj = {};
    //Fields required are: BuyerId, Products, DeliveryAddress
    var userid = readCookie('farmzoneuserid');
    obj.FarmerId = userid;
    obj.OrderId = orderid;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/CreateFarmerInvoice",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            var filename = userid + '_FarmerInvoice.pdf';
            PDFObject.embed('Invoices/' + filename, "#divPdf");
            $("#ModalForPDF").modal('show');
        },
        error: function (result) { alert(Error.toString()); }
    });
}
function farmerconfirmdelivery(orderid) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You are going to deliver the products",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, deliver it!'
    }).then((result) => {
        if (result.isConfirmed) {
            var obj = {};
            //Fields required are: OrderId, FarmerId
            var userid = readCookie('farmzoneuserid');
            obj.OrderId = orderid;
            obj.FarmerId = userid;
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "json.aspx/FarmerConfirmDelivery",
                data: JSON.stringify(obj),
                dataType: "json",
                success: function (data) {
                    loadpendinginvoicestodelivery();
                    var pdgcount = farmerloaddeliverypendingcount(userid);
                    if (pdgcount != '0') {
                        $('#spnDeliveryPdg').html(pdgcount);
                    }
                    else {
                        $('#spnDeliveryPdg').html('');
                    }
                    Swal.fire(
                        'Delivered!',
                        'Your products delivered to Constomer.',
                        'success'
                    )
                },
                error: function (err) {
                    alert(err.statusText)
                }
            });
        }
    })
}
function buyerloaddeliveryduecount(userid) {
    //Load pending count for side menu notification
    var value = $.ajax({
        url: "json.aspx?Option=BuyerLoadDeliveryDueCount&BuyerId=" + userid,
        async: false
    }).responseText;
    return value;
}
function buyerloadpendinginvoicestodelivery() {
    var userid = readCookie('farmzoneuserid');
    $('#tblPendingInvoices tbody').html('');
    var URL1 = "JSON.aspx?Option=BuyerLoadPendingInvoicesToDelivery&BuyerId=" + userid;
    $.getJSON(URL1, function (data) {
        if (data.length > 0) {
            $.each(data, function () {
                //                                                                                 OrderId,                     DateOfOrder,                                              TotalAmount,                                                         DeliveryTo
                $('#tblPendingInvoices tbody').append('<tr style="text-align:center;"><td>' + this.OrderId + '</td><td>' + this.DateOfOrder + '</td><td style="text-align:right;">' + this.TotalAmount.toFixed(2) + '</td><td style="text-align:left;">' + this.DeliveryTo + '</td><td><a href="#" onclick="buyerviewinvoice(' + this.OrderId + '); return false;"><i data-feather="eye"></i></a></td></tr>');
                feather.replace();
            });
        }
    });
}
function buyerviewinvoice(orderid) {
    var obj = {};
    //Fields required are: BuyerId, Products, DeliveryAddress
    var userid = readCookie('farmzoneuserid');
    obj.FarmerId = userid;
    obj.OrderId = orderid;
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "json.aspx/ViewBuyerInvoice",
        data: JSON.stringify(obj),
        dataType: "json",
        success: function (data) {
            var filename = orderid + '_BuyerInvoice.pdf';
            PDFObject.embed('Invoices/' + filename, "#divPdf");
            $("#ModalForPDF").modal('show');
        },
        error: function (result) { alert(Error.toString()); }
    });
}