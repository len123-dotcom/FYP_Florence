<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<style>



					.container-product{
						max-width:1200px;
						margin: 0 auto;
						padding: 20px;
					}

					.content{
						display: flex;
						flex-wrap: wrap;
						gap: 20px;
						justify-content: center;
					}

					.box{
					width: 300px;
					border-radius: 10px;
					overflow: hidden;
					background-color: #fff;
					box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
					transition: transform 0.3s ease;
					border: 1px solid black;
					cursor: pointer;
					}
					.box:hover {
					transform: translateY(-5px);
					}

					.box img {
					width: 100%;
					height:300px;
					object-fit: cover;
					}

					.product-details {
					padding: 15px;
					}

					.product-title {
					font-weight: bold;
					margin: 0 0 10px 0;
					font-size: 18px;
					}

					.product-price {
					font-weight: bold;
					margin: 0 0 5px 0;
					}



					.box a{
					color: #000;
					text-decoration: none;
					}




				</style>
			</head>
			<body>
				<div class="container-product">
					<div class="content">
						<xsl:for-each select="products/product">

							<div class ="box">
								<a href="productDetail?product_id={Id}">

									<xsl:element name="img">
										<xsl:attribute name="class">
											img
										</xsl:attribute>
										<xsl:attribute name="src">
											/product/<xsl:value-of select="product_image"/>
										</xsl:attribute>
									</xsl:element>

									<div class="product-details">
										<h3 class="product-title">
											<xsl:value-of select="product_name"/>
										</h3>
										<p class="product-price">
											Rp<xsl:value-of select="format-number(product_price, '#,###.00')"/>
										</p>
									

										<xsl:choose>
											<xsl:when test="product_quantity &gt; 0">
											
											</xsl:when>

											<xsl:when test="product_quantity &lt;=0">
												<p style="color: red; margin-top: -5px;"> Out of Stock</p>
											</xsl:when>

										</xsl:choose>
									</div>
								</a>
							</div>
						</xsl:for-each>
					</div>
				</div>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>





