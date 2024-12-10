<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="loginPage.aspx.cs" Inherits="FYP_Florence.loginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

     <style>

        .text-field {
            background: transparent;
            margin: 10px 0 0;
            position: relative; 
            display: flex;
            flex-direction: column; 
            align-items: flex-start; 
        }   

        .text-field input[type="text"],
        .text-field input[type="password"] {
            line-height: 40px; 
            width: 100%;
            border-radius: 5px;
            padding-left: 40px; 
            font-family: Inter;
            box-sizing: border-box; 
        }

        .text-field .icon-container {
            position: absolute;
            top: 33%;
            left: 1%;
            transform: translateY(-50%);
            z-index: 1;
        }

        .error-message {
            color: #ff0000;
            font-size: 12px;
            font-family: Inter;
            margin-top: 3px; 
            align-self: flex-start;
        }



        .inter-<uniquifier> {
          font-family: "Inter", sans-serif;
          font-optical-sizing: auto;
          font-weight:normal;
          font-style: normal;
                    
        }
        .error-container {
            margin-bottom: 15px;
            min-height: 20px; 
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-reglog" style="height: fit-content;">
        <div class="form-box-reglog">
            <h1> Welcome Back!</h1>
            <img src="smilenew.png" style="width:50px"/>
            <p>Hi dear, welcome back! We're happy to see you again:)</p>

            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-user"></i>
                </span>
                <asp:TextBox ID="logEmail" autocomplete="off" placeholder="Email" runat="server" style="padding-left: 43px; font-family:Inter"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="logEmail" CssClass="error-message" ErrorMessage="Username is Required!" ForeColor="Red" Visible="True"></asp:RequiredFieldValidator>
            </div>

            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-lock"></i>
                </span>
                <asp:TextBox runat="server" ID="logPass" placeholder="Password" style="padding-left: 43px; font-family:Inter;" TextMode="Password" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="logPass" CssClass="error-message" ErrorMessage="Password is Required!" Visible="True"></asp:RequiredFieldValidator>
            </div>

            <div class="error-container">
                <asp:Label ID="errMsg" runat="server" Visible="False" BorderStyle="None" CssClass="error-message" Text="Email or Password is Incorrect!"></asp:Label>
            </div>

            <div>
                <asp:Button ID="LoginButton" runat="server" Text="LOGIN" CssClass="reglog-Button" OnClick="LoginButton_Click"/>                 
            </div>

            <div style="margin-top: 10px; font-family:Inter;">
                <span>Don't have an account? </span>
                <a href="registerPage.aspx">Register here</a>
            </div>


            <div style="margin-top: 10px; font-family:Inter;">
                <a href="forgotPassword.aspx">Forgot Password?</a>
            </div>
        </div>

    </div>    

</asp:Content>
