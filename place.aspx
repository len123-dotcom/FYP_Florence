<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="place.aspx.cs" Inherits="FYP_Florence.place" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>    
 <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Manrope:wght@200..800&display=swap" rel="stylesheet">

    <style>
        .container {
	        max-width: 1200px;
	        margin: 1px;
	        padding: 20px;
	        display: flex;
	        flex-direction: row;
	        justify-content: space-between; 
	        align-items: flex-start; 
	        min-height: 100vh;	
        }
        .content{
	        flex:1;
        }

        .form-box{
    
            width:720px;
            position: relative; /*awalnya absolute*/
            padding: 10px 60px 70px;
            border-radius: 4px;
            border: 2px solid lightgrey;
            display:flex;
            flex-direction:column;
            margin-top:10px;
	        left:25%;
	        right:25%;
        }

        .form-box h1 {
            font-size: 30px;
            margin-bottom: 20px;
            color: #69443c;
            position:relative;
            font-family:"poppinssemibold";
        }

        .arrow-link{
	        text-decoration:none;
        }
        .manrope-<uniquifier> {
          font-family: "Manrope", sans-serif;
          font-optical-sizing: auto;
          font-style: normal;
        }

        .arrow-container {
	        position: relative;
	        text-align: left; 
	        margin-top:1cm;
        }

        .arrow-container i {
	        position: absolute;
	        top:2px;
	        left: 8%;
	        font-size: 15px; 
	        margin-right: 10px;
	        color: #6F768D;
        }

        .divider {
	        width: 80%;
	        border: none;
	        border-top: 1px solid #ccc;
	        /*margin: 10px 10;*/
        }
        .back-text {
	        margin-left: 140px;
	        color: #6F768D;
	        font-family:"Manrope";
	        font-size:12px;
	        font-weight:600;
        }	
        .button-container {
            display: flex;
            justify-content: space-evenly;
        }

        .btn-place {
            height: 100px;
            width: 100px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            position: relative;
            padding-left: 30px; 
            text-decoration:none;
        }

        .btn-place i {
            position: absolute;
            left: 10px;
            font-size: 24px; 
            color: #6F768D; 
        }



        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    	  <%-- <a href="cartPage.aspx" class="arrow-link">
    <div class="arrow-container">
        <i class="fa-solid fa-arrow-left"></i>
        <div class="back-text">back to cart</div>
    </div>
</a>
	<hr class="divider">
    <div class="container">
    <div class="content">
		<div class="form-box">
			<h1> Collection Information</h1>
            <div class="button-container">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn-place" OnClick="LinkButton1_Click">
                        <i class="fa-solid fa-box"></i> Pick Up
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn-place" OnClick="LinkButton2_Click">
                        <i class="fa-solid fa-truck"></i> Delivery
                    </asp:LinkButton>
                </div>
        </div>
    </div>
    </div>--%>
</asp:Content>
