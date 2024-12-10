<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="pickupForm.aspx.cs" Inherits="FYP_Florence.pickupForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Manrope:wght@200..800&display=swap" rel="stylesheet">
	<link href="layoutStyling.css" rel="stylesheet" type="text/css" />
    <style>
    .container-pickup {
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
        
        width:400px;
        position: relative; /*awalnya absolute*/
        padding: 10px 60px 70px;
        border-radius: 4px;
        border: 2px solid lightgrey;
        display:flex;
        flex-direction:column;
        margin-top:10px;
		left:35%;
		right:35%;
    }

    .form-box h1 {
	    font-size: 30px;
	    margin-bottom: 20px;
	    color: #69443c;
	    position:relative;
        font-family:"poppinssemibold";
		text-align:center;
    }

	.text-field{
	    background: transparent;
		font-family: poppinssemibold;
		margin-bottom: 20px;
		margin-top:3px;
		font-size:12px;
		display: flex;
        flex-direction: column;
		align-items:flex-start;
    } 

	.text-field input[type="text"],
	.text-field input[type="date"],
	.text-field input[type="tel"],
	.text-field select
	{
        line-height: 40px; 
        width: 350px;
        border-radius:5px;
    }

	
	.text-field p{
		margin-bottom:10px;
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
	.info-text {
        display: flex;
        align-items: center;
        margin-top: 10px;
		margin-left:25px;
	}

	.info-text i {
        margin-right: 10px;
        color: #6F768D;
        font-size: 24px;
    }

        .info-text p {
            font-family: "Manrope";
            font-size: 12px;
            font-weight: 600;
            color: #6F768D;
        }



</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    	   <a href="cartPage.aspx" class="arrow-link">
    <div class="arrow-container">
        <i class="fa-solid fa-arrow-left"></i>
        <div class="back-text">back</div>
    </div>
</a>
	<hr class="divider">
    <div class="container-pickup">
    <div class="content">
		<div class="form-box">
			<h1> PickUp Information</h1>
				<div class="text-field">
					<p>Name:</p>
					<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
				</div>

				<div class="text-field">
					<p>Phone Number:</p>
					<asp:TextBox ID="TextBox3" runat="server"  TextMode="Phone"></asp:TextBox>
				</div>
			<div class="text-field">
                    <p>Pick Up Date:</p>
                    <asp:TextBox ID="TextBoxDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div class="text-field">
                    <p>Pick Up Time:</p>
                    <asp:DropDownList ID="DropDownListTime" runat="server">
                        <asp:ListItem>10:00 AM - 11:00 AM</asp:ListItem>
                        <asp:ListItem>11:00 AM - 12:00 PM</asp:ListItem>
                        <asp:ListItem>01:00 PM - 02:00 PM</asp:ListItem>
                        <asp:ListItem>02:00 PM - 03:00 PM</asp:ListItem>
                        <asp:ListItem>03:00 PM - 04:00 PM</asp:ListItem>
                        <asp:ListItem>04:00 PM - 05:00 PM</asp:ListItem>
                    </asp:DropDownList>
                </div>

			<div>
				<asp:Button ID="Button1" runat="server" Text="Continue" Visible="true" CssClass="update-btn" OnClick="Button1_Click"/>
			</div>
			<div>
				<asp:Label ID="errMsg" runat="server" Text="Label" Font-Size="12px" ForeColor="Red" Visible="False" ></asp:Label>
			</div>

			<div class="info-text">
                    <i class="fa-solid fa-circle-info"></i>
                    <p>Please refer to contact page for pick up information</p>
                </div>	
		</div>
	</div>
</div>
</asp:Content>
