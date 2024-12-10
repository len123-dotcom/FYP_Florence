<%@ Page Title="" Language="C#" MasterPageFile="~/Visitor.Master" AutoEventWireup="true" CodeBehind="checkoutForm.aspx.cs" Inherits="FYP_Florence.checkoutForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/acc7225e7e.js" crossorigin="anonymous"></script>    
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Manrope:wght@200..800&display=swap" rel="stylesheet">
	<link href ="layoutStyling.css" rel ="stylesheet" type ="text/css" />
    <style>
    .container-checkout {
		max-width: 1200px;
		margin: 1px;
		padding: 20px;
		display: flex;
		flex-direction: row;
		justify-content: space-between; 
		align-items: flex-start; 
		min-height: 100vh;	
	}
    .content{
		flex:1;
	}

    .form-box{
        
        width:720px;
        position: relative; /*awalnya absolute*/
        padding: 10px 60px 70px;
        border-radius: 4px;
        border: 2px solid lightgrey;
        display:flex;
        flex-direction:column;
        margin-top:10px;
		left:25%;
		right:25%;
    }

    .form-box h1 {
	    font-size: 30px;
	    margin-bottom: 20px;
	    color: #69443c;
	    position:relative;
        font-family:"poppinssemibold";
    }

	.text-field{
	    background: transparent;
		font-family: poppinssemibold;
		margin-bottom: 20px;
		margin-top:3px;
		font-size:12px;
		display: flex;
        flex-direction: column;
		align-items:flex-start;
    } 

	.text-field input[type="text"],
	.text-field input[type="number"]
	{
        line-height: 40px; 
        width: 300px;
        border-radius:5px;
    }
	.text-field select {
		line-height: 40px;
		width: 300px;
		border-radius: 5px;
		padding: 5px 10px;
		font-size: 14px; 
		border: 1px solid #ccc; 
		background-color: #fff; 
		color: #555; 
		outline: none; 
		cursor: pointer; 
	}

	.text-field input[type="tel"]{
		line-height: 40px; 
        width: 300px;
        border-radius:5px;
		margin-bottom:20px;
	}
	
	.text-field p{
		margin-bottom:10px;
	}

	.continue-button {
         background: #3434eb;
		 border-radius: 8px;
		 color: #ffffff;
		 font-family:"Inter";
		 border:none;
		 cursor:pointer;
		 height:40px;
		 width:100px;
    }

	.errormessage {
        position: absolute;
        top: 610px;
        left: 210px;
        font-size:16px;
    }

	.checkout-box {
        width: 30%;
        background-color: #f8f8f8;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        margin-left: 100px;
		display: flex;
		flex-direction: column; 
		align-items: flex-start; 
		margin-top:10px;
    }

	.cart-item {
		display: flex; 
		margin-bottom: 10px; 
		border: 1px solid #ddd;
		margin: 10px;
		flex-direction: row;
		width: 90%;
		margin-left:20px;
	}

	.cart-item-image {
		width: 90px;
		height: 100px; 
		object-fit: cover; 
		margin-right: 20px;  
		padding: 30px;
	}

	
	 .address-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; 
     }


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<a href="cart.aspx" class="arrow-link">
    <div class="arrow-container">
        <i class="fa-solid fa-arrow-left"></i>
        <div class="back-text">back</div>
    </div>
