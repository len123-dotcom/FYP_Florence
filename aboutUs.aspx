<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="FYP_Florence.aboutUsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <link href="layoutStyling.css" rel="stylesheet" type="text/css" />
	<style type="text/css">

	
	.col-2{
		flex-basis: 38%;
		min-width: 300px;
		
	}


	.about{
		background:#FFF5EB;
		margin-left:190px;
		width:800px;
		margin-top:100px;
		height:570px;
	}
	.small-container{
		max-width: 1080px;
		margin: auto;
		padding-left: 25px;
		padding-right: 25px;
	}

	.row{
		display: flex;
		align-items: center;
		flex-wrap: wrap;
		justify-content: space-around;
	}

	.about1{
		background:#FEFAF6;
		margin-left:190px;
		width:800px;
		margin-top:50px;
		height:500px;
	}

	.ctc-info {
		padding-top: 10px;
		text-align: center;
	}

	.about2{
		background:#EADBC8;
		width:800px;
		margin-top:50px;
		height:500px;
	}
	.btn{
		display: inline-block;
    	text-decoration: none;
    	color: black;
    	border: 1px solid #ffff;
    	margin: 30px 0;
    	padding: 8px 30px;
    	font-size: 15px;
    	background: #EADBC8;
    	border-radius: 10px;
	}
	.product{
		    padding-top:100px;
		    text-align:center;
	    }

	.product .col-4{
		text-align:center;
		padding:40px 20px;
        background-color:#FEFAF6;
        border-radius:8px;
        border:outset;
	}

	.product .col-4 image{
		width: 50px;
		margin-top:20px;
		border-radius:50%;

	}

	.product p {
		line-height: 1.5; /* Adjust as needed */
	}

	.col-4{
		flex-basis: 20%;
		padding: 10px;
		min-height: 200px;
		margin-bottom: 50px;
	}

	.row1 {
	    margin-top: 5%;
	    display: flex;
	    justify-content: space-between;
		gap:30px;
    }

	.small-container1{
		max-width: 1080px;
		margin: auto;
		padding-left: 15px;
		padding-right: 15px;
	}

	.row2 {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: space-around;
	}
	.col-3 {
		flex-basis: 33.33%;
		min-width: 200px; 
	   flex-basis: 3.33%;
	   display:flex;
}
	.container-aboutus {
		max-width: 1300px;
		margin: 50px auto;
		padding-left: 1px;
		padding-right: 1px;
	}

		.col-3 img {
			border-radius: 1000px;
			width: 200px;
			height: 250px;
			border-style: outset;
			padding-right: 10px;
		}
		    .vertical-text {
        font-size: 20px;
        margin-top: 10px; 
        font-family: "Hanken Grotesk", sans-serif;
    }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="about">
			<div class="small-container">
				<div class="row">
					<div class="col-2">
						<p style="font-family: 'Inter'; font-size: 20px; color: black; margin-bottom:10px;">About US</p>
						<h1 style="color:black; font-family:Inter;">History</h1>
						<small style="font-family: 'Inter';">
							Embark on a journey that spans over a decade. 
							Juhi Ibu Lucia began its flavorful venture in 2006, 
							introducing a single type of homemade snack to eager taste buds. 
							Initially managed by Ibu Lucia's mother, who ran the business for over 10 years, 
							the foundation was laid with dedication and hard work. In time, she entrusted the business to her daughter, 
							Ibu Lucia, who expanded and refined it through her extensive experience and commitment to perfecting the wonderful taste of Juhi.
							<br /> <br />
							Fast forward to the present day, our journey has blossomed, now offering two distinct flavors that captivate palates far and wide. 
							This evolution stands as a testament to our commitment to quality, flavor, and the joy of sharing our passion with you.
							Our story is one of tradition and innovation, where every bite of Juhi reflects our heritage and continuous quest for perfection. 
							We take pride in the journey that has brought us here and look forward to many more years of delighting our customers with the unique flavors of Juhi Ibu Lucia.

						</small>
						
					
				</div>
			
				<div class="col-2">
					<img src="Pictures/juhi garing.png"    
						style="margin-top:90px; max-width:179%; height:440px; border-radius:20px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);" />
					
				</div>
			</div>
		</div>
	</div>

	 <div class="about1">
			<div class="small-container">
				<div class="row">
					<div class="col-2">
						<img src="Pictures/locationabtus.gif"    
						style="margin-left:-90px; max-width:180%; height:440px;" />
						
					
				</div>
			
				<div class="col-2" style="margin-left:auto;">
					
						<h1 style="color:black; font-family:Inter;">Business Location</h1>
						<small style="font-family: 'Inter';">
							We are currently based in Jakarta, Indonesia. While we do not operate a traditional offline store, 
							customers have the option to pick up their products directly from our home-based factory. 
							This provides a convenient way for customers to collect their orders in person. 
							If you choose this option, please ensure to arrange a suitable time for your visit to ensure a smooth and efficient pick-up process. 
							Our team will be happy to assist you with any additional information or support you may need.

						</small>
						<br></br>
						<a href="contactPage.aspx" class="btn">Shop Now</a>
					
				</div>
			</div>
		</div>
	</div>	

	


	
	




</asp:Content>
