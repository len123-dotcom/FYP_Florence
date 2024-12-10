using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class checkoutForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateProvinceDropdown();
                DisplayCartProducts();
                FillUserDetails();
            }
            //if (Session["totalamount"] != null)
            //{
            //    lblTotal.Text = "total: rm " + Session["totalamount"].ToString();
            //}

        }


        protected void PopulateProvinceDropdown()
        {
            DropDownListProvince.Items.Clear(); 
            DropDownListProvince.Items.Add(new ListItem("Select Province", ""));
            DropDownListProvince.Items.Add(new ListItem("Bali", "Bali"));
            DropDownListProvince.Items.Add(new ListItem("Bangka Belitung", "Bangka Belitung"));
            DropDownListProvince.Items.Add(new ListItem("Banten", "Banten"));
            DropDownListProvince.Items.Add(new ListItem("Bengkulu", "Bengkulu"));
            DropDownListProvince.Items.Add(new ListItem("DI Yogyakarta", "DI Yogyakarta"));
            DropDownListProvince.Items.Add(new ListItem("DKI Jakarta", "DKI Jakarta"));
            DropDownListProvince.Items.Add(new ListItem("Jawa Barat", "Jawa Barat"));
            DropDownListProvince.Items.Add(new ListItem("Jawa Tengah", "Jawa Tengah"));
            DropDownListProvince.Items.Add(new ListItem("Kalimantan Barat", "Kalimantan Barat"));
            DropDownListProvince.Items.Add(new ListItem("Kalimantan Selatan", "Kalimantan Selatan"));
            DropDownListProvince.Items.Add(new ListItem("Kalimantan Timur", "Kalimantan Timur"));
            DropDownListProvince.Items.Add(new ListItem("Kalimantan Utara", "Kalimantan Utara"));
            DropDownListProvince.Items.Add(new ListItem("Kepulauan Riau", "Kepulauan Riau"));
            DropDownListProvince.Items.Add(new ListItem("Lampung", "Lampung"));
            DropDownListProvince.Items.Add(new ListItem("Sulawesi Barat", "Sulawesi Barat"));
            DropDownListProvince.Items.Add(new ListItem("Sulawesi Selatan", "Sulawesi Selatan"));
        }

        protected void DropDownListProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedProvince = DropDownListProvince.SelectedValue;
            Session["Province"] = selectedProvince;
            PopulateCityDropdown(selectedProvince);
            Session["City"] = null;
            Session["District"] = null;
            DropDownListDistrict.Items.Clear();
            DropDownListDistrict.Items.Add(new ListItem("Select District", ""));
        }
        private void PopulateCityDropdown(string province) { 

            DropDownListCity.Items.Clear();
            DropDownListCity.Items.Add(new ListItem("Select City", ""));

            switch (province)
            {
                case "Bali":
                    DropDownListCity.Items.Add(new ListItem("Badung", "Badung"));
                    DropDownListCity.Items.Add(new ListItem("Bangli", "Bangli"));
                    DropDownListCity.Items.Add(new ListItem("Buleleng", "Buleleng"));
                    DropDownListCity.Items.Add(new ListItem("Denpasar", "Denpasar"));
                    DropDownListCity.Items.Add(new ListItem("Gianyar", "Gianyar"));
                    DropDownListCity.Items.Add(new ListItem("Jembrana", "Jembrana"));
                    DropDownListCity.Items.Add(new ListItem("Karangasem", "Karangasem"));
                    DropDownListCity.Items.Add(new ListItem("Klungkung", "Klungkung"));
                    DropDownListCity.Items.Add(new ListItem("Tabanan", "Tabanan"));
                    break;
                case "Bangka Belitung":
                    DropDownListCity.Items.Add(new ListItem("Bangka", "Bangka"));
                    DropDownListCity.Items.Add(new ListItem("Bangka Barat", "Bangka Barat"));
                    DropDownListCity.Items.Add(new ListItem("Bangka Selatan", "Bangka Selatan"));
                    DropDownListCity.Items.Add(new ListItem("Bangka Tengah", "Bangka Tengah"));
                    DropDownListCity.Items.Add(new ListItem("Belitung", "Belitung"));
                    DropDownListCity.Items.Add(new ListItem("Belitung Timur", "Belitung Timur"));
                    DropDownListCity.Items.Add(new ListItem("Pangkal Pinang", "Pangkal Pinang"));
                    break;

                case "Banten":
                    DropDownListCity.Items.Add(new ListItem("Cilegon", "Cilegon"));
                    DropDownListCity.Items.Add(new ListItem("Kota Serang", "Kota Serang"));
                    DropDownListCity.Items.Add(new ListItem("Lebak", "Lebak"));
                    DropDownListCity.Items.Add(new ListItem("Serang", "Serang"));
                    DropDownListCity.Items.Add(new ListItem("Tangerang", "Tangerang"));
                    DropDownListCity.Items.Add(new ListItem("Tangerang Selatan", "Tangerang Selatan"));
                    break;

                

                case "DI Yogyakarta":
                    //DropDownListCity.Items.Add(new ListItem("Bantul", "Bantul"));
                    DropDownListCity.Items.Add(new ListItem("Sleman", "Sleman"));
                    DropDownListCity.Items.Add(new ListItem("Wonosari", "Wonosari"));
                    break;

                case "DKI Jakarta":
                    DropDownListCity.Items.Add(new ListItem("Jakarta Barat", "Jakarta Barat"));
                    DropDownListCity.Items.Add(new ListItem("Jakarta Pusat", "Jakarta Pusat"));
                    DropDownListCity.Items.Add(new ListItem("Jakarta Selatan", "Jakarta Selatan"));
                    DropDownListCity.Items.Add(new ListItem("Jakarta Timur", "Jakarta Timur"));
                    DropDownListCity.Items.Add(new ListItem("Jakarta Utara", "Jakarta Utara"));
                    break;

                case "Jawa Barat":
                    DropDownListCity.Items.Add(new ListItem("Bandung", "Bandung"));
                    DropDownListCity.Items.Add(new ListItem("Bandung Barat", "Bandung Barat"));
                    DropDownListCity.Items.Add(new ListItem("Bogor", "Bogor"));
                    DropDownListCity.Items.Add(new ListItem("Cirebon", "Cirebon"));
                    DropDownListCity.Items.Add(new ListItem("Depok", "Depok"));
                    DropDownListCity.Items.Add(new ListItem("Karawang", "Karawang"));
                    DropDownListCity.Items.Add(new ListItem("Kota Bogor", "Kota Bogor"));
                    break;

                case "Jawa Tengah":
                    DropDownListCity.Items.Add(new ListItem("Semarang", "Semarang"));
                    DropDownListCity.Items.Add(new ListItem("Semarang Kota", "Semarang Kota"));
                    DropDownListCity.Items.Add(new ListItem("Solo", "Solo"));
                    break;

                case "Kalimantan Barat":                    
                    DropDownListCity.Items.Add(new ListItem("Singkawang", "Singkawang"));
                    break;

                case "Kalimantan Selatan":
                    DropDownListCity.Items.Add(new ListItem("Banjar", "Banjar"));
                    DropDownListCity.Items.Add(new ListItem("Banjarmasin", "Banjarmasin"));
                    break;

                case "Kalimantan Timur":
                    DropDownListCity.Items.Add(new ListItem("Balikpapan", "Balikpapan"));
                    DropDownListCity.Items.Add(new ListItem("Samarinda", "Samarinda"));
                    break;

                case "Kalimantan Utara":
                    DropDownListCity.Items.Add(new ListItem("Bulungan"));
                    DropDownListCity.Items.Add(new ListItem("Malinau"));
                    break;

                case "Kepulauan Riau":
                    DropDownListCity.Items.Add(new ListItem("Batam"));
                    DropDownListCity.Items.Add(new ListItem("Lingga"));
                    DropDownListCity.Items.Add(new ListItem("Natuna")); 
                    DropDownListCity.Items.Add(new ListItem("Tanjung Pinang"));
                    break;

                case "Lampung":
                    DropDownListCity.Items.Add(new ListItem("Bandar Lampung"));
                    DropDownListCity.Items.Add(new ListItem("Lampung Barat"));
                    DropDownListCity.Items.Add(new ListItem("Lampung Selatan"));
                    DropDownListCity.Items.Add(new ListItem("Lampung Tengah"));
                    DropDownListCity.Items.Add(new ListItem("Lampung Timur"));
                    DropDownListCity.Items.Add(new ListItem("Lampung Utara"));
                    break;

                case "Sulawesi Barat":

                    DropDownListCity.Items.Add(new ListItem("Mamasa"));
                    DropDownListCity.Items.Add(new ListItem("Mamuju"));
                    DropDownListCity.Items.Add(new ListItem("Mamuju Tengah"));
                    break;

                case "Sulawesi Selatan":
                    DropDownListCity.Items.Add(new ListItem("Makassar"));
                    DropDownListCity.Items.Add(new ListItem("Maros"));
                    break;
            }
        }

        protected void DropDownListCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCity = DropDownListCity.SelectedValue;
            Session["City"] = selectedCity;  
            PopulateDistrictDropdown(selectedCity);
            Session["District"] = null;
        }
        private void PopulateDistrictDropdown(string city) 
        {
            DropDownListDistrict.Items.Clear(); 
            DropDownListDistrict.Items.Add(new ListItem("Select District", ""));
            //string selectedCity = DropDownListCity.SelectedValue;

            switch (city)
            {
                case "Badung":
                    DropDownListDistrict.Items.Add(new ListItem("Abiansemal", "Abiansemal"));
                    DropDownListDistrict.Items.Add(new ListItem("Kuta", "Kuta"));
                    DropDownListDistrict.Items.Add(new ListItem("Kuta Selatan", "Kuta Selatan"));
                    DropDownListDistrict.Items.Add(new ListItem("Kuta Utara", "Kuta Utara"));
                    DropDownListDistrict.Items.Add(new ListItem("Mengwi", "Mengwi"));
                    break;

                case "Bangli":
                    DropDownListDistrict.Items.Add(new ListItem("Bangli", "Bangli"));
                    DropDownListDistrict.Items.Add(new ListItem("Kintamani", "Kintamani"));
                    DropDownListDistrict.Items.Add(new ListItem("Susut", "Susut"));
                    DropDownListDistrict.Items.Add(new ListItem("Tembuku", "Tembuku"));
                    break;

                case "Buleleng":
                    DropDownListDistrict.Items.Add(new ListItem("Banjar", "Banjar"));
                    DropDownListDistrict.Items.Add(new ListItem("Buleleng", "Buleleng"));
                    DropDownListDistrict.Items.Add(new ListItem("Busungbiu", "Busungbiu"));
                    DropDownListDistrict.Items.Add(new ListItem("Gerokgak", "Gerokgak"));
                    DropDownListDistrict.Items.Add(new ListItem("Kubutambahan", "Kubutambahan"));
                    DropDownListDistrict.Items.Add(new ListItem("Sawan", "Sawan"));
                    DropDownListDistrict.Items.Add(new ListItem("Seririt", "Seririt"));
                    DropDownListDistrict.Items.Add(new ListItem("Sukasada", "Sukasada"));
                    DropDownListDistrict.Items.Add(new ListItem("Tejakula", "Tejakula"));
                    break;

                case "Denpasar":
                    DropDownListDistrict.Items.Add(new ListItem("Denpasar", "Denpasar"));
                    DropDownListDistrict.Items.Add(new ListItem("Denpasar Barat", "Denpasar Barat"));
                    DropDownListDistrict.Items.Add(new ListItem("Denpasar Selatan", "Denpasar Selatan"));
                    DropDownListDistrict.Items.Add(new ListItem("Denpasar Timur", "Denpasar Timur"));
                    DropDownListDistrict.Items.Add(new ListItem("Denpasar Utara", "Denpasar Utara"));
                    DropDownListDistrict.Items.Add(new ListItem("Nusa Dua", "Nusa Dua"));
                    DropDownListDistrict.Items.Add(new ListItem("Tuban", "Tuban"));
                    break;

                case "Gianyar":
                    DropDownListDistrict.Items.Add(new ListItem("BelahBatuh", "BelahBatuh"));
                    DropDownListDistrict.Items.Add(new ListItem("Gianyar", "Gianyar"));
                    DropDownListDistrict.Items.Add(new ListItem("Payangan", "Payangan"));
                    DropDownListDistrict.Items.Add(new ListItem("Sukawati", "Sukawati"));
                    DropDownListDistrict.Items.Add(new ListItem("Tampak Siring", "Tampak Siring"));
                    DropDownListDistrict.Items.Add(new ListItem("Tegallalang", "Tegallalang"));
                    DropDownListDistrict.Items.Add(new ListItem("Ubud", "Ubud"));
                    break;

                case "Jembrana":
                    DropDownListDistrict.Items.Add(new ListItem("Jembrana", "Jembrana"));
                    DropDownListDistrict.Items.Add(new ListItem("Melaya", "Melaya"));
                    DropDownListDistrict.Items.Add(new ListItem("Mendoyo", "Mendoyo"));
                    DropDownListDistrict.Items.Add(new ListItem("Negara", "Negara"));
                    DropDownListDistrict.Items.Add(new ListItem("Pekutatan", "Pekutatan"));
                    break;

                case "Karangasem":
                    DropDownListDistrict.Items.Add(new ListItem("Abang", "Abang"));
                    DropDownListDistrict.Items.Add(new ListItem("Bebandem", "Bebandem"));
                    DropDownListDistrict.Items.Add(new ListItem("Karang Asem", "Karang Asem"));
                    DropDownListDistrict.Items.Add(new ListItem("Kubu", "Kubu"));
                    DropDownListDistrict.Items.Add(new ListItem("Manggis", "Manggis"));
                    DropDownListDistrict.Items.Add(new ListItem("Rendang", "Rendang"));
                    DropDownListDistrict.Items.Add(new ListItem("Selat", "Selat"));
                    break;

                case "Klungkung":
                    DropDownListDistrict.Items.Add(new ListItem("Banjarangkan", "Banjarangkan"));
                    DropDownListDistrict.Items.Add(new ListItem("Dawan", "Dawan"));
                    DropDownListDistrict.Items.Add(new ListItem("Klungkung", "Klungkung"));
                    DropDownListDistrict.Items.Add(new ListItem("Nusapenida", "Nusapenida"));
                    break;

                case "Tabanan":
                    DropDownListDistrict.Items.Add(new ListItem("Baturiti", "Baturiti"));
                    DropDownListDistrict.Items.Add(new ListItem("Kediri", "Kediri"));
                    DropDownListDistrict.Items.Add(new ListItem("Kerambitan", "Kerambitan"));
                    DropDownListDistrict.Items.Add(new ListItem("Marga", "Marga"));
                    DropDownListDistrict.Items.Add(new ListItem("Penebel", "Penebel"));
                    break;

                case "Bangka":
                    DropDownListDistrict.Items.Add(new ListItem("Bakam", "Bakam"));
                    DropDownListDistrict.Items.Add(new ListItem("Belinyu", "Belinyu"));
                    DropDownListDistrict.Items.Add(new ListItem("Mendo Barat", "Mendo Barat"));
                    DropDownListDistrict.Items.Add(new ListItem("Merawang", "Merawang"));
                    DropDownListDistrict.Items.Add(new ListItem("Pemali", "Pemali"));
                    DropDownListDistrict.Items.Add(new ListItem("Puding Besar", "Puding Besar"));
                    DropDownListDistrict.Items.Add(new ListItem("Riau Silip", "Riau Silip"));
                    break;

                case "Bangka Barat":
                    DropDownListDistrict.Items.Add(new ListItem("Jebus", "Jebus"));
                    DropDownListDistrict.Items.Add(new ListItem("Kelapa", "Kelapa"));
                    DropDownListDistrict.Items.Add(new ListItem("Mentok", "Mentok"));
                    DropDownListDistrict.Items.Add(new ListItem("Parittiga", "Parittiga"));
                    DropDownListDistrict.Items.Add(new ListItem("Simpang Teritip", "Simpang Teritip"));
                    DropDownListDistrict.Items.Add(new ListItem("Tempilang", "Tempilang"));
                    break;

                case "Bangka Selatan":
                    DropDownListDistrict.Items.Add(new ListItem("Air Gegas", "Air Gegas"));
                    DropDownListDistrict.Items.Add(new ListItem("Payung", "Payung"));
                    DropDownListDistrict.Items.Add(new ListItem("Pulau Besar", "Parittiga"));
                    DropDownListDistrict.Items.Add(new ListItem("Simpang Teritip", "Simpang Teritip"));
                    DropDownListDistrict.Items.Add(new ListItem("Tempilang", "Tempilang"));
                    break;

                case "Bangka Tengah":
                    DropDownListDistrict.Items.Add(new ListItem("Koba", "Koba"));
                    DropDownListDistrict.Items.Add(new ListItem("Lubuk Besar", "Lubuk Besar"));
                    DropDownListDistrict.Items.Add(new ListItem("Pangkalan Baru", "Pangkalan Baru"));
                    DropDownListDistrict.Items.Add(new ListItem("Simpang Katis", "Simpang Katis"));
                    break;

                case "Belitung":
                    DropDownListDistrict.Items.Add(new ListItem("Badau", "Badau"));
                    DropDownListDistrict.Items.Add(new ListItem("Membalong", "Membalong"));
                    DropDownListDistrict.Items.Add(new ListItem("Selat Nasik", "Selat Nasik"));
                    break;

                case "Belitung Timur":
                    DropDownListDistrict.Items.Add(new ListItem("Damar", "Damar"));
                    DropDownListDistrict.Items.Add(new ListItem("Dendang", "Dendang"));
                    DropDownListDistrict.Items.Add(new ListItem("Kelapa Kampit", "Kelapa Kampit"));
                    break;

                case "Pangkal Pinang":
                    DropDownListDistrict.Items.Add(new ListItem("Rangkui", "Rangkui"));
                    DropDownListDistrict.Items.Add(new ListItem("Taman Sari", "Taman Sari"));
                    DropDownListDistrict.Items.Add(new ListItem("Girimaya", "Girimaya"));
                    break;

                case "Cilegon":
                    DropDownListDistrict.Items.Add(new ListItem("Cibeber", "Cibeber"));
                    DropDownListDistrict.Items.Add(new ListItem("Cilegon", "Cilegon"));
                    DropDownListDistrict.Items.Add(new ListItem("Citangkil", "Citangkil"));
                    DropDownListDistrict.Items.Add(new ListItem("Ciwandan", "Ciwandan"));
                    DropDownListDistrict.Items.Add(new ListItem("Gerogol", "Gerogol"));
                    DropDownListDistrict.Items.Add(new ListItem("Jombang", "Jombang"));
                    DropDownListDistrict.Items.Add(new ListItem("Pulomerak", "Pulomerak"));
                    DropDownListDistrict.Items.Add(new ListItem("Purwakerta", "Purwakerta"));
                    break;

                case "Kota Serang":
                    DropDownListDistrict.Items.Add(new ListItem("Serang", "Serang"));
                    break;

                case "Lebak":
                    DropDownListDistrict.Items.Add(new ListItem("Banjarsari", "Banjarsari"));
                    DropDownListDistrict.Items.Add(new ListItem("Bayah", "Bayah"));
                    DropDownListDistrict.Items.Add(new ListItem("Cibadak", "Cibadak"));
                    break;

                case "Pandenglang":
                    DropDownListDistrict.Items.Add(new ListItem("Majasari", "Majasari"));
                    DropDownListDistrict.Items.Add(new ListItem("Banjar", "Banjar"));
                    break;

                case "Serang":
                    DropDownListDistrict.Items.Add(new ListItem("Bandung", "Bandung"));
                    DropDownListDistrict.Items.Add(new ListItem("Anyar", "Anyar"));
                    DropDownListDistrict.Items.Add(new ListItem("Bojonegara", "Bojonegara"));
                    DropDownListDistrict.Items.Add(new ListItem("Curug", "Curug"));
                    break;

                case "Tangerang":
                    DropDownListDistrict.Items.Add(new ListItem("Batu Ceper", "Batu Ceper"));
                    DropDownListDistrict.Items.Add(new ListItem("Benda", "Benda"));
                    DropDownListDistrict.Items.Add(new ListItem("Cengkareng", "Cengkareng"));
                    DropDownListDistrict.Items.Add(new ListItem("Ciledug", "Ciledug"));
                    DropDownListDistrict.Items.Add(new ListItem("Kelapa Dua", "Kelapa Dua"));
                    break;

                case "Tangerang Selatan":
                    DropDownListDistrict.Items.Add(new ListItem("Ciputat", "Ciputat"));
                    DropDownListDistrict.Items.Add(new ListItem("Ciputat Timur", "Ciputat Timur"));
                    DropDownListDistrict.Items.Add(new ListItem("Pamulang", "Pamulang"));
                    DropDownListDistrict.Items.Add(new ListItem("Pondok Aren", "Pondok Aren"));
                    DropDownListDistrict.Items.Add(new ListItem("Serpong", "Serpong"));
                    DropDownListDistrict.Items.Add(new ListItem("Serpong Utara", "Serpong Utara"));
                    break;

                case "Bantul":
                    DropDownListDistrict.Items.Add(new ListItem("Sewon", "Sewon"));
                    DropDownListDistrict.Items.Add(new ListItem("Bantul", "Bantul"));
                    DropDownListDistrict.Items.Add(new ListItem("Sradakan", "Sradakan"));
                    break;

                case "Sleman":
                    DropDownListDistrict.Items.Add(new ListItem("Depok", "Depok"));
                    DropDownListDistrict.Items.Add(new ListItem("Prambanan", "Prambanan"));
                    break;

                case "Wonosari":
                    DropDownListDistrict.Items.Add(new ListItem("Wonosari", "Wonosari"));
                    break;

                case "Jakarta Barat":
                    DropDownListDistrict.Items.Add(new ListItem("Cengkareng", "Cengkareng"));
                    DropDownListDistrict.Items.Add(new ListItem("Kalideres", "Kalideres"));
                    DropDownListDistrict.Items.Add(new ListItem("Kebon Jeruk", "Kebon Jeruk"));
                    DropDownListDistrict.Items.Add(new ListItem("Palmerah", "Palmerah"));
                    DropDownListDistrict.Items.Add(new ListItem("Taman Sari", "Taman Sari"));
                    break;

                case "Jakarta Pusat":
                    DropDownListDistrict.Items.Add(new ListItem("Cempaka Putih", "Cempaka Putih"));
                    DropDownListDistrict.Items.Add(new ListItem("Gambir", "Gambir"));
                    DropDownListDistrict.Items.Add(new ListItem("Kemayoran", "Kemayoran"));
                    DropDownListDistrict.Items.Add(new ListItem("Palmerah", "Palmerah"));
                    DropDownListDistrict.Items.Add(new ListItem("Menteng", "Menteng"));
                    DropDownListDistrict.Items.Add(new ListItem("Sawah Besar", "Sawah Besar"));
                    DropDownListDistrict.Items.Add(new ListItem("Senen", "Senen"));
                    DropDownListDistrict.Items.Add(new ListItem("Tanah Abang", "Tanah Abang"));
                    break;

                case "Jakarta Selatan":
                    DropDownListDistrict.Items.Add(new ListItem("Pancoran", "Pancoran"));
                    DropDownListDistrict.Items.Add(new ListItem("Pasar Minggu", "Pasar Minggu"));
                    DropDownListDistrict.Items.Add(new ListItem("Setia Budi", "Setia Budi"));
                    DropDownListDistrict.Items.Add(new ListItem("Tebet", "Tebet"));
                    break;

                case "Jakarta Timur":
                    DropDownListDistrict.Items.Add(new ListItem("Cakung", "Cakung"));
                    DropDownListDistrict.Items.Add(new ListItem("Duren Sawit", "Duren Sawit"));
                    DropDownListDistrict.Items.Add(new ListItem("Matraman", "Matraman"));
                    break;

                case "Jakarta Utara":
                    DropDownListDistrict.Items.Add(new ListItem("Kelapa Gading", "Kelapa Gading"));
                    DropDownListDistrict.Items.Add(new ListItem("Koja", "Koja"));
                    DropDownListDistrict.Items.Add(new ListItem("Pademangan", "Pademangan"));
                    DropDownListDistrict.Items.Add(new ListItem("Penjaringan", "Penjaringan"));
                    DropDownListDistrict.Items.Add(new ListItem("Tanjung Priok", "Tanjung Priok"));
                    break;

                case "Bandung":
                    DropDownListDistrict.Items.Add(new ListItem("Andir", "Andir"));
                    DropDownListDistrict.Items.Add(new ListItem("Arjasari", "Arjasari"));
                    DropDownListDistrict.Items.Add(new ListItem("Cidadap", "Arjasari"));
                    DropDownListDistrict.Items.Add(new ListItem("Kertasari", "Kertasari"));
                    break;

                case "Bandung Barat":
                    DropDownListDistrict.Items.Add(new ListItem("Cisarua", "Cisarua"));
                    DropDownListDistrict.Items.Add(new ListItem("Rongga", "Rongga"));
                    DropDownListDistrict.Items.Add(new ListItem("Saguling", "Saguling"));
                    DropDownListDistrict.Items.Add(new ListItem("Sidangkerta", "Sidangkerta"));
                    break;

                case "Bogor":
                    DropDownListDistrict.Items.Add(new ListItem("Bojonggede", "Bojonggede"));
                    DropDownListDistrict.Items.Add(new ListItem("Ciawi", "Ciawi"));
                    DropDownListDistrict.Items.Add(new ListItem("Cibinong", "Cibinong"));
                    DropDownListDistrict.Items.Add(new ListItem("Cileungsi", "Cileungsi"));
                    DropDownListDistrict.Items.Add(new ListItem("Kemang", "Kemang"));
                    break;

                case "Cirebon":
                    DropDownListDistrict.Items.Add(new ListItem("Ciledug", "Ciledug"));
                    DropDownListDistrict.Items.Add(new ListItem("Gebang", "Gegesik"));
                    DropDownListDistrict.Items.Add(new ListItem("Losari", "Losari"));
                    break;

                case "Depok":
                    DropDownListDistrict.Items.Add(new ListItem("Cipayung", "Cipayung"));
                    DropDownListDistrict.Items.Add(new ListItem("Limo", "Limo"));
                    DropDownListDistrict.Items.Add(new ListItem("Pancoran Mas", "Pancoran Mas"));
                    DropDownListDistrict.Items.Add(new ListItem("Tapos", "Tapos"));
                    DropDownListDistrict.Items.Add(new ListItem("Sawangan", "Sawangan"));
                    break;

                case "Karawang":
                    DropDownListDistrict.Items.Add(new ListItem("Tirtajaya", "Tirtajaya"));
                    DropDownListDistrict.Items.Add(new ListItem("Purwasari", "Purwasari"));
                    DropDownListDistrict.Items.Add(new ListItem("Jayakerta", "Jayakerta"));
                    DropDownListDistrict.Items.Add(new ListItem("Karawang Barat", "Karawang Barat"));
                    break;

                case "Kota Bogor":
                    DropDownListDistrict.Items.Add(new ListItem("Bogor Tengah", "Bogor Tengah"));
                    break;

                case "Semarang":
                    DropDownListDistrict.Items.Add(new ListItem("Ambarawa", "Ambarawa"));
                    DropDownListDistrict.Items.Add(new ListItem("Tugu", "Tugu"));
                    DropDownListDistrict.Items.Add(new ListItem("Bawen", "Bawen"));
                    break;

                case "Semarang Kota":
                    DropDownListDistrict.Items.Add(new ListItem("Pedurungan", "Pedurungan"));
                    break;

                case "Solo":
                    DropDownListDistrict.Items.Add(new ListItem("Gemawang", "Gemawang"));
                    DropDownListDistrict.Items.Add(new ListItem("Jebres", "Jebres"));
                    DropDownListDistrict.Items.Add(new ListItem("Kartosuro", "Kartosuro"));
                    DropDownListDistrict.Items.Add(new ListItem("Pasar Kliwon", "Pasar Kliwon"));
                    DropDownListDistrict.Items.Add(new ListItem("Sanggrahan", "Sanggrahan"));
                    break;

                case "Singkawang":
                    DropDownListDistrict.Items.Add(new ListItem("Singkawang Barat", "Singkawang Barat"));
                    DropDownListDistrict.Items.Add(new ListItem("Singkawang Timur", "Singkawang Timur"));
                    DropDownListDistrict.Items.Add(new ListItem("Singkawang Selatan", "Singkawang Selatan"));
                    DropDownListDistrict.Items.Add(new ListItem("Singkawang Tengah", "Singkawang Tengah"));
                    DropDownListDistrict.Items.Add(new ListItem("Singkawang Utara", "Singkawang Utara"));
                    break;

                case "Banjar":
                    DropDownListDistrict.Items.Add(new ListItem("Aluh - aluh", "Aluh - aluh"));
                    DropDownListDistrict.Items.Add(new ListItem("Aranio", "Aranio"));
                    DropDownListDistrict.Items.Add(new ListItem("Matraman", "Matraman"));

                    break;

                case "Banjar Baru":
                    DropDownListDistrict.Items.Add(new ListItem("Cempaka", "Cempaka"));
                    DropDownListDistrict.Items.Add(new ListItem("Landasan Ulin", "Landasan Ulin"));
                    break;

                case "Banjarmasin":
                    DropDownListDistrict.Items.Add(new ListItem("Banjarmasin Barat", "Banjarmasin Barat"));
                    DropDownListDistrict.Items.Add(new ListItem("Banjarmasin Selatan", "Banjarmasin Selatan"));
                    break;

                case "Balikpapan":
                    DropDownListDistrict.Items.Add(new ListItem("Balikpapan Barat", "Banjarmasin Barat"));
                    DropDownListDistrict.Items.Add(new ListItem("Balikpapan Timur", "Banjarmasin Timur"));
                    break;

                case "Samarinda":
                    DropDownListDistrict.Items.Add(new ListItem("Samarinda Ulu", "Samarinda Ulu"));
                    DropDownListDistrict.Items.Add(new ListItem("Sambutan", "Sambutan"));
                    break;

                case "Bulungan":
                    DropDownListDistrict.Items.Add(new ListItem("Peso", "Peso"));
                    DropDownListDistrict.Items.Add(new ListItem("Peso Hilir", "Peso Hilir"));
                    DropDownListDistrict.Items.Add(new ListItem("Pulau Bunyu", "Pulau Bunyu"));
                    break;

                case "Malinau":
                    DropDownListDistrict.Items.Add(new ListItem("Pujungan", "Pujungan"));
                    DropDownListDistrict.Items.Add(new ListItem("Sungai Boh", "Sungai Boh"));
                    DropDownListDistrict.Items.Add(new ListItem("Sungai Tubu", "Sungai Tubu"));
                    break;

                case "Batam":
                    DropDownListDistrict.Items.Add(new ListItem("Galang", "Galang"));
                    DropDownListDistrict.Items.Add(new ListItem("Nongsa", "Nongsa"));
                    DropDownListDistrict.Items.Add(new ListItem("Batam Kota", "Batam Kota"));
                    break;

                case "Lingga":
                    DropDownListDistrict.Items.Add(new ListItem("Senayang", "Senayang"));
                    DropDownListDistrict.Items.Add(new ListItem("Singkep", "Singkep"));
                    DropDownListDistrict.Items.Add(new ListItem("Termiang Pasir", "Termiang Pasir"));
                    break;

                case "Natuna":
                    DropDownListDistrict.Items.Add(new ListItem("Midai", "Midai"));
                    DropDownListDistrict.Items.Add(new ListItem("Serasan", "Serasan"));
                    DropDownListDistrict.Items.Add(new ListItem("Subi", "Subi"));
                    break;

                case "Tanjung Pinang":
                    DropDownListDistrict.Items.Add(new ListItem("Bukit Bestari", "Bukit Bestari"));
                    break;

                case "Bandar Lampung":
                    DropDownListDistrict.Items.Add(new ListItem("Enggal", "Enggal"));
                    DropDownListDistrict.Items.Add(new ListItem("Kedamaian", "Kedamaian"));
                    DropDownListDistrict.Items.Add(new ListItem("Suka Bumi", "Suka Bumi"));
                    break;

                case "Lampung Barat":
                    DropDownListDistrict.Items.Add(new ListItem("Air Hitam", "Air Hitam"));
                    DropDownListDistrict.Items.Add(new ListItem("Balik Bukit", "Balik Bukit"));
                    DropDownListDistrict.Items.Add(new ListItem("Batu Brak", "Batu Brak"));
                    break;

                case "Lampung Selatan":
                    DropDownListDistrict.Items.Add(new ListItem("Sragi", "Sragi"));
                    DropDownListDistrict.Items.Add(new ListItem("Way Panji", "Way Panji"));
                    DropDownListDistrict.Items.Add(new ListItem("Way Sulan", "Way Sulan"));
                    break;

                case "Lampung Tengah":
                    DropDownListDistrict.Items.Add(new ListItem("Trimurjo", "Trimurjo"));
                    DropDownListDistrict.Items.Add(new ListItem("Rumbia", "Rumbia"));
                    DropDownListDistrict.Items.Add(new ListItem("Kalirejo", "Kalirejo"));
                    break;

                case "Lampung Timur":
                    DropDownListDistrict.Items.Add(new ListItem("Jabung", "Jabung"));
                    DropDownListDistrict.Items.Add(new ListItem("Melinting", "Melinting"));
                    DropDownListDistrict.Items.Add(new ListItem("Sekampung", "Sekampung"));
                    break;

                case "Lampung Utara":
                    DropDownListDistrict.Items.Add(new ListItem("Abang Tinggi", "Abang Tinggi"));
                    DropDownListDistrict.Items.Add(new ListItem("Kotabumi", "Kotabumi"));
                    DropDownListDistrict.Items.Add(new ListItem("Sungkai Barat", "Sungkai Barat"));
                    break;
                case "Majane":
                    DropDownListDistrict.Items.Add(new ListItem("Malunda", "Malunda"));
                    DropDownListDistrict.Items.Add(new ListItem("Pamboang", "Pamboang"));
                    DropDownListDistrict.Items.Add(new ListItem("Sendana", "Sendana"));
                    break;

                case "Mamasa":
                    DropDownListDistrict.Items.Add(new ListItem("Balla", "Balla"));
                    DropDownListDistrict.Items.Add(new ListItem("Bambang", "Bambang"));
                    DropDownListDistrict.Items.Add(new ListItem("Mamasa", "Mamasa"));
                    break;

                case "Mamuju":
                    DropDownListDistrict.Items.Add(new ListItem("Bonehau", "Bonehau"));
                    DropDownListDistrict.Items.Add(new ListItem("Kalumpung", "Kalumpung"));
                    DropDownListDistrict.Items.Add(new ListItem("Tapalang", "Tapalang"));
                    break;

                case "Mamuju Tengah":
                    DropDownListDistrict.Items.Add(new ListItem("Karossa", "Karossa"));
                    DropDownListDistrict.Items.Add(new ListItem("Tobadak", "Tobadak"));
                    DropDownListDistrict.Items.Add(new ListItem("Topoyo", "Topoyo"));
                    break;

                case "Makassar":
                    DropDownListDistrict.Items.Add(new ListItem("Ujung Pandang", "Ujung Pandang"));
                    DropDownListDistrict.Items.Add(new ListItem("Ujung Tanah", "Ujung Tanah"));
                    DropDownListDistrict.Items.Add(new ListItem("Wajo", "Wajo"));
                    break;

                case "Maros":
                    DropDownListDistrict.Items.Add(new ListItem("Maros Baru", "Maros Baru"));
                    DropDownListDistrict.Items.Add(new ListItem("Marusu", "Marusu"));
                    DropDownListDistrict.Items.Add(new ListItem("Turikale", "Turikale"));
                    break;
            }
        }

        protected void DropDownListDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedDistrict = DropDownListDistrict.SelectedValue;
            Session["District"] = selectedDistrict;  
        }

        protected void DisplayCartProducts()
        {
            try
            {
                if (Session["SelectedProductIds"] == null) return;

                List<int> selectedProductIds = (List<int>)Session["SelectedProductIds"];
                if (selectedProductIds.Count == 0) return;

                int customer_id = Convert.ToInt32(Session["userID"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    string query = @"SELECT Products.product_name as p_name, Products.product_price as p_price, Products.product_image as p_img, Cart.quantity as q 
                             FROM Products 
                             INNER JOIN Cart ON Products.Id = Cart.product_id 
                             WHERE Cart.user_id = @customerId AND Cart.product_id IN (@productIds) AND Cart.status = 0";

                    string productIds = string.Join(",", selectedProductIds);
                    query = query.Replace("@productIds", productIds);

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@customerId", customer_id);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string productName = reader["p_name"].ToString();
                            string productPrice = reader["p_price"].ToString();
                            string productImage = reader["p_img"].ToString();
                            string quantity = reader["q"].ToString();

                            string productHtml = "<div class=\"cart-item\">";
                            productHtml += $"<img src='{ResolveUrl("~/product/" + productImage)}' class='cart-item-image' />";
                            productHtml += $"<div class=\"cart-item-details\">";
                            productHtml += $"<h3 class=\"cart-item-name\">{productName}</h3>";
                            productHtml += $"<p class=\"cart-item-price\">RM {productPrice}</p>";
                            productHtml += $"<p class=\"cart-item-quantity\">Quantity: {quantity}</p>";
                            productHtml += $"</div></div>";

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error retrieving cart products: " + ex.ToString());
            }
        
    }
        protected void FillUserDetails()
        {

            int customer_id = Convert.ToInt32(Session["userID"]);

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    string query = "SELECT customer_name, customer_address, customer_phone, " +
                        "district, province, city FROM CustomerOrder WHERE userID = @customerId ORDER BY id DESC";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@customerId", customer_id);

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            TextBox1.Text = reader["customer_name"].ToString();
                            TextBox2.Text = reader["customer_address"].ToString();
                            TextBox3.Text = reader["customer_phone"].ToString();
                        }
                    }
                }
            }
            catch
            {
                return;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(TextBox1.Text) ||
                string.IsNullOrEmpty(TextBox3.Text) ||
                string.IsNullOrEmpty(TextBox2.Text) ||
                string.IsNullOrEmpty(DropDownListProvince.SelectedValue) ||
                string.IsNullOrEmpty(DropDownListCity.SelectedValue))
            {
                errMsg.Text = "Please fill in all required fields.";
                errMsg.Visible = true;
                return;
            }

            // Store user details in session
            Session["CustomerName"] = TextBox1.Text;
            Session["CustomerAddress"] = TextBox2.Text;
            Session["CustomerPhone"] = TextBox3.Text;
            Session["Province"] = DropDownListProvince.SelectedValue;
            Session["City"] = DropDownListCity.SelectedValue;

            //Response.Redirect("paymentdetails.aspx");
            Response.Redirect("paymentdetails.aspx?prev=checkout");
        }
    }
}