</a>
	<hr class="divider">
    <div class="container-checkout">
    <div class="content">
		<div class="form-box">
			<h1> Shipping Information</h1>
				<div class="text-field">
					<p>Name:</p>
					<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
				</div>


			<div class="address-container">
				<div class="text-field">
					<p>Province:</p>
					<asp:DropDownList ID="DropDownListProvince" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListProvince_SelectedIndexChanged">

						<asp:ListItem Text="Select Province" Value=""></asp:ListItem>
						<asp:ListItem>Bali</asp:ListItem>
						<asp:ListItem>Bangka Belitung</asp:ListItem>
						<asp:ListItem>Banten</asp:ListItem>
						<asp:ListItem>DI Yogyakarta</asp:ListItem>
						<asp:ListItem>DKI Jakarta</asp:ListItem>
						<asp:ListItem>Jawa Barat</asp:ListItem>
						<asp:ListItem>Jawa Tengah</asp:ListItem>
						<asp:ListItem>Kalimantan Barat</asp:ListItem>
						<asp:ListItem>Kalimantan Selatan</asp:ListItem>
						<asp:ListItem>Kalimantan Timur</asp:ListItem>
						<asp:ListItem>Kalimantan Utara</asp:ListItem>
						<asp:ListItem>Kepulauan Riau</asp:ListItem>
						<asp:ListItem>Lampung</asp:ListItem>
						<asp:ListItem>Sulawesi Barat</asp:ListItem>
						<asp:ListItem>Sulawesi Selatan</asp:ListItem>
						
					</asp:DropDownList>
				</div>
                <div class="text-field">
					<p>City:</p>
					<asp:DropDownList ID="DropDownListCity" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListCity_SelectedIndexChanged">
						<asp:ListItem Text="Select City" Value=""></asp:ListItem>
					</asp:DropDownList>
				</div>
				<div class="text-field">
					<p>District:</p>
					<asp:DropDownList ID="DropDownListDistrict" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListDistrict_SelectedIndexChanged">
						<asp:ListItem Text="Select District" Value=""></asp:ListItem>
					</asp:DropDownList>
				</div>


                    <%--<div class="text-field">
                        <p>Province:</p>
                        <asp:TextBox ID="TextBoxProvince" runat="server"></asp:TextBox>
                    </div>--%>
					<div class="text-field">
						<p>Address:</p>
						<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
					</div>
                </div>

				<div class="text-field">
					<p>Phone Number:</p>
					<asp:TextBox ID="TextBox3" runat="server"  TextMode="Phone"></asp:TextBox>
				</div>
			

			<asp:Button ID="Button1" runat="server" Text="Continue" CssClass="continue-button" OnClick="Button1_Click" />
		</div>
		<asp:Label ID="errMsg" runat="server" Text="Label" ForeColor="Red" Visible="False" CssClass="errormessage" style="top:810px; left:400px;"></asp:Label>

		
    </div>

