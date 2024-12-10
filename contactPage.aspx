<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="contactPage.aspx.cs" Inherits="FYP_Florence.contactPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="layoutStyling.css" rel="stylesheet" type="text/css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class = container-contact >
          <h1 style="font-family:inter; margin-bottom:30px;">Spot Our Store Location</h1>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.962095260567!2d106.85956420992828!3d-6.135795360127834!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f58042a582a7%3A0x6554084d8c326b3e!2sJl.%20Raya%20Komp.%20Sunter%20STS%2C%20RT.3%2FRW.18%2C%20Sunter%20Agung%2C%20Kec.%20Tj.%20Priok%2C%20Jkt%20Utara%2C%20Daerah%20Khusus%20Ibukota%20Jakarta%2C%20Indonesia!5e0!3m2!1sen!2smy!4v1715957150619!5m2!1sen!2smy" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>"
    </div>
    <div class ="container-contact" style="margin-top:-100px;">
        <div class="container-information">
            <h1 style="font-family:inter;">Store & Order Information</h1>
            <p style="font-family:inter;">Address: Jalan Agung Utara Blok O No.22, Sunter Agung, Jakarta, Indonesia</p>
            <p style="margin-bottom:25px; font-family:inter;"> Phone Number: +62 8161407832 </p>

            <h2 style="font-family:inter;">Additional Information</h2>
            <p style="margin-bottom:25px; font-family:inter;">Our store located inside house complex. As soon you found Total Buah Segar, turn left.</p>
            
            <h2 style="font-family:inter;">Opening Hours</h2>
            <p style="font-family:inter;" > Monday - Sunday</p>
            <p style="font-family:inter;">8AM - 6PM</p>
           
        </div>

    </div>


</asp:Content>
