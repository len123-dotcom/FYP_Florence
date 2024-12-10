<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="forgotPassword.aspx.cs" Inherits="FYP_Florence.forgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <link href="layoutStyling.css" rel="stylesheet" type="text/css" />
    <style>
        .container-forgotpass {
            width: 100%;
            height: 800px;
            background-size: cover;
            background-color:#FEFAF6;
        }
        .form-box{
            width: 95%;
            max-width: 460px;
            position: absolute;
            top: 30%;
            left: 30%;
            padding: 50px 60px 70px;
            text-align: center;
            border-radius: 8px;
            border: 2px solid lightgrey;
            background-color: #EADBC8;
        }

        .form-box h1 {
		    font-size: 30px;
		    margin-bottom: 20px;
		    color: #69443c;
		    position:relative;
            font-family:"Inter";
            align-items:center;
	    }
        .form-box p {
            margin-top:10px;            
            font-family: "Inter";
        }


        
        .reset {
            font-weight: normal;
            width: 145px;
            height:40px;
            padding: 6px 3px;
            background:#3434eb;
            border: 1px solid #ffff;
            border-radius: 8px;
            color: #ffffff;
            font-family:"Inter";
            margin-top:10px;
        }
        .error-message, .success-message {
            display: block;
            font-size: 12px;
            margin-bottom: 10px;
            text-align: left;
            font-family:"Inter";
        }
        .custom-valid{
            margin-left: 50px;
            color:red;
            margin-top:-30px;
            font-family:"Inter";
        }
        


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-forgotpass">
        <div class="form-box">
            <h1>Forgot Password</h1>
            <p>Enter your email to reset your password.</p>

            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-envelope"></i>
                </span>
                <asp:TextBox runat="server" ID="txtEmail" placeholder="Enter your email" style="padding-left:40px; font-family:Inter;" TextMode="Email" />
            </div>
            <asp:Label runat="server" ID="lblEmailError" CssClass="error-message" Visible="False" ForeColor="Red" style="margin-top:-20px; margin-left:50px;"></asp:Label>


            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-lock"></i>
                </span>
                <asp:TextBox runat="server" ID="txtNewPassword" TextMode="Password"  placeholder="Enter new password" style="padding-left:40px; font-family:Inter;" />
            </div>
            <asp:Label runat="server" ID="lblPasswordSuccess" CssClass="success-message" Visible="False" ForeColor="Green" style="margin-top:-20px; margin-left:50px;" ></asp:Label>

            <div class="text-field" style="margin:0px;">
                <asp:CustomValidator ID="CustomValidator1" runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="Password must be at least 8 characters long."
                    OnServerValidate="CustomValidator1_ServerValidate" CssClass="custom-valid">
                </asp:CustomValidator>
            </div>
    
            <asp:Button runat="server" ID="btnResetPassword" Text="Reset Password" CssClass="reset" OnClick="btnResetPassword_Click" />
            <asp:Label runat="server" ID="errMsg" CssClass="error-message" Text="Label" ForeColor="Red" Visible="False"></asp:Label>
        </div>
    </div>
</asp:Content>
