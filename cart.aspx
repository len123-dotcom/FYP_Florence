<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="FYP_Florence.cartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
        <style>
	.container-cart {
		max-width: 1200px;
		margin: 1px;
		padding: 20px;
		display: flex;
		flex-direction: row;
		justify-content: space-between; 
		align-items: flex-start; 
		min-height: 100vh;	
	}

	.cart-item-container{
		display: flex;
		align-items: center;
	}
    .content{
		flex:1;
		margin-right:10px;
		width:750px;
	}

	.cart-item {
		display: flex; 
		margin-bottom: 20px; 
		border: 1px solid #ddd;
		margin: 10px;
		flex-direction: row;
		width: 90%;
		margin-left:20px;
	}

	.cart-item-image {
		width: 100px;
		height: auto;
		object-fit: cover;
		margin-left: 10px; 
		padding: 30px;
	}

	.cart-item-details {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: flex-start;
		margin-top:25px;
	}
	@font-face {
        font-family: 'poppinssemibold';
        src: url('poppins-semibold-webfont.woff2') format('woff2'), url('poppins-semibold-webfont.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

	@font-face {
		font-family: 'gilda_displayregular';
		src: url('gildadisplay-regular-webfont.woff2') format('woff2'),
			 url('gildadisplay-regular-webfont.woff') format('woff');
		font-weight: normal;
		font-style: normal;
	}
	.cart-item-name {
	  font-weight: bold;
	  margin-bottom: 5px; 
	  font-family: 'poppinssemibold';
	}

	.cart-item-price,
	.cart-item-quantity,
	.cart-item-total {
	  margin: 5px 0; 
	}

	.checkout{
        
        font-weight: normal;
        height:40px;
		width:100px;
        background:#3434eb;
        border: none;
        border-radius: 8px;
        color: #ffffff;
        font-family: "Inter";
		margin-left: 50px;
		margin-top:20px;
    }

	.checkout-box {
        width: 30%;
        background-color: #f8f8f8;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        margin-left: 20px;
		display: flex;
		flex-direction: column; 
		align-items: flex-start; 
		margin-top:30px;
    }

	.checkout-disabled {
		background-color: #3434eb8b; 
		color: #ffff; 
		cursor: not-allowed; 
	}
	.cart-item-checkbox {
		margin-left: 10px; 
		width: 20px; 
		height: 20px; 
	}


.quantity-control {
	display: flex;
	align-items: center;
	margin-top: 5px;
}

.quantity-input {
	width: 50px;
	text-align: center;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin: 0 5px;
}

.quantity-button {
	width: 25px;
	height: 25px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f8f8f8;
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: bold;
	cursor: pointer;
}

.error-message {
	color: red;
	font-size: 0.9em;
	margin-top: 5px;
}
.clear-items-link-container {
    position: absolute; 
    left:45%;
}



	</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-cart">
        <div class="content">
            <asp:GridView ID="cartGridView" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <div class="cart-item-container">
                                <asp:Image ID="cartItemImage" runat="server" ImageUrl='<%# "~/product/" + Eval("p_img") %>' CssClass="cart-item-image" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="p_name" HeaderText="Product Name" />
                    <asp:BoundField DataField="p_price" HeaderText="Price" DataFormatString="RM {0}" />
                    <asp:TemplateField HeaderText="Quantity">
                        <ItemTemplate>
                            <div class="quantity-control">
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="quantity-input" Text='<%# Bind("q") %>' AutoPostBack="true" OnTextChanged="QuantityTextBox_TextChanged"></asp:TextBox>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnRemove" runat="server" CommandName="Delete" CommandArgument='<%# Eval("productId") %>' Text="Remove" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="container-cart">
		    <div class="content">
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
		    </div>
        </div>
        <div class="checkout-box">
            <asp:Label ID="lblTotal" runat="server" Text="Total: Rp 0.00"></asp:Label>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Checkout" Visible="true" CssClass="checkout" />
        </div>
    </div>
</asp:Content>