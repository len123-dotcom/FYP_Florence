<%@ Page Title="" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="custReview.aspx.cs" Inherits="FYP_Florence.custReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

<style>
    .product-image{
        width:120px;
        height:auto;
        
    }
    .error-message {
        color: red;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .empty{
        background:url("emptystar.png") no-repeat;
        cursor:pointer;
        width:30px;
        height:30px;
        background-size:contain;
    }

    .empty:hover{
        background: url('full_star.png') no-repeat;
        cursor:pointer;
        background-size: contain;
    }
    .container {
        max-width: 1200px;
        margin: 50px 300px;
        padding: 20px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        min-height: 100vh;
        background: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .filled{
        background: url("full_star.png") no-repeat;
        cursor:pointer;
        width:30px;
        height:30px;
        background-size:contain;
        display:inline-block;
    }
    .rating {
        display: flex;
        gap: 5px;
    }

    .rating-button{
        font-weight: normal;
        width: 145px;
        padding: 10px;
        background: #3434eb;
        border: none;
        border-radius: 10px;
        color: #ffffff;
        font-family: Inter;
        cursor: pointer;
    }
    .text-field.large {
        height: 200px;
        resize: vertical;
        width:500px;
    }
    .disabled-button {
        cursor: not-allowed;
        background-color: CornflowerBlue;
        color: white; 
    }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container">
    <h1 style="font-family:Inter; margin-bottom:10px;" >Product Review</h1>
        <asp:Image ID="imgProduct" runat="server" CssClass="product-image"/>
        <h2 style="font-family:Inter"><asp:Label ID="lblProductName" runat="server"></asp:Label></h2>
        <p style="font-family:Inter; margin-bottom:5px">Order Date: <asp:Label ID="lblOrderDate" runat="server"></asp:Label></p>
        <p style="font-family:Inter; margin-bottom:5px">Price: Rp<asp:Label ID="lblProductPrice" runat="server"></asp:Label></p>
        <p style="font-family:Inter; margin-bottom:5px">Quantity: <asp:Label ID="lblProductQuantity" runat="server"></asp:Label></p>
        <p style="font-family:Inter; margin-bottom:5px">Total: Rp<asp:Label ID="lblTotal" runat="server"></asp:Label></p>


    <div class="rating" style="margin-bottom:10px">
        <asp:Button ID="Rating1" CommandArgument="1" OnCommand="Decide" CssClass="empty" BorderStyle="None" runat="server" />
        <asp:Button ID="Rating2" CommandArgument="2" OnCommand="Decide" CssClass="empty" BorderStyle="None" runat="server" />
        <asp:Button ID="Rating3" CommandArgument="3" OnCommand="Decide" CssClass="empty" BorderStyle="None" runat="server" />
        <asp:Button ID="Rating4" CommandArgument="4" OnCommand="Decide" CssClass="empty" BorderStyle="None" runat="server" />
        <asp:Button ID="Rating5" CommandArgument="5" OnCommand="Decide" CssClass="empty" BorderStyle="None" runat="server" />
    </div>

     <asp:Label ID="lblRate" runat="server" Text="0" Visible=false></asp:Label>
    <p>
            <asp:TextBox ID="txtReview" runat="server" ClientIDMode="Static" CssClass="text-field large" TextMode="MultiLine" 
             placeholder="Write your review here"></asp:TextBox>
            <p class="word-count">Word Count: <span id="show">0</span> / 50</p>

    </p>
    <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="False"></asp:Label>
    <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" CssClass="rating-button" OnClick="btnSubmitReview_Click" />

    


</div>

    <script>
    function countWord(elementID) {
        var element = document.getElementById(elementID);
        if (element) {
            var words = element.value.trim();
            var wordCount = words.split(/\s+/).filter(word => word.length > 0).length;
            document.getElementById("show").innerText = wordCount;
        }
    }

    function limitWordCount(elementID, maxWords) {
        var textarea = document.getElementById(elementID);
        var text = textarea.value;
        var words = text.trim().split(/\s+/).filter(word => word.length > 0);
        var wordCount = words.length;

        if (wordCount > maxWords) {
            var lastSpaceIndex = text.trim().lastIndexOf(' ', text.length - 1);
            if (lastSpaceIndex !== -1) {
                textarea.value = text.substr(0, lastSpaceIndex);
            }
        }

        document.getElementById("show").innerText = Math.min(wordCount, maxWords);
    }

    document.addEventListener('DOMContentLoaded', function () {
        var descriptionTextbox = document.getElementById('txtReview');
        if (descriptionTextbox) {
            descriptionTextbox.addEventListener('input', function () {
                limitWordCount(this.id, 50);
            });

            descriptionTextbox.addEventListener('paste', function (e) {
                var pastedText = (e.clipboardData || window.clipboardData).getData('text');
                var currentText = this.value;
                var combinedText = currentText + pastedText;
                var words = combinedText.trim().split(/\s+/).filter(word => word.length > 0);

                if (words.length > 50) {
                    e.preventDefault();
                    alert("Pasted text would exceed the 50 word limit.");
                }
            });

            // Initial count
            countWord('txtReview');
        }
    });
</script>


</asp:Content>

