<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="registerPage.aspx.cs" Inherits="FYP_Florence.registerPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
        <link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />

    <style>

        .text-field .dropdown {
            line-height: 40px;
            width: 400px;
            border-radius: 5px;
            padding-left: 40px; 
            font-family: Inter;
            -webkit-appearance: none; 
            -moz-appearance: none;
            border-color:black;
            border-width:2px;
            margin-left:-5px;
        }

        .linkbtn-container{
            margin:10px auto;
        }
        .linkbtn {
            font-size: 13px;
            font-family: "Inter";
        }

        .inter-<uniquifier> {
          font-family: "Inter", sans-serif;
          font-optical-sizing: auto;
          font-weight:normal;
          font-style: normal;   
        }

        .text-field {
            position: relative;
            margin-bottom: 30px; 
        }

        .text-field input[type="text"],
        .text-field input[type="password"],
        .text-field input[type="date"],
        .text-field .dropdown {
            width: 100%;
            line-height: 40px;
            border-radius: 5px;
            padding: 0 10px 0 40px; 
            font-family: Inter;
            box-sizing: border-box;
        }
        .error-message,
        .emailerror,
        .auto-style12,
        .passerror {
            position: absolute;
            left: 30px;
            top: 100%; 
            width: 100%;
            color: red;
            font-size: 12px;
            margin-top: 2px;
            text-align: left;
        }

        .emailerror,
        .auto-style12,
        .passerror {
            position: static;
        }


    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-reglog">
        <div class="form-box-reglog">
            <h1>Register Yourself</h1>
            <img src="smilenew.png" style="width:50px"/>
            <p>Hi customer, welcome to our squid snack store. Please fill in all the fields to set up your account.</p>
        
        <div class="text-field">
            <span class="icon-container">
               <i class="fa-solid fa-user"></i>
            </span>
            <asp:TextBox ID="regName" placeholder="Name" runat="server" CssClass="input-field"></asp:TextBox>
        </div>

        <div class="text-field">
            <span class="icon-container">
                <i class="fa-solid fa-envelope"></i>
            </span>
            <asp:TextBox ID="regEmail" AutoCompleteType="Email" runat="server" placeholder="Email" CssClass="input-field"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="regEmail" ErrorMessage="Please Enter a valid email address!" CssClass="error-message" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        </div>

         <div class="text-field">
            <span class="icon-container">
                <i class="fa-solid fa-venus-mars"></i>
            </span>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="dropdown">
                <asp:ListItem Value="" Text="Select Gender" Selected="True"></asp:ListItem>
                <asp:ListItem Value="MALE">MALE</asp:ListItem>
                <asp:ListItem Value="FEMALE">FEMALE</asp:ListItem>
            </asp:DropDownList>

             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="DropDownList1"
                InitialValue=""
                ErrorMessage="Please select a gender"
                Display="Dynamic" CssClass="error-message">
            </asp:RequiredFieldValidator>
        </div>


        <div class="text-field">
            <span class="icon-container">
                <i class="fa-solid fa-calendar"></i>
            </span>
            <asp:TextBox ID="regBirthDate" runat="server" placeholder="Birth Date" TextMode="Date" CssClass="input-field"></asp:TextBox>
            <asp:CustomValidator ID="BirthDateValidator" runat="server" 
                ControlToValidate="regBirthDate" 
                CssClass="error-message" 
                ErrorMessage="You must be at least 17 years old to register!" 
                OnServerValidate="BirthDateValidator_ServerValidate"
                ValidateEmptyText="true">
            </asp:CustomValidator>
        </div>


        <div class="text-field">
            <span class="icon-container">
                <i class="fa-solid fa-lock"></i>
            </span>
            <input id="regPass" type="password" runat="server" placeholder="Password" class="input-field" />
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="regPass" CssClass="error-message" ErrorMessage="Minimum 8 Characters!" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
        </div>

        <div class="text-field">
            <span class="icon-container">
                <i class="fa-solid fa-lock"></i>
            </span>
            <input id="confirmPass" type="password" runat="server" placeholder="Confirm Password" class="input-field" />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="regPass" ControlToValidate="confirmPass" CssClass="error-message" ErrorMessage="The password doesn't match!"></asp:CompareValidator>
        </div>

        <div>
            <asp:Button ID="Button2" runat="server" Text="REGISTER" CssClass="reglog-Button" OnClick="Button2_Click"/>                
        </div>

        <div>
            <asp:Label ID="errMsg" runat="server" Text="Label" Font-Size="12px" ForeColor="Red" Visible="False"></asp:Label>
        </div>

        <div class="linkbtn-container">
            <span style="font-family:'Inter'; color:blue;">Already have an account? </span>
            <a href="loginPage.aspx" style="font-family: Inter">Login here</a>
        </div>


    </div>
</div>


</asp:Content>
 