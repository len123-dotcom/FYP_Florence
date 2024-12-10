<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="orderPage.aspx.cs" Inherits="FYP_Florence.orderPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
    <style>
        .customer-info {
            display: flex;
            flex-direction: column;
            flex: 2;
            padding-left:200px;
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
                    <asp:LinkButton ID="lnkDeliveredOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Delivered">Delivered</asp:LinkButton>
                    <asp:LinkButton ID="lnkCompletedOrders" runat="server" OnClick="OrderTab_Click" CommandArgument="Arrived">Arrived</asp:LinkButton>
                </div>

        <asp:Repeater ID="ordersRepeater" runat="server">
            <ItemTemplate>
                <div class="order-item-history" style="margin-bottom: 10px;">
                    <div class="order-item-history-header">
                        <span style="font-weight:bold;"><%# Eval("OrderStatus") %></span>
                        <span><%# FormatDate(Eval("OrderDate")) %></span>
                        <span>Order ID: <%# Eval("OrderID") %></span>
                    </div>
                    <div class="order-item-history-body">
                        <div class="product-info">
                            <img src='<%# ResolveUrl("~/product/" + Eval("ProductImage")) %>' alt='<%# Eval("ProductName") %>' class="order-item-history-product-image" />
                            <div class="product-details">
                                <div><%# Eval("ProductName") %></div>
                                <div><%# string.Format("{0} x Rp{1:#,###.00}", Eval("ProductQuantity"), Eval("ProductPrice")) %></div>
                                <div style="font-weight:bold;">Total: Rp <%# Eval("Total", "{0:#,###.00}") %></div>
                                <div style="color:blue"> <%# Eval("CustomerPayment") %></div>
                            </div>
                        </div>
                        <div class="customer-info">
                            <div> <%# Eval("CustomerName") %></div>
                            <div> <%# Eval("FullAddress") %></div>
                            <div> <%# Eval("CustomerPhone") %></div>
                        </div>
                        <div style="flex: 1;"></div> 
                        <div>
                            <div style="color:red">
                                
                                <%# Eval("ArrivedDate") != DBNull.Value ?
                                    FormatDate(Eval("ArrivedDate")) :
                                    " " %>
                            </div>
                            </br>
                            <asp:PlaceHolder ID="TrackingNumberPlaceholder" runat="server">
                                <%# string.IsNullOrEmpty(Eval("TrackingNumber").ToString()) ? "" : $"<div style='color: green;'>Tracking Number: {Eval("TrackingNumber")}</div>" %>
                            </asp:PlaceHolder>

                        </div>
                    </div>
                    <div class="status-buttons">
                        <asp:Button
                            ID="btnPacked"
                            runat="server"
                            Text="Packed"
                            CommandName="UpdateStatus"
                            CommandArgument='<%# Eval("OrderID") + "|Packed" %>'
                            OnCommand="UpdateStatus_Command"
                            CssClass='<%# Eval("OrderStatus").ToString() == "Packed" || Eval("OrderStatus").ToString() == "Delivered" || Eval("OrderStatus").ToString() == "Arrived" ? "status-button disabled" : "status-button" %>'
                            Enabled='<%# Eval("OrderStatus").ToString() != "Packed" && Eval("OrderStatus").ToString() != "Delivered" && Eval("OrderStatus").ToString() != "Arrived" %>'
                            Style='<%# (Eval("OrderStatus").ToString() == "Packed" || Eval("OrderStatus").ToString() == "Delivered" || Eval("OrderStatus").ToString() == "Arrived") ? "background-color: #ffa6a6; color: #ffffff;" : "background-color: #ff5733; color: #ffffff;" %>' />
  
                        <asp:Button
                            ID="btnDelivered"
                            runat="server"
                            Text="Delivered"
                            CommandName="ShowTrackingInput"
                            CommandArgument='<%# Eval("OrderID") %>'
                            OnCommand="ShowTrackingInput_Command"
                            CssClass="status-button"
                            Style='<%# Eval("OrderStatus").ToString() == "Delivered" || Eval("OrderStatus").ToString() == "Arrived" ? "background-color: #c3e6c3; color: #ffffff; cursor: not-allowed;" : "background-color: #6be557; color: #ffffff;" %>'
                            Enabled='<%# Eval("OrderStatus").ToString() != "Delivered" && Eval("OrderStatus").ToString() != "Arrived" %>'
                        />

                    </div>
                    <div class="text-field" style="display: none;" id="trackingInput_<%# Eval("OrderID") %>">
                        <asp:TextBox ID="txtTrackingNumber" runat="server" Placeholder="Enter Tracking Number" style="width:200px;"></asp:TextBox>
                        <asp:Button ID="btnSaveTrackingNumber" runat="server" Text="Save" OnClick="SaveTrackingNumber_Click" CommandArgument='<%# Eval("OrderID") %>' CssClass="reglog-Button" />
                        <asp:Button ID="btnCancelTracking" runat="server" Text="Cancel" OnClick="CancelTracking_Click" CommandArgument='<%# Eval("OrderID") %>' CssClass="reglog-Button" style="background-color:red;" />
                        <asp:Label ID="lblTrackingError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                    </div>
        </div>
            </ItemTemplate>
        </asp:Repeater>
    </ContentTemplate>
    </asp:UpdatePanel>
 </div>

    

    <script>

        function showTrackingInput(orderId) {
            var trackingInput = document.getElementById("trackingInput_" + orderId);
            trackingInput.style.display = "block";
        }
    </script>


    <script>
        function showTrackingInput(orderId) {
            var trackingInput = document.getElementById("trackingInput_" + orderId);
            trackingInput.style.display = "block";
            var txtTrackingNumber = trackingInput.querySelector('input[type="text"]');
            if (txtTrackingNumber) {
                txtTrackingNumber.value = '';
            }
            var lblTrackingError = trackingInput.querySelector('span[id$="lblTrackingError"]');
            if (lblTrackingError) {
                lblTrackingError.style.display = 'none';
            }
        }
                    </script>
</asp:Content>