</div>
	<script type="text/javascript">
    function populateCityDropdown() {
        var provinceDropdown = document.getElementById('<%= DropDownListProvince.ClientID %>');
        var cityDropdown = document.getElementById('<%= DropDownListCity.ClientID %>');

        var selectedProvince = provinceDropdown.value;

        // Clear existing options
        cityDropdown.options.length = 0;

        // Add default option
        var defaultOption = document.createElement('option');
        defaultOption.text = "Select City";
        defaultOption.value = "";
        cityDropdown.appendChild(defaultOption);

        // Add cities based on selected province
        switch (selectedProvince) {
            case "Bali":
                addCityOption("Badung", cityDropdown);
                addCityOption("Bangli", cityDropdown);
                addCityOption("Buleleng", cityDropdown);
                addCityOption("Denpasar", cityDropdown);
                addCityOption("Gianyar", cityDropdown);
                addCityOption("Jembrana", cityDropdown);
                addCityOption("Karangasem", cityDropdown);
                addCityOption("Klungkung", cityDropdown);
                addCityOption("Tabanan", cityDropdown);
                break;
            case "Bangka Belitung":
                addCityOption("Bangka", cityDropdown);
                addCityOption("Bangka Barat", cityDropdown);
                addCityOption("Bangka Selatan", cityDropdown);
                addCityOption("Bangka Tengah", cityDropdown);
                addCityOption("Belitung", cityDropdown);
                addCityOption("Belitung Timur", cityDropdown);
                addCityOption("Pangkal Pinang", cityDropdown);
                break;
            case "Banten":
                addCityOption("Cilegon", cityDropdown);
                addCityOption("Kota Serang", cityDropdown);
                addCityOption("Lebak", cityDropdown);
                addCityOption("Pandelang", cityDropdown);
                addCityOption("Serang", cityDropdown);
                addCityOption("Tangerang", cityDropdown);
                addCityOption("Tangerang Selatan", cityDropdown);
				break;
			case "Bengkulu":
				addCityOption("Bengkulu", cityDropdown);
				addCityOption("Bengkulu Selatan", cityDropdown);
				addCityOption("Bengkulu Utara", cityDropdown);
				addCityOption("Kaur", cityDropdown);
				addCityOption("Kepahiang", cityDropdown);
				addCityOption("Lebong", cityDropdown);
				addCityOption("Muko Muko", cityDropdown);
				addCityOption("Rejang Lebong", cityDropdown);
				addCityOption("Seluma", cityDropdown);
				break;

			case "DI Yogyakarta":
				addCityOption("Bantul", cityDropdown);
				addCityOption("Gunung Kidul", cityDropdown);
				addCityOption("Kulon Progo", cityDropdown);
				addCityOption("Sleman", cityDropdown);
				addCityOption("Wonosari", cityDropdown);
				addCityOption("Yogyakarta", cityDropdown);
				break;

			case "DKI Jakarta":
				addCityOption("Jakarta Barat", cityDropdown);
				addCityOption("Jakarta Pusat", cityDropdown);
				addCityOption("Jakarta Selatan", cityDropdown);
				addCityOption("Jakarta Timur", cityDropdown);
				addCityOption("Jakarta Utara", cityDropdown);
				addCityOption("Kepulauan Seribu", cityDropdown);
				break;

			case "Gorontalo":
				addCityOption("Boalemo", cityDropdown);
				addCityOption("Bone Bolango", cityDropdown);
				addCityOption("Gorontalo", cityDropdown);
				addCityOption("Gorontalo Utara", cityDropdown);
				addCityOption("Kab. Gorontalo", cityDropdown);
				addCityOption("Pohuwato", cityDropdown);
				break;

			case "Jambi":
				addCityOption("Batang Hari", cityDropdown);
				addCityOption("Bungo", cityDropdown);
				addCityOption("Jambi", cityDropdown);
				addCityOption("Kerinci", cityDropdown);
				addCityOption("Kuala Tungkal", cityDropdown);
				addCityOption("Merangin", cityDropdown);
				addCityOption("Muaro Jambi", cityDropdown);
				addCityOption("Sarolangun", cityDropdown);
				addCityOption("Sungaipenuh", cityDropdown);
				addCityOption("Tanjung Jabung Barat", cityDropdown);
				addCityOption("Tanjung Jabung Timur", cityDropdown);
				addCityOption("Tebo", cityDropdown);
				break;

			case "Jawa Barat":
				addCityOption("Bandung", cityDropdown);
				addCityOption("Bandung Barat", cityDropdown);
				addCityOption("Banjar", cityDropdown);
				addCityOption("Bekasi", cityDropdown);
				addCityOption("Bogor", cityDropdown);
				addCityOption("Ciamis", cityDropdown);
				addCityOption("Cianjur", cityDropdown);
				addCityOption("Cimahi", cityDropdown);
				addCityOption("Cirebon", cityDropdown);
				addCityOption("Depok", cityDropdown);
				addCityOption("Garut", cityDropdown);
				addCityOption("Indramayu", cityDropdown);
				addCityOption("Kab. Bandung", cityDropdown);
				addCityOption("Kab. Bekasi", cityDropdown);
				addCityOption("Kab. Bogor", cityDropdown);
				addCityOption("Kab. Cirebon", cityDropdown);
				addCityOption("Kab. Sukabumi", cityDropdown);
				addCityOption("Kab. Tasikmalaya", cityDropdown);
				addCityOption("Karawang", cityDropdown);
				addCityOption("Kota Bogor", cityDropdown);
				addCityOption("Kuningan", cityDropdown);
				addCityOption("Majalengka", cityDropdown);
				addCityOption("Pangandaran", cityDropdown);
				addCityOption("Purwakarta", cityDropdown);
				addCityOption("Subang", cityDropdown);
				addCityOption("Sukabumi", cityDropdown);
				addCityOption("Sumedang", cityDropdown);
				addCityOption("Tasikmalaya", cityDropdown);
				break;

			case "Jawa Tengah":
				addCityOption("Banjarnegara", cityDropdown);
				addCityOption("Bayumas", cityDropdown);
				addCityOption("Batang", cityDropdown);
				addCityOption("Blora", cityDropdown);
				addCityOption("Brebes", cityDropdown);
				addCityOption("Cilacap", cityDropdown);
				addCityOption("Demak", cityDropdown);
				addCityOption("Grobogon", cityDropdown);
				addCityOption("Jepara", cityDropdown);
				addCityOption("Kab. Magelang", cityDropdown);
				addCityOption("Kab. Pekalongan", cityDropdown);
				addCityOption("Kab. Semarang", cityDropdown);
				addCityOption("Kab. Tegal", cityDropdown);
				addCityOption("Karanganyar", cityDropdown);
				addCityOption("Kebumen", cityDropdown);
				addCityOption("Kendal", cityDropdown);
				addCityOption("Klaten", cityDropdown);
				addCityOption("Kudus", cityDropdown);
				addCityOption("Magelang", cityDropdown);
				addCityOption("Pati", cityDropdown);
				addCityOption("Pekalongan", cityDropdown);
				addCityOption("Pemalang", cityDropdown);
				addCityOption("Purbalingga", cityDropdown);
				addCityOption("Purwokerto", cityDropdown);
				addCityOption("Purworejo", cityDropdown);
				addCityOption("Rembang", cityDropdown);
				addCityOption("Salatiga", cityDropdown);
				addCityOption("Semarang", cityDropdown);
				addCityOption("Semarang Kota", cityDropdown);
				addCityOption("Solo", cityDropdown);
				addCityOption("Sragen", cityDropdown);
				addCityOption("Sukoharjo", cityDropdown);
				addCityOption("Surakarta", cityDropdown);
				addCityOption("Tegal", cityDropdown);
				addCityOption("Temanggung", cityDropdown);
				addCityOption("Wonogiri", cityDropdown);
				addCityOption("Wonosobo", cityDropdown);
				break;

			//case "Jawa Timur":
			//	addCityOption("Bangkalan", cityDropdown);
			//	addCityOption("Bayuwangi", cityDropdown);
			//	addCityOption("Batu", cityDropdown);
			//	addCityOption("Blitar", cityDropdown);
			//	addCityOption("Bojonegoro", cityDropdown);
			//	addCityOption("Bondowoso", cityDropdown);
			//	addCityOption("Gresik", cityDropdown);
			//	addCityOption("Jember", cityDropdown);
			//	addCityOption("Jombang", cityDropdown);
			//	addCityOption("Kab. Blitar", cityDropdown);
			//	addCityOption("Kab. Kediri", cityDropdown);
			//	addCityOption("Kab. Madiun", cityDropdown);
			//	addCityOption("Kab. Malang", cityDropdown);
			//	addCityOption("Kab. Mojokerto", cityDropdown);
			//	addCityOption("Kab. Pasuruan", cityDropdown);
			//	addCityOption("Kab. Probolinggo", cityDropdown);
			//	addCityOption("Kediri", cityDropdown);
			//	addCityOption("Lamongan", cityDropdown);
			//	addCityOption("Lawang", cityDropdown);
			//	addCityOption("Lumajang", cityDropdown);
			//	addCityOption("Madiun", cityDropdown);
			//	addCityOption("Magetan", cityDropdown);
			//	addCityOption("Malang", cityDropdown);
			//	addCityOption("Mojokerto", cityDropdown);
			//	addCityOption("Nganjuk", cityDropdown);
			//	addCityOption("Ngawi", cityDropdown);
			//	addCityOption("Pacitan", cityDropdown);
			//	addCityOption("Pamekasan", cityDropdown);
			//	addCityOption("Pasuruan", cityDropdown);
			//	addCityOption("Ponorogo", cityDropdown);
			//	addCityOption("Probolinggo", cityDropdown);
			//	addCityOption("Sampang", cityDropdown);
			//	addCityOption("Sidoarjo", cityDropdown);
			//	addCityOption("Situbondo", cityDropdown);
			//	addCityOption("Sumenep", cityDropdown);
			//	addCityOption("Surabaya", cityDropdown);
			//	addCityOption("Trenggalek", cityDropdown);
			//	addCityOption("Tuban", cityDropdown);
			//	addCityOption("Tulungagung", cityDropdown);
			//	break;

			case "Kalimantan Barat":
				addCityOption("Bengkayang", cityDropdown);
				addCityOption("Kapuas Hulu", cityDropdown);
				addCityOption("Kayong Utara", cityDropdown);
				addCityOption("Ketapang", cityDropdown);
				addCityOption("Kubu Raya", cityDropdown);
				addCityOption("Landak", cityDropdown);
				addCityOption("Melawi", cityDropdown);
				addCityOption("Mempawah", cityDropdown);
				addCityOption("Pontianak", cityDropdown);
				addCityOption("Putussibau", cityDropdown);
				addCityOption("Sambas", cityDropdown);
				addCityOption("Sanggau", cityDropdown);
				addCityOption("Sekadau", cityDropdown);
				addCityOption("Singkawang", cityDropdown);
				addCityOption("Sintang", cityDropdown);
				break;

			case "Kalimantan Selatan":
				addCityOption("Balangan", cityDropdown);
				addCityOption("Banjar", cityDropdown);
				addCityOption("Banjarbaru", cityDropdown);
				addCityOption("Banjarmasin", cityDropdown);
				addCityOption("Barito Kuala", cityDropdown);
				addCityOption("Hulu Sungai Selatan", cityDropdown);
				addCityOption("Hulu Sungai Tengah", cityDropdown);
				addCityOption("Hulu Sungai Utara", cityDropdown);
				addCityOption("Kotabaru", cityDropdown);
				addCityOption("Tabalong", cityDropdown);
				addCityOption("Tanah Bumbu", cityDropdown);
				addCityOption("Tanah Laut", cityDropdown);
				addCityOption("Tapin", cityDropdown);
				break;

			case "Kalimantan Tengah":
				addCityOption("Barito Selatan", cityDropdown);
				addCityOption("Barito Timur", cityDropdown);
				addCityOption("Barito Utara", cityDropdown);
				addCityOption("Gunung Mas", cityDropdown);
				addCityOption("Kapuas", cityDropdown);
				addCityOption("Katingan", cityDropdown);
				addCityOption("Kotawaringin Barat", cityDropdown);
				addCityOption("Kotawaringin Timur", cityDropdown);
				addCityOption("Lamandau", cityDropdown);
				addCityOption("Murung Raya", cityDropdown);
				addCityOption("Palangka Raya", cityDropdown);
				addCityOption("Palangkaraya", cityDropdown);
				addCityOption("Pulang Pisau", cityDropdown);
				addCityOption("Seruyang", cityDropdown);
				addCityOption("Sukamara", cityDropdown);
				break;

			case "Kalimantan Timur":
				addCityOption("Balikpapan", cityDropdown);
				addCityOption("Berau", cityDropdown);
				addCityOption("Bontang", cityDropdown);
				addCityOption("Kutai Barat", cityDropdown);
				addCityOption("Kutai Kartanegara", cityDropdown);
				addCityOption("Kutai Kertanegara/Kutai Timur", cityDropdown);
				addCityOption("Kutai Timur", cityDropdown);
				addCityOption("Mahakam Ulu", cityDropdown);
				addCityOption("Paser", cityDropdown);
				addCityOption("Penajam Paser Utara", cityDropdown);
				addCityOption("Samarinda", cityDropdown);
				break;

			case "Kalimantan Utara":
				addCityOption("Bulungan", cityDropdown);
				addCityOption("Malinau", cityDropdown);
				addCityOption("Nunukan", cityDropdown);
				addCityOption("Tana Tidung", cityDropdown);
				addCityOption("Tarakan", cityDropdown);
				break;

			case "Kepulauan Riau":
				addCityOption("Batam", cityDropdown);
				addCityOption("Bintan", cityDropdown);
				addCityOption("Karimun", cityDropdown);
				addCityOption("Kepulauan Anambas", cityDropdown);
				addCityOption("Lingga", cityDropdown);
				addCityOption("Natuna", cityDropdown);
				addCityOption("Tanjung Pinang", cityDropdown);
				break;

			case "Lampung":
				addCityOption("Bandar Lampung", cityDropdown);
				addCityOption("Lampung Barat", cityDropdown);
				addCityOption("Lampung Selatan", cityDropdown);
				addCityOption("Lampung Tengah", cityDropdown);
				addCityOption("Lampung Timur", cityDropdown);
				addCityOption("Lampung Utara", cityDropdown);
				addCityOption("Mesuji", cityDropdown);
				addCityOption("Metro", cityDropdown);
				addCityOption("Pesawaran", cityDropdown);
				addCityOption("Pesisir Barat", cityDropdown);
				addCityOption("Pringsewu", cityDropdown);
				addCityOption("Tanggamus", cityDropdown);
				addCityOption("Tulang Bawang", cityDropdown);
				addCityOption("Tulang Bawang Barat", cityDropdown);
				addCityOption("Way Kanan", cityDropdown);
				break;

			case "Riau":
				addCityOption("Bengkalis", cityDropdown);
				addCityOption("Dumai", cityDropdown);
				addCityOption("Indragiri Hilir", cityDropdown);
				addCityOption("Indragiri Hulu", cityDropdown);
				addCityOption("Kampar", cityDropdown);
				addCityOption("Kepulauan Meranti", cityDropdown);
				addCityOption("Kuantan Singingi", cityDropdown);
				addCityOption("Pekanbaru", cityDropdown);
				addCityOption("Pelalawan", cityDropdown);
				addCityOption("Rokan Hilir", cityDropdown);
				addCityOption("Rokan Hulu", cityDropdown);
				addCityOption("Siak", cityDropdown);
				break;

			case "Sulawesi Barat":
				addCityOption("Majene", cityDropdown);
				addCityOption("Mamasa", cityDropdown);
				addCityOption("Mamuju", cityDropdown);
				addCityOption("Mamuju Tengah", cityDropdown);
				addCityOption("Mamuju Utara", cityDropdown);
				addCityOption("Polewali Mandar", cityDropdown);
				break;

			case "Sulawesi Selatan":
				addCityOption("Bantaeng", cityDropdown);
				addCityOption("Barru", cityDropdown);
				addCityOption("Bone", cityDropdown);
				addCityOption("Bulukumba", cityDropdown);
				addCityOption("Enrekang", cityDropdown);
				addCityOption("Gowa", cityDropdown);
				addCityOption("Jeneponto", cityDropdown);
				addCityOption("Kepulauan Selayar", cityDropdown);
				addCityOption("Luwu", cityDropdown);
				addCityOption("Luwu Timur", cityDropdown);
				addCityOption("Luwu Utara", cityDropdown);
				addCityOption("Makassar", cityDropdown);
				addCityOption("Maros", cityDropdown);
				addCityOption("Palopo", cityDropdown);
				addCityOption("Pangkajene Kepulauan", cityDropdown);
				addCityOption("Parepare", cityDropdown);
				addCityOption("Pinrang", cityDropdown);
				addCityOption("Selayar (Kepualuan Selayar)", cityDropdown);
				addCityOption("Sidenreng Rappang", cityDropdown);
				addCityOption("Sidenreng Rappang/Rapang", cityDropdown);
				addCityOption("Sinjay", cityDropdown);
				addCityOption("Soppeng", cityDropdown);
				addCityOption("Takalar", cityDropdown);
				addCityOption("Tana Toraja", cityDropdown);
				addCityOption("Toraja Utara", cityDropdown);
				addCityOption("Wajo", cityDropdown);
				break;

			case "Sulawesi Tengah":
				addCityOption("Banggai", cityDropdown);
				addCityOption("Banggai Kepulaun", cityDropdown);
				addCityOption("Banggai Laut", cityDropdown);
				addCityOption("Buol", cityDropdown);
				addCityOption("Donggala", cityDropdown);
				addCityOption("Morowali", cityDropdown);
				addCityOption("Morowali Utara", cityDropdown);
				addCityOption("Palu", cityDropdown);
				addCityOption("Parigi Moutong", cityDropdown);
				addCityOption("Poso", cityDropdown);
				addCityOption("Sigi", cityDropdown);
				addCityOption("Tojo Una-una", cityDropdown);
				addCityOption("Toli-Toli", cityDropdown);
				break;

			//case "Sulawesi Tenggara":
			//	addCityOption("Bau Bau", cityDropdown);
			//	addCityOption("Bau-Bau", cityDropdown);
			//	addCityOption("Bombana", cityDropdown);
			//	addCityOption("Buton", cityDropdown);
			//	addCityOption("Buton Selatan", cityDropdown);
			//	addCityOption("Buton Tengah", cityDropdown);
			//	addCityOption("Buton Utara", cityDropdown);
			//	addCityOption("Kendari", cityDropdown);
			//	addCityOption("Kolaka", cityDropdown);
			//	addCityOption("Kolaka Timur", cityDropdown);
			//	addCityOption("Kolaka Utara", cityDropdown);
			//	addCityOption("Konawe", cityDropdown);
			//	addCityOption("Konawe Kepulauan", cityDropdown);
			//	addCityOption("Konawe Selatan", cityDropdown);
			//	addCityOption("Konawe Utara", cityDropdown);
			//	addCityOption("Muna", cityDropdown);
			//	addCityOption("Muna Barat", cityDropdown);
			//	addCityOption("Wakatobi", cityDropdown);
			//	break;

			//case "Sulawesi Utara":
			//	addCityOption("Bitung", cityDropdown);
			//	addCityOption("Bolaang Mongondow", cityDropdown);
			//	addCityOption("Bolaang Mongondow Selatan", cityDropdown);
			//	addCityOption("Bolaang Mongondow Timur", cityDropdown);
			//	addCityOption("Bolaang Mongondow Utara", cityDropdown);
			//	addCityOption("Kepulauan Sangihe", cityDropdown);
			//	addCityOption("Kepulauan Siau Tagulandang Biaro (Sitaro)", cityDropdown);
			//	addCityOption("Kepulauan Talaud", cityDropdown);
			//	addCityOption("Kotamobagu", cityDropdown);
			//	addCityOption("Manado", cityDropdown);
			//	addCityOption("Minahasa", cityDropdown);
			//	addCityOption("Minahasa Selatan", cityDropdown);
			//	addCityOption("Minahasa Tenggara", cityDropdown);
			//	addCityOption("Minahasa Utara", cityDropdown);
			//	addCityOption("Tomohon", cityDropdown);
			//	break;

			//case "Sumatera Barat":
			//	addCityOption("Agam", cityDropdown);
			//	addCityOption("Bukittinggi", cityDropdown);
			//	addCityOption("Dharmasraya", cityDropdown);
			//	addCityOption("Kab. Solok", cityDropdown);
			//	addCityOption("Kepulauan Mentawai", cityDropdown);
			//	addCityOption("Lima Puluh Kota", cityDropdown);
			//	addCityOption("Lubuk Basung", cityDropdown);
			//	addCityOption("Padang", cityDropdown);
			//	addCityOption("Padang Panjang", cityDropdown);
			//	addCityOption("Padang Pariaman", cityDropdown);
			//	addCityOption("Pariaman", cityDropdown);
			//	addCityOption("Pasaman", cityDropdown);
			//	addCityOption("Pasaman Barat", cityDropdown);
			//	addCityOption("Payakumbuh", cityDropdown);
			//	addCityOption("Pesisir Selatan", cityDropdown);
			//	addCityOption("Sawah Lunto", cityDropdown);
			//	addCityOption("Sijunjung", cityDropdown);
			//	addCityOption("Solok", cityDropdown);
			//	addCityOption("Solok Selatan", cityDropdown);
			//	addCityOption("Tanah Datar", cityDropdown);
			//	break;

			//case "Sumatera Selatan":
			//	addCityOption("Banyuasin", addCityOption);
			//	addCityOption("Empat Lawang", addCityOption);
			//	addCityOption("Lahat", addCityOption);
			//	addCityOption("Lubuk Linggau", addCityOption);
			//	addCityOption("Muara Enim", addCityOption);
			//	addCityOption("Musi Banyuasin", addCityOption);
			//	addCityOption("Musi Rawas", addCityOption);
			//	addCityOption("Musi Rawas Utara", addCityOption);
			//	addCityOption("Ogan Ilir", addCityOption);
			//	addCityOption("Ogan Komering Ilir", addCityOption);
			//	addCityOption("Ogan Komering Ulu", addCityOption);
			//	addCityOption("Ogan Komering Ulu Selatan", addCityOption);
			//	addCityOption("Ogan Komering Ulu Timur", addCityOption);
			//	addCityOption("Pagar Alam", addCityOption);
			//	addCityOption("Palembang", addCityOption);
			//	addCityOption("Penukal Abab Lematang Ilir", addCityOption);
			//	addCityOption("Prabumulih", addCityOption);
			//	break;

			//case "Sumatera Utara":
			//	addCityOption("Asahan", addCityOption);
			//	addCityOption("Batu Bara", addCityOption);
			//	addCityOption("Binjai", addCityOption);
			//	addCityOption("Dairi", addCityOption);
			//	addCityOption("Deli Serdang", addCityOption);
			//	addCityOption("Gunung Sitoli", addCityOption);
			//	addCityOption("Humbang Hasudutan", addCityOption);
			//	addCityOption("Karo", addCityOption);
			//	addCityOption("Labuhan Batu", addCityOption);
			//	addCityOption("Labuhan Batu Selatan", addCityOption);
			//	addCityOption("Labuhan Batu Utara", addCityOption);
			//	addCityOption("Labuhanbatu", addCityOption);
			//	addCityOption("Labuhanbatu Selatan", addCityOption);
			//	addCityOption("Labuhanbatu Utara", addCityOption);
			//	addCityOption("Langkat", addCityOption);
			//	addCityOption("Mandailing Natal", addCityOption);
			//	addCityOption("Medan", addCityOption);
			//	addCityOption("Nias", addCityOption);
			//	addCityOption("Nias Barat", addCityOption);
			//	addCityOption("Nias Selatan", addCityOption);
			//	addCityOption("Nias Utara", addCityOption);
			//	addCityOption("Padang Lawas", addCityOption);
			//	addCityOption("Padang Lawas Utara", addCityOption);
			//	addCityOption("Padang Siedempuan", addCityOption);
			//	addCityOption("Pakpak Bharat", addCityOption);
			//	addCityOption("Pematang Siantar", addCityOption);
			//	addCityOption("Samosir", addCityOption);
			//	addCityOption("Serdang Bedagai", addCityOption);
			//	addCityOption("Sibolga", addCityOption);
			//	addCityOption("Simalungun", addCityOption);
			//	addCityOption("Tanjung Balai", addCityOption);
			//	addCityOption("Tanjung Selatan", addCityOption);
			//	addCityOption("Tanjung Tengah", addCityOption);
			//	addCityOption("Tanjung Utara", addCityOption);
			//	addCityOption("Tebing Tinggi", addCityOption);
			//	addCityOption("Toba Samosir", addCityOption);
			//	break;


        }
    }

    function addCityOption(cityName, dropdown) {
        var option = document.createElement('option');
        option.text = cityName;
        option.value = cityName;
        dropdown.appendChild(option);
    }

    document.getElementById('<%= DropDownListProvince.ClientID %>').addEventListener('change', function() {
        populateCityDropdown();
    });
</script>



</asp:Content>
