<%@ Page Title="" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="editProfile.aspx.cs" Inherits="FYP_Florence.editProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <style>
        .error-message{
            position: absolute;
            left: 20%;
            top: 75%; 
            width: 100%;
            color: red;
            font-size: 12px;
            margin-top: 2px;
            text-align: left;
        }
        .form-box-profile h1,p{
            font-family:'Inter' 
        }
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
            <div class="form-box-profile">
                <h1> Edit Profile</h1>
                 <img src="smilenew.png" style="width:50px"/>
                 <p>Hi dear, feel free to update your profile.</p>

                <div class="text-field">
                    <span class="icon-container">
                       <i class="fa-solid fa-user"></i>
                   </span>
                    
                       <asp:TextBox ID="editName" placeholder="Name" runat="server" style="padding-left: 40px;font-family:Inter;"></asp:TextBox>
                    </div>

                 <div class="text-field">
                     <span class="icon-container">
                        <i class="fa-solid fa-envelope"></i>
                    </span>
                    <asp:TextBox ID="editEmail" runat="server" placeholder="Email" Visible="True" style="padding-left: 40px; font-family:Inter;" TextMode="Email"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="editEmail" ErrorMessage="Please Enter a valid email address!" CssClass="auto-style18" style="top:45%; left: 20%;" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </div>

                 <div class="text-field">
                    <span class="icon-container">
                        <i class="fa-solid fa-venus-mars"></i>
                    </span>
                    <asp:DropDownList ID="editGender" runat="server" CssClass="dropdown">
                        <asp:ListItem Value="MALE">MALE</asp:ListItem>
                        <asp:ListItem Value="FEMALE">FEMALE</asp:ListItem>
                    </asp:DropDownList>

                </div>


                <div class="text-field">
                    <span class="icon-container">
                        <i class="fa-solid fa-calendar"></i>
                    </span>
                    <asp:TextBox ID="editBirthDate" runat="server" placeholder="Birth Date" TextMode="Date" Visible="True" style="padding-left: 40px; font-family:Inter;" ></asp:TextBox>
                    <asp:CustomValidator ID="BirthDateValidator" runat="server" 
                        ControlToValidate="editBirthDate" 
                        CssClass="error-message" 
                        ErrorMessage="You must be at least 17 years old!" 
                        OnServerValidate="BirthDateValidator_ServerValidate"
                        ValidateEmptyText="true" style="top:65%">
                    </asp:CustomValidator>
                </div>



                <div class="text-field">
                    <span class="icon-container">
                        <i class="fa-solid fa-lock"></i>
                    </span>
                    <asp:TextBox ID="editPass" runat="server" Visible="True" style="padding-left: 40px; font-family:Inter;" placeholder="Password" />
                    <asp:CustomValidator ID="PasswordValidator" runat="server" ControlToValidate="editPass" OnServerValidate="PasswordValidator_ServerValidate" ErrorMessage="Password must be at least 8 characters long" CssClass="error-message" Display="Dynamic"></asp:CustomValidator>
                </div>


                <div>
                    <asp:Label ID="errMsg" runat="server" Text="Label" CssClass="auto-style15" Font-Size="12px" ForeColor="Red" Visible="False"></asp:Label>
                </div>

                <div>
                    <asp:Button ID="UpdateButton" runat="server"  Text="Update" CssClass="update-btn" OnClick="UpdateButton_Click" />
                </div>

            </div>
</asp:Content>
