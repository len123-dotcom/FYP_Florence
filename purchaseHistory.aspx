<%@ Page Title="" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="purchaseHistory.aspx.cs" Inherits="FYP_Florence.purchaseHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
        <style>

        .status-button.review {
            background-color: orange; 
        }

        .status-button.cancel {
            background-color: red; 
        }

        .status-button.arrived{
            background-color:saddlebrown;
        }

        .product-image {
            width: 100px;
            height: auto;
        }
        .customer-info {
            display: flex;
            flex-direction: column;
            flex: 2;
            padding-left:100px;
        }


    </style>

  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     
    <div class="container-order-history">
        <h1>All Orders</h1>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="order-tabs">
                <asp:LinkButton ID="lnkAllOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="All">All Orders</asp:LinkButton>
                <asp:LinkButton ID="lnkNewOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Pending">New Orders</asp:LinkButton>
                <asp:LinkButton ID="lnkPackedOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Packed">Pack</asp:LinkButton>
                <asp:LinkButton ID="lnkDeliveredOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Delivered">Delivery</asp:LinkButton>
                <asp:LinkButton ID="lnkCompletedOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Arrived">Arrived</asp:LinkButton>
            </div>
            <asp:Repeater ID="ordersRepeater" runat="server">
                <ItemTemplate>
                <div class="order-item-history">
                    <div class="order-item-history-header">
                        <span>Status: <%# Eval("OrderStatus") %></span>
                        <span>Order ID: <%# Eval("OrderID") %></span>
                        <div> <%# FormatDate(Eval("OrderDate")) %></div>
                    </div>
                    <div class="order-item-history-body">
                        <div class="product-info">
                            <img src='<%# ResolveUrl("~/product/" + Eval("ProductImage")) %>' alt='<%# Eval("ProductName") %>' class="product-image" />
                            <div class="product-details">
                                <div><%# Eval("ProductName") %></div>
                                <div><%# string.Format("{0} x Rp{1:#,###.00}", Eval("ProductQuantity"), Eval("ProductPrice")) %></div>
                                <div style="font-weight:bold;">Total: Rp <%# Eval("Total", "{0:#,###.00}") %></div>
                                <div style="color:blue"> <%# Eval("CustomerPayment") %></div>
                            </div>
                        </div>

                    <div class="customer-info">
                    <div><%# Eval("CustomerName") %></div>
                    <div><%# Eval("CustomerPhone") %></div>
                    <div><%# Eval("FullAddress") %></div>
                    
                        </br>
                    <asp:PlaceHolder ID="TrackingNumberPlaceholder" runat="server">
                        <%# string.IsNullOrEmpty(Eval("TrackingNumber").ToString()) ? "" : $"<div style='color: green;'>Tracking Number: {Eval("TrackingNumber")}</div>" %>
                    </asp:PlaceHolder>
                    <div class="arrived-date" style="color:red;"<%# Eval("ArrivedDate") != DBNull.Value ? "" : "display:none;" %>'>
                        Arrived Date: <%# FormatDate(Eval("ArrivedDate")) %>
                    </div>
                </div>
           
                <div class="status-buttons">     
                    <asp:Button ID="btnArrived" 
                        runat="server" 
                        Text="Arrived"
                        CommandName="UpdateStatus" 
                        CommandArgument='<%# Eval("OrderID") + "|Arrived|" + Container.ClientID %>' 
                        OnCommand="btnArrived_Command" 
                        CssClass="status-button arrived" 
                        Visible='<%# Eval("OrderStatus").ToString() == "Delivered" %>'
                        Enabled='<%# Eval("OrderStatus").ToString() == "Delivered" %>' />
                    <asp:Button ID="btnReview" runat="server" Text="Review" CommandName="ReviewOrder" CommandArgument='<%# Eval("OrderID") %>' OnCommand="btnReview_Command" CssClass="status-button review" Visible='<%# Eval("OrderStatus").ToString() == "Arrived" %>' />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="return confirmCancel(this);"  CommandName="CancelOrder" CommandArgument='<%# Eval("OrderID") %>' OnCommand="btnCancel_Command" CssClass="status-button cancel" Visible='<%# Eval("OrderStatus").ToString() == "Pending" %>' />
                </div>
            </div>
        </div>
    <%--</div>--%>
        </ItemTemplate>
       </asp:Repeater>
</ContentTemplate>
</asp:UpdatePanel>
</div>



    <script type="text/javascript">
        function updateArrivedStatus(orderId) {
            var orderItem = document.querySelector(`[data-orderid="${orderId}"]`);
            if (orderItem) {
                var arrivedDateElement = orderItem.querySelector('.arrived-date');
                var btnArrived = orderItem.querySelector('#btnArrived');
                var btnReview = orderItem.querySelector('#btnReview');

                if (arrivedDateElement) {
                    arrivedDateElement.style.display = '';
                    arrivedDateElement.textContent = 'Collected Date: ' + new Date().toLocaleString();
                }

                if (btnArrived) {
                    btnArrived.style.display = 'none';
                }

                if (btnReview) {
                    btnReview.style.display = '';
                }
            }
        }
</script>


<script type="text/javascript">
    function confirmCancel(button) {
        var result = confirm("Are you sure you want to cancel this order?");
        if (result) {
            return true;
        } else {
            return false;
        }
    }
                    </script>
    

</asp:Content>
