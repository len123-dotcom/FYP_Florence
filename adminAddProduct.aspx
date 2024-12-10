<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="adminAddProduct.aspx.cs" Inherits="FYP_Florence.adminAddProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">


     <style>

        .container {
      
            width: 100%;
            height: 900px;
            background-color:white;
            background-position: center;
            background-size: cover;
            background-repeat: no-repeat;
        }
        .text-field {
            /*background: transparent;
            margin: 8px;
            text-align: left;*/
            position: relative;
            margin-bottom: 10px;
            margin-top:10px;
        } 

        .text-field input[type="text"],
        .text-field input[type="number"]{
            line-height: 30px; 
            width: 500px;
            border-radius:5px;
        }

        .text-field textarea {
            line-height: 30px; 
            width: 500px;
            border-radius: 5px;
            height: 200px;
            resize: none; 
        }


        .form-box{
            width: 95%;
            max-width: 600px;
            position: absolute;
            top: 10%;
            left: 30%;
            background: #ffffff;
            padding: 50px 60px 70px;
            text-align: center;
            border-radius: 8px;
            border: 2px solid lightgrey;
        }

         @font-face {
            font-family: 'poppinssemibold';
            src: url('poppins-semibold-webfont.woff2') format('woff2'),
                 url('poppins-semibold-webfont.woff') format('woff');
            font-weight: normal;
            font-style: normal;
         }

        .saveProduct {
            
            background: #3434eb;
            border-radius: 8px;
            color: #ffffff;
            font-family:"Inter";
            border:none;
            cursor:pointer;
            height:40px;
            width:100px;
            font-size:14px;
        }

        .form-box p{
        }

        .form-box h3{
            text-align: left; 
            font-family:Inter; 
            font-size:15px; 
           
        }

        .field-container {
            position: relative;
            margin-bottom: 20px;
        }

        .helper-text {
            font-family: poppinssemibold;
            font-size: 10px;
            color: grey;
            text-align: left;
            margin-top: 4px;
            margin-bottom: 4px;
        }

        .error-message {
            display: block;
            font-size: 16px;
            color: red;
            text-align: left;
            margin-top: 4px;
        }

        .description-container {
            position: relative;
            margin-bottom: 10px;
        }

        .word-count {
            position: absolute;
            bottom: -20px;
            right: 0;
            font-size: 12px;
            color: #666;
            margin: 0;
        }


    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class ="container">
        <div class="form-box">

            <h2 style="font-family:poppinssemibold; margin-bottom:12px;"> General Information</h2>
            <p style="font-family:poppinssemibold; font-size: 10px; color: lightslategrey; padding-bottom: 10px;" >Hi Seller! Please provide the product information clearly!</p>

            <h3>Product Name</h3>
            <div class="text-field">
                <asp:TextBox ID="product_name" ClientIDMode="Static" placeholder="Example: Juhi Pangkong" runat="server"></asp:TextBox>
                <p class="word-count">Word Count: <span id="show1">0</span> / 15</p>
            </div>
            <div>
                <p style="font-family:poppinssemibold; font-size: 10px; color:grey; text-align:left; margin-bottom:12px;">A product name is required and recommended to be unique.</p>
            </div>
                
            <h3>Product Price</h3>
        <div class="field-container">
            <div class="text-field">
                <asp:TextBox ID="product_price" placeholder="Example: 12000" runat="server"></asp:TextBox>
            </div>
            <p class="helper-text">Set product price without a coma or dot.</p>
            <asp:Label ID="errMsgprice" runat="server" Text="Label" CssClass="error-message" Visible="False"></asp:Label>
        </div>

        <h3>Product Description</h3>
            <div class="description-container">
                <div class="text-field">
                    <asp:TextBox ID="product_description" ClientIDMode="Static" placeholder="Ingredients: chilli, garlic, and sugar" runat="server" style="height: 200px;" TextMode="MultiLine"></asp:TextBox>
                </div>
                <p class="word-count">Word Count: <span id="showdesc">0</span> / 250</p>
            </div>
            <p style="font-family:poppinssemibold; font-size: 10px; color:grey; text-align:left; margin-bottom:12px;">Set product description.</p>
                 
                 

            <h3>Product Quantity</h3>
            <div class="text-field" style="margin-bottom:15px;">
                <asp:TextBox ID="product_quantity" placeholder="Example: 12" runat="server" TextMode="Number"></asp:TextBox>
            </div>

            <h3>Product Image</h3>
            <div class="field-container">
            <div class="text-field">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>
        </div>
        <asp:Label ID="errMsgEmail" runat="server" Text="Label" CssClass="error-message" Visible="False" ></asp:Label>


            <asp:Button ID="saveProduct" runat="server" Text="Save" CssClass="saveProduct" OnClick="saveProduct_Click"/>
            <div>
            <asp:Label ID="errMsg" runat="server" Text="Label" Font-Size="16px" ForeColor="Red" Visible="False" ></asp:Label>
        </div>

    </div>
</div>

         <script>
             function countWordName(elementID) {
                 var element = document.getElementById(elementID);
                 if (element) {
                     var words = element.value.trim();
                     var wordCount = words.split(/\s+/).filter(word => word.length > 0).length;
                     document.getElementById("show1").innerText = wordCount;
                 }
             }

             function countWordDescription(elementID) {
                 var element = document.getElementById(elementID);
                 if (element) {
                     var words = element.value.trim();
                     var wordCount = words.split(/\s+/).filter(word => word.length > 0).length;
                     document.getElementById("showdesc").innerText = wordCount;
                 }
             }

             function limitWordCountName(elementID, maxWords) {
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

                 document.getElementById("show1").innerText = Math.min(wordCount, maxWords);
             }

             function limitWordCountDescription(elementID, maxWords) {
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

                 document.getElementById("showdesc").innerText = Math.min(wordCount, maxWords);
             }

             document.addEventListener('DOMContentLoaded', function () {
                 var nameTextbox = document.getElementById('product_name');
                 var descriptionTextbox = document.getElementById('product_description');

                 if (nameTextbox) {
                     nameTextbox.addEventListener('input', function () {
                         limitWordCountName(this.id, 15);
                     });

                     nameTextbox.addEventListener('paste', function (e) {
                         var pastedText = (e.clipboardData || window.clipboardData).getData('text');
                         var currentText = this.value;
                         var combinedText = currentText + pastedText;
                         var words = combinedText.trim().split(/\s+/).filter(word => word.length > 0);

                         if (words.length > 15) {
                             e.preventDefault();
                             alert("Pasted text would exceed the 15 word limit.");
                         }
                     });

                     countWordName('product_name');
                 }

                 if (descriptionTextbox) {
                     descriptionTextbox.addEventListener('input', function () {
                         limitWordCountDescription(this.id, 250);
                     });

                     descriptionTextbox.addEventListener('paste', function (e) {
                         var pastedText = (e.clipboardData || window.clipboardData).getData('text');
                         var currentText = this.value;
                         var combinedText = currentText + pastedText;
                         var words = combinedText.trim().split(/\s+/).filter(word => word.length > 0);

                         if (words.length > 250) {
                             e.preventDefault();
                             alert("Pasted text would exceed the 250 word limit.");
                         }
                     });

                     countWordDescription('product_description');
                 }
             });
</script>
</asp:Content>
