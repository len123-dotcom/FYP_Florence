<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="paymentdetails.aspx.cs" Inherits="FYP_Florence.paymentdetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>    
 <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Manrope:wght@200..800&display=swap" rel="stylesheet">
<link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
<style>

	 .container-payment {
        max-width: 1000px;
        margin: 20px auto;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }

    .payment-options, .payment-details {
        flex: 1;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .payment-options h2, .payment-details h2 {
    margin-top: 0;
    margin-bottom: 20px;
}
    .product-image {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 4px;
}

	 .radio-button-list {
        margin-bottom: 20px;
    }

    .radio-button-list label {
        margin-bottom: 10px;
    }
	.payment-label {
        margin-bottom: 10px;
    }

    .payment-label span {
        font-weight: bold;
    }
    

	
	.btn-confirm {
        background-color:  #3434eb;
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 4px;
        font-size: 16px;
    }

    .btn-confirm:hover {
        background-color: #0056b3; 
    }

    /* Responsive Design */
   @media (max-width: 768px) {
        .container {
            flex-direction: column; 
        }
        .payment-options, .payment-details {
            width: 100%; 
            margin-bottom: 20px;
        }
    }

	
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<a href="checkoutForm.aspx" class="arrow-link">
    <div class="arrow-container">
        <i class="fa-solid fa-arrow-left"></i>
        <div class="back-text">back</div>
    </div>
</a>



	<hr class="divider">
	<div class="container-payment">
        <div class="payment-options">
            <h2>Payment Method</h2>
            <div class="radio-button-list">
                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="PaymentMethod" Text="Debit/Credit Card" />
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="PaymentMethod" Text="Bank Transfer" />
            </div>
            <asp:Button ID="ConfirmButton" runat="server" Text="Confirm" OnClick="ConfirmButton_Click" CssClass="btn-confirm" />
        </div>
        <div class="payment-options">
            <h2>Payment Details</h2>
            <div class="payment-label">
                <span>Customer Name:</span> <asp:Label ID="lblCustomerName" runat="server" Text="" /><br />
                <span>Customer Phone:</span> <asp:Label ID="lblCustomerPhone" runat="server" Text="" /><br />
                <span>Total:</span> <asp:Label ID="lblTotalAmount" runat="server" Text="" /><br />
                <span>Shipping Cost:</span> <asp:Label ID="lblShippingCost" runat="server" Text="" /><br />
            </div>
            <div class="product-images" runat="server" id="productImagesContainer">
               <asp:PlaceHolder ID="productImagesPlaceholder" runat="server"></asp:PlaceHolder>
            </div>
            <asp:Label ID="errMsg" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>
