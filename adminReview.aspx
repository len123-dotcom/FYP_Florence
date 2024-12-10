<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="adminReview.aspx.cs" Inherits="FYP_Florence.adminReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
     .container{  
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
     .review-title {
         font-size: 24px;
         margin-bottom: 20px;
     }
     .review-item {
         display: flex;
         align-items: center;
         margin-bottom: 20px;
         border-bottom: 1px solid #ddd;
         padding-bottom: 10px;
         gap:20px;
     }
     .review-item img {
         height: 100px;
         margin-right: 20px;
     }
     .review-item a {
         text-decoration: none;
         color: #005AE5;
         font-size: 18px;
         font-weight: bold;
     }
     .review-date {
         font-size: 14px;
         color: #888;
     }
     .stars {
         display: flex;
     }
     .stars div {
         width: 20px;
         height: 20px;
         background-size: cover;
     }
     .stars .filled {
         background-image: url('full_star.png'); 
     }
     .stars .empty {
         background-image: url('emptystar.png'); 
     }
     .order-item {
         display: flex;
         flex-direction: column;
         border: 1px solid #ddd;
         margin: 10px 0;
         width: 100%;
         padding: 20px;
         box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
     }
     .review-text {
        font-size: 16px;
        margin-top: 10px;
        color: #333;
     }
     .user-name {
            font-size: 14px;
            color: #555;
            margin-top: 5px;
     }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container">
        <h2 class="review-title">Your Review History</h2>
        <asp:Repeater ID="rptReviewHistory" runat="server">
            <ItemTemplate>
                <div class="order-item">
                    <div class="review-item">
                        <img src='<%# ResolveUrl("~/product/") + Eval("product_image") %>' alt='<%# Eval("product_name") %>' />
                        <div>
                            <p class="user-name">Reviewed by: <%# Eval("userName") %></p>
                            <p class="review-text"><%# Eval("ReviewText") %></p>
                            <div class="stars"><%# GenerateStarImages(Eval("Rating")) %></div>
                            <a href='productPage1.aspx?productID=<%# Eval("productID") %>'>
                                <%# Eval("product_name") %>
                            </a>
                            <p class="review-date">Reviewed on: <%# Eval("ReviewDate", "{0:MMMM dd, yyyy}") %></p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
