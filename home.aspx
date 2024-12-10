 <%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="FYP_Florence.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
    <link href="layoutStyling.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .inter-<uniquifier> {
          font-family: "Inter", sans-serif;
          font-optical-sizing: auto;
          font-weight:normal;
          font-style: normal;
          
        }

        .offer {
            background-color: #EADBC8;
        }

        .row {
            display: flex;
            min-height: 100vh;
        }

        .col-2 {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .image-column {
            background-color: #EADBC8;
            padding: 50px;
        }

        .text-column {
            background-color: #F5F5F5;
            padding: 50px;
        }

        .offer-img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }

        .content {
            max-width: 80%;
        }

        h1 {
            font-family: 'gilda_displayregular', serif;
            font-size: 48px;
            color: #333;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        h1 span {
            color: #005AE5;
        }

        p {
            font-size: 24px;
            color: #666;
            margin-bottom: 15px;
        }

        small {
            font-size: 16px;
            color: #777;
            display: block;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            background: #005AE5;
            color: #fff;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
            font-family:"Inter";
        }

        .btn:hover {
            background: #0046b8;
        }
        .key-feature{
		    padding-top:100px;
		    text-align:center;
	    }

	    .key-feature .col-4{
		    text-align:center;
            background-color:#FEFAF6;
            border-radius:8px;
            border:outset;
	    }

	    .key-feature .col-4 image{
		    width: 50px;
		    margin-top:20px;
		    border-radius:50%;
	    }

	    .key-feature p {
		    line-height: 1.5; /* Adjust as needed */
	    }
        .small-container-review {
  		    max-width: 1080px;
  		    margin: auto;
  		    padding-left: 25px;
  		    padding-right: 25px;
        }
        .row-review {
            margin-top: 5%;
            display: flex;
            justify-content: space-between;
            gap:30px;
        }
	    .col-4{
		    flex-basis: 20%;
		    padding: 10px;
		    min-height: 200px;
		    margin-bottom: 50px;
	    }
    
        .logo-section{
        display:flex;
        flex-direction:column;
    }
    .logo-item{
        display:flex;
    }

    .logo-item img {
        border-radius: 50%;
        margin-right: 15px; 
    }

    .text-content {
        display: flex;
        flex-direction: column;
    }
    .description{
        font-size: 12px;
        color: #333;
        padding-right: 140px;
        font-family:Inter;
    }
    .text-content h3{
        margin-bottom:1px;
    }
    .container-last {
        max-width: 1300px;
        margin: 0 auto;
        padding-left: 1px;
        padding-right: 1px;
    }

    .row-last {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        justify-content: space-around;
    }

    .col-2-last {
        flex-basis: 50%;
        min-width: 300px;
    }

    .col-2-last img {
        max-width: 100%;
        padding: 50px 0px;
        width: 400px;
    }
    .text-content h3{
        font-family:Inter;
    }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <div class="offer">
        <div class="row">
            <div class="col-2 image-column">
                <img src="home1.png" class="offer-img" alt="Sotong dish" />
            </div>
            <div class="col-2 text-column">
                <div class="content">
                    <h1>Find The Taste You've Never <span>Experienced</span> Before!</h1>
                    <p>Collection of Taste</p>
                    <small>Discover the Unmatched Flavor of Fresh Sotong - A Taste Adventure You'll Crave Every Day! Experience the Perfect Blend of Tenderness and Rich, Ocean-Fresh Flavor with Every Bite.</small>
                    <a href="productCatalog.aspx" class="btn">Buy Now</a>
                </div>
            </div>
        </div>
    </div>

    <div class ="key-feature">
		<h1 style="font-family:'Inter';">What Our Customer Said</h1>
		<div class="small-container-review">
			<div class="row-review">
				
				<div class="col-4">
					<div class="image">
						<img src="Pictures/human1.png" style="width:100%;height:230px;" />
					</div>
				<p style="font-family: 'Inter'; font-size:10px;">"Always serving the best, their Juhi squid is a pinnacle of premium quality—each bite a testament to their mastery of Indonesian flavors. 
                    A definite 5-star delight that never disappoints." </p>
				</div>

				<div class="col-4">
					<div class="image">
						<img src="Pictures/porknoodle.png" style="width:100%;" />
					</div>
					<p style="font-family: 'Inter'; font-size:10px;">"The Juhi squid sourced from here is consistently top-notch, enhancing our dishes like Bakso Goreng with its fresh and flavorful profile. 
                        It's our go-to choice for authentic Indonesian ingredients that elevate our Chinese cuisine offerings."</p>
				</div>

				<div class="col-4">
					<div class="image">
						<img src="Pictures/human3.png" style="width:100%; height:210px;"/>
					</div>
					<p style="font-family: 'Inter'; font-size:10px;">"The Juhi squid from here is a game-changer for my homemade pork noodles. 
                        Its distinct flavor and texture add a unique twist that my customers love. It's the perfect snack option that sets my restaurant apart."</p>
				</div>

				<div class="col-4">
					<div class="image">
						<img src="Pictures/human4.png" style="width:100%;"/>
					</div>
					<p style="font-family: 'Inter'; font-size:10px;">"The Juhi squid here is absolutely delicious! 
                        Tender and flavorful, it's the highlight of my meal every time. A must-try for seafood enthusiasts!"</p>
				</div>
			</div>
		</div>
	</div>

    <div class="container-last" style="margin-top:100px;">
        <div class="row-last">
            <div class="col-2-last">
                <img src="Pictures/aboutusjuhi.jpeg" alt="Rujak Juhi" style="border-radius:900px; padding-left:100px; border-style:inset;"/>
            </div>

            <div class="col-2-last">
                <h1 style="font-family:Inter">Organic & Fresh Snack Serving</h1>
                <p style="line-height:25px;text-align:justify;padding-right:140px; font-family:Inter; font-size:12px;">Indulge in the exquisite taste of Juhi (Sotong) from Indonesia, 
                    where every bite promises a burst of authentic flavors. 
                    Our Juhi is meticulously prepared from the freshest catch, 
                    ensuring each piece embodies the essence of quality and tradition. 
                    Sourced sustainably, every purchase supports local fishermen and promotes eco-friendly practices. 
                    Treat yourself to a culinary delight that not only satisfies your palate but also champions ethical sourcing and community livelihoods.</p>

                <div class="logo-section">
                    <div class="logo-item">
                        <img src="Pictures/bestquality.png" style="width:50px; height:40px; padding-top:26px;" />
                        <div class="text-content">
                            <h3>Best Quality</h3>
                            <p class="description">Indulge in Juhi Snack, made with the highest quality ingredients for an exceptional taste in every bite.</p>
                        </div>
                    </div>
                </div>
                <div class="logo-section">
                    <div class="logo-item">
                        <img src="Pictures/uniquetaste.png" style="width:50px; height:40px; padding-top:26px;" />
                        <div class="text-content">
                            <h3>Unique Taste</h3>
                            <p class="description">Savor the distinctive flavor of Juhi Snack, where every bite delivers a one-of-a-kind taste sensation. </p>
                        </div>
                    </div>
                </div>

                <div class="logo-section">
                    <div class="logo-item">
                        <img src="Pictures/freshlymade.png" style="width:50px; height:40px;  padding-top:26px;" />
                        <div class="text-content">
                            <h3>Fresh</h3>
                            <p class="description">Fresh homemade cuisine for Juhi Sotong from Indonesia: Imagine tender, succulent dishes crafted with love and expertise. </p>
                        </div>
                    </div>
                </div>

                <div class="logo-section">
                    <div class="logo-item">
                        <img src="Pictures/preservative-free.png" style="width:50px; height:40px;  padding-top:26px;" />
                        <div class="text-content">
                            <h3>Preservative-Free</h3>
                            <p class="description" >Savor the pure, natural essence of Indonesian cuisine, free from artificial additives, ensuring each dish is as wholesome and fresh as can be. </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>


</asp:Content>
