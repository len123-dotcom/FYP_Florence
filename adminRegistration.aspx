<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="adminRegistration.aspx.cs" Inherits="FYP_Florence.adminRegistration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

    <style>

        .error-email {
            position: absolute;
            top: 53%;
            left: 110px;
            font-size: 16px;
        }

        .pass-error {
            position: absolute;
            top: 77%;
            left: 111px;
            font-size:16px;
        }
        .error-message {
            position: absolute;
            font-size: 16px;
            color: red;
            margin-top: 5px;
            top:64%;
            left:18%;
            
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-box-profile">
        <h1 style="font-family:inter; margin-bottom:10px;"> Admin Registration</h1>
        <img src="smilenew.png" style="width:30px"/>
        <p style="font-family:Inter">Hi dear admin. Please fill in all the fields to set up your account.</p>
            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-user"></i>
                </span>
                <asp:TextBox ID="regName" runat="server" placeholder="Name" style="padding-left: 40px;"></asp:TextBox>               
            </div>

            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-envelope"></i>
                </span>
                <asp:TextBox ID="regEmail" AutoCompleteType="Email" runat="server" placeholder="Email" style="padding-left:40px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="regEmail" ErrorMessage="Please Enter a valid email address!" CssClass="error-email" ForeColor="red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

            </div>
            


            <div class="text-field">
                <span class="icon-container">
                    <i class="fa-solid fa-lock"></i>
                </span>
                <input id="regPass" type="password" runat="server" placeholder="Password" style="padding-left: 40px;" />
            </div>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="regPass" CssClass="error-message" ErrorMessage="Minimum 8 Characters!"  OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            
                <div class="text-field">
                    <span class="icon-container">
                        <i class="fa-solid fa-lock"></i>
                    </span>
                    <input id="confirmPass" type="password" runat="server" placeholder="Confirm Password" style="padding-left: 40px;" />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="regPass" ControlToValidate="confirmPass" CssClass="pass-error" ErrorMessage="The password doesn't match!" ForeColor="red"></asp:CompareValidator>
                </div>

                <div>
                    <asp:Button ID="Button2" runat="server" Text="REGISTER" CssClass="reglog-Button" height="40px" style="padding:6px" OnClick="Button2_Click"/>                    

                </div> 
                
                <div>
                    <asp:Label ID="errMsg" runat="server" Text="Label"  Font-Bold="True" Font-Size="16px" ForeColor="red" Visible="False" ></asp:Label>
                </div>
       
         
        <div>
    </div>
</div>
   


</asp:Content>
