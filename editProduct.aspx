<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="editProduct.aspx.cs" Inherits="FYP_Florence.editProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

       <style>
        @font-face {
            font-family: 'poppinssemibold';
            src: url('poppins-semibold-webfont.woff2') format('woff2'), 
                 url('poppins-semibold-webfont.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        .container {
            width: 80%;
            margin: auto 200px;
            padding: 20px;
            font-family: 'poppinssemibold', sans-serif;
        }

        .image-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .image-section img {
            max-width: 100%;
            height: auto;
            max-height: 300px;
        }

        .form-section {
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            border: 2px solid #ddd;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .text-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .text-field.large {
            height: 200px;
            resize: vertical;
        }

        .description-container {
            position: relative;
        }

        .word-count {
            position: absolute;
            bottom: -20px;
            right: 0;
            font-size: 12px;
            color: #666;
        }

        .button-group {
            margin-top: 20px;
        }

        .button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .button-save {
            background-color: #3434eb;
            color: white;
        }

        .button-delete {
            background-color: #ff4444;
            color: white;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        .input-container {
            position: relative;
            margin-bottom: 20px;
        }

        .input-container .word-count {
            position: absolute;
            bottom: -20px;
            right: 0;
            font-size: 12px;
            color: #666;
            margin: 0;
        }

        .form-group {
            margin-bottom: 25px;  
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="image-section">
            <asp:Image ID="productImage" runat="server" />
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>
        </div>

        <div class="form-section">
            <div class="form-group">
                <label for="editProductName">Product Name:</label>
                <div class="input-container">
                    <asp:TextBox ID="editProductName" runat="server" ClientIDMode="Static"  CssClass="text-field" placeholder="Enter product name"></asp:TextBox>
                    <p class="word-count">Word Count: <span id="show1">0</span> / 15</p>
                </div>
            </div>

            <div class="form-group">
                <label for="editProductPrice">Product Price:</label>
                <asp:TextBox ID="editProductPrice" runat="server" CssClass="text-field" placeholder="Enter product price"></asp:TextBox>
                <asp:Label ID="errMsgprice" runat="server" CssClass="error-message" Visible="False"></asp:Label>
            </div>

            <div class="form-group">
                <label for="editProductDescription">Product Description:</label>
                <div class="description-container">
                    <asp:TextBox ID="editProductDescription" runat="server" ClientIDMode="Static" 
                                 CssClass="text-field large" TextMode="MultiLine" 
                                 placeholder="Enter product description"></asp:TextBox>
                    <p class="word-count">Word Count: <span id="showdesc">0</span> / 250</p>
                </div>
            </div>

            <div class="form-group">
                <label for="editProductQuantity">Product Quantity:</label>
                <asp:TextBox ID="editProductQuantity" runat="server" TextMode="Number" CssClass="text-field" placeholder="Enter product quantity"></asp:TextBox>
            </div>

            <asp:Label ID="LabelError" runat="server" CssClass="error-message"></asp:Label>
            <p id="ErrorMessage" runat="server" class="error-message" visible="false"></p>

            <div class="button-group">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="button button-save" OnClick="ButtonSave_Click"/>
                <asp:Button ID="ButtonDelete" runat="server" Text="Delete Product" CssClass="button button-delete" OnClick="ButtonDelete_Click"/>
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
            var nameTextbox = document.getElementById('editProductName');
            var descriptionTextbox = document.getElementById('editProductDescription');

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

                countWordName('editProductName');
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

                countWordDescription('editProductDescription');
            }
        });
</script>
</asp:Content>


