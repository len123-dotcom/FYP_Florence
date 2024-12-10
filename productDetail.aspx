<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="productDetail.aspx.cs" Inherits="FYP_Florence.productDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>    
	 <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Manrope:wght@200..800&display=swap" rel="stylesheet">
	
	<style>

		body {
			width: 100%;
            height: 800px;
            background-color:#FEFAF6;
		}
 
		.container{
			width:100%;
			margin: 0 auto;
			padding: 0 15px;
			display: flex;
			flex-direction: row;
		}

		@font-face {
            font-family: 'poppinssemibold';
            src: url('poppins-semibold-webfont.woff2') format('woff2'),
                 url('poppins-semibold-webfont.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

		.product-details {
		}
 
		.col-2 img {
			margin-bottom: 3px;
			max-width:80%;
		}
 
		.cart-button{
			background: #3434eb;
			border-radius: 8px;
			color: #ffffff;
			font-family:"Inter";
			border:none;
			cursor:pointer;
			height:50px;
			width:120px;
		}
 
		.product-title {
			font-family: poppinssemibold;
			font-weight: bold;
			margin-bottom: 5px;
			font-size:40px;
		}
 
		.product-price,
		.product-description,
		.product-quantity 
		{
			margin-bottom: 20px;
			margin-top:3px;
			font-family:"Inter";
			font-size:17px;
		}

		.error-message{
			color:red;
			font-family: 'Inter';
			font-size:16px;
		}

		.button-disabled {
			background-color: #42a2fc9b; 
			color: #ffff;
			cursor: not-allowed; 
		}
		.row-detail {
			display: flex;
			align-items: center;
			flex-wrap: wrap;
			justify-content: center;
			border: 1px solid #ccc;
			padding: 20px;
			margin: 20px auto;
			border-radius:8px;
		}

		.col-2 {
			flex-basis: 50%;
			min-width: 300px;
		}
		
		.custom-textbox {
            line-height: 30px; 
            width: 35px;
            border-radius:4px;
			text-align: center;
			padding-left:13px;
			margin: 0 10px;
       
        }
		.wrapper{
			height:95px;
			display: flex;
			align-items:center;
		}
		.btnminus, 
		.btnppp{
			font-weight: normal;
            width: auto;
            padding: 3px 25px;
            background:#3434eb;
            border: none;
            border-radius: 8px;
            color: #ffffff;
            height:40px;
            font-family:Inter;
			align-items: center;
            justify-content: center;
            display: flex;
			cursor:pointer;
		}
		
		.divider {
            width: 80%;
            border: none;
            border-top: 1px solid #ccc;
        }
		.arrow-container {
			position: relative;
			text-align: left; 
			margin-top:1cm;
		}

		.arrow-container i {
			position: absolute;
			top:2px;
			left: 6%;
			font-size: 16px; 
			margin-right: 10px;
			color: #6F768D;
		}

		.back-text {
			margin-left: 110px;
			color: #6F768D;
			font-family:"Manrope";
			font-size:16px;
			font-weight:600;
			
		}

		.arrow-link{
			text-decoration:none;
			
		}


		.manrope-<uniquifier> {
		  font-family: "Manrope", sans-serif;
		  font-optical-sizing: auto;
		  font-style: normal;
		}

		.inter-<uniquifier> {
          font-family: "Inter", sans-serif;
          font-optical-sizing: auto;
          font-weight:normal;
          font-style: normal;

        }
		.size-button{
			margin-right: 5px;
            padding: 5px 10px;
            background-color: #005AE5;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
		}

		.average-rating {
			font-family: "Inter";
			font-size: 18px;
			color: #FFD700; 
			margin-top: 10px;
			display:flex;
			align-items: center;
			gap:5px;
		}
		.empty{
			background:url("emptystar.png") no-repeat;
			width:15px;
			height:15px;
			background-size:contain;

		}
		.filled{
			background: url("full_star.png") no-repeat;
			width:15px;
			height:15px;
			background-size:contain;
		}
		.reviews{
			max-width: 1200px;
			margin: 20px auto;
			padding: 20px;
			display: flex;
			flex-direction: column;
			justify-content: flex-start;
			background: #fff;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		.stars {
			display: flex;
		}
		.review-link {
			text-decoration: none;
			color: #005AE5;
			font-family: "Inter", sans-serif;
			font-size: 16px;
			margin-top:13px;
		}
		.totalprod {
			color: #005AE5;
			font-family: "Inter", sans-serif;
			font-size: 16px;
			margin-top:13px;
		}
		.rating-review-container {
			display: flex;
			align-items: center;
			margin-top: 10px;
			gap:10px;
		}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


	   <a href="productPage1.aspx" class="arrow-link">
        <div class="arrow-container">
            <i class="fa-solid fa-arrow-left"></i>
            <div class="back-text">back to product list</div>
        </div>
    </a>

	<hr class="divider">

    <div class="container">
		
        <div class="row-detail">
            <div class="col-2">
                <asp:Image ID="productImage" runat="server" />
            </div>
		<div class="col-2">
            <div class="product-details">
                <h1 class="product-title">
                    <asp:Label ID="product_name" runat="server" Text="product_name"></asp:Label>
                </h1>
			<div class="rating-review-container">
				<asp:Label ID="lblAverageRating" runat="server" CssClass="average-rating"></asp:Label>
				<asp:HyperLink ID="hlTotalReviews" runat="server" CssClass="review-link"></asp:HyperLink>
				<asp:Label ID="lblTotalProd" runat="server" CssClass="totalprod"></asp:Label>
			</div>
            <p class="product-price">
                Rp <asp:Label ID="product_price" runat="server" Text="product_price"></asp:Label>
            </p>
            <p class="product-description">
                Description: <br /><asp:Label ID="product_description" runat="server" Text="product_description"></asp:Label>
            </p>
			
			<p class="product-quantity"> Stock:  
                <asp:Label ID="product_quantity" runat="server" Text="product_quantity"></asp:Label>
            </p>

			<p style="font-family:Inter"> Enter quantity:</p>
			<div class="wrapper">
				<asp:Button ID="btnminus" runat="server" Text="-" CssClass="btnminus" OnClick="btnminus_Click"/>
				<asp:TextBox ID="quantity" runat="server" value="0" TextMode="Number" CssClass="custom-textbox"></asp:TextBox>
				<asp:Button ID="btnplus" runat="server" Text="+" CssClass="btnppp" OnClick="btnplus_Click"/>
			</div>
				<p class="error-message" id="ErrorMessage" runat="server" visible="false"></p>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add to Cart" CssClass="cart-button" />
				</div>
            </div>
        </div>
      </div>

	
	<div class="reviews" id="reviews">
    <asp:Repeater ID="rptReviews" runat="server">
        <ItemTemplate>
            <div class="review-item">
                <p class="review-date"><%# Eval("ReviewDate", "{0:MMMM dd, yyyy}") %></p>
                <p class="user-name">Reviewed by: <%# Eval("userName") %></p>
                <div class="stars"><%# GenerateStarImages(Convert.ToDouble(Eval("Rating"))) %></div>
                <p class="review-text"><%# Eval("ReviewText") %></p>
				<hr />
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>


</asp:Content>