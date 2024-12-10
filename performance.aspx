<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="performance.aspx.cs" Inherits="FYP_Florence.performance" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

     <style>
        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            margin:100px auto;
        }

        .form-box-gender {
            background: #ffffff;
            padding: 10px 19px 10px;
            text-align: center;
            border-radius: 8px;
            border: 2px solid lightgrey;
            margin: 10px;
        }

        .charts-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 20px;
            width: 100%;
        }

        .charts-container > div {
            /*flex: 1 1 calc(50% - 40px);*/ 
            max-width: calc(50% - 40px);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="margin-top:30px; margin-left:190px;">Store Performance Chart</h1>
    <div class="charts-container">
        <div class="form-box-gender">
            <asp:Chart ID="TotalRegisteredChart" runat="server" Width="500px">
                <Series>
                    <asp:Series Name="TotalRegisteredSeries" ChartType="Column"></asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                </ChartAreas>
                <Titles>
                    <asp:Title Text="Total Registered Users by Gender"></asp:Title>
                </Titles>
            </asp:Chart>

        </div>
        <div class="form-box-gender">
            <asp:Chart ID="BuyerGenderChart" runat="server" Width="500px">
                <Series>
                    <asp:Series Name="BuyerGenderSeries" ChartType="Pie" Label="#VALX: #PERCENT{P2}"></asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea2"></asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Title="Buyer Gender Distribution"></asp:Legend>
                </Legends>
            </asp:Chart>
        </div>
        <div class="form-box-gender">
            <asp:Chart ID="BuyerAgeChart" runat="server" Width="500px">
                <Series>
                    <asp:Series Name="BuyerAgeSeries" ChartType="Column"></asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea3"></asp:ChartArea>
                </ChartAreas>
                <Titles>
                    <asp:Title Text="Buyer Age Distribution"></asp:Title>
                </Titles>
            </asp:Chart>
        </div>

        <div class="form-box-gender">
            <asp:Chart ID="RevenuePerProductChart" runat="server" Width="500px">
            <Series>
                <asp:Series Name="RevenuePerProductSeries" ChartType="Bar">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea4">
                    <AxisX Title="Product Name" Interval="1">
                        <MajorGrid Enabled="False" />
                    </AxisX>
                    <AxisY Title="Total Revenue">
                        <MajorGrid LineColor="LightGray" />
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title Text="Revenue Per Product"></asp:Title>
            </Titles>
        </asp:Chart>
        </div>

    </div>
    
</asp:Content>
