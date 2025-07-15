import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  });
}

class ProductApp extends StatelessWidget {
  final String category;
  final List<Product> cart;
  final void Function(Product) onAddToCart;
  ProductApp({
    Key? key,
    required this.category,
    required this.cart,
    required this.onAddToCart,
  }) : super(key: key);

  final List<Product> products = [
    // Phones
    Product(
      name: 'iPhone 16',
      price: 999.0,
      imageUrl:
          'https://imageio.forbes.com/specials-images/imageserve/66f72215b501ed9bba57d064/An-Apple-iPhone-16-Pro-in-different-colors/960x0.jpg?format=jpg&width=1440',
      category: 'Phones',
      description:
          'The iPhone 16 features a new A18 chip, improved battery life, and a stunning OLED display for immersive viewing.',
    ),
    Product(
      name: 'Samsung Galaxy S24 Ultra',
      price: 899.0,
      imageUrl:
          'https://electrolandgh.com/wp-content/uploads/2024/04/africa-en-galaxy-s24-s928-490614-sm-s928bzkwafb-539859856-jpg.webp',
      category: 'Phones',
      description:
          'Samsung Galaxy S24 Ultra offers a 200MP camera, 120Hz AMOLED display, and long-lasting battery for power users.',
    ),
    Product(
      name: 'Google Pixel 8',
      price: 799.0,
      imageUrl:
          'https://static0.pocketlintimages.com/wordpress/wp-content/uploads/2023/10/google-pixel-8-grey-1-1.jpg',
      category: 'Phones',
      description:
          'Google Pixel 8 brings the best of Android with a clean UI, excellent camera, and Googles latest AI features.',
    ),
    Product(
      name: 'OnePlus 12',
      price: 699.0,
      imageUrl:
          'https://spectronic.com.au/wp-content/uploads/2024/04/Oneplus-12-Green.png',
      category: 'Phones',
      description:
          'OnePlus 12 delivers fast performance, smooth OxygenOS, and Warp Charge for quick top-ups.',
    ),
    Product(
      name: 'Huawei P60',
      price: 599.0,
      imageUrl:
          'https://consumer.huawei.com/content/dam/huawei-cbg-site/common/mkt/pdp/admin-image/phones/p60-art/azure-blue.png',
      category: 'Phones',
      description:
          'Huawei P60 stands out with its advanced camera system and elegant design.',
    ),
    Product(
      name: 'Realme 12',
      price: 499.0,
      imageUrl: 'https://media.wisemarket.com.pk/product/realme-12-67.webp',
      category: 'Phones',
      description:
          'Realme 12 is a budget-friendly phone with a large display and reliable battery life.',
    ),
    // Laptops
    Product(
      name: 'MacBook Air',
      price: 1299.0,
      imageUrl:
          'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/macbook-air-og-202503?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1739216814915',
      category: 'Laptops',
      description:
          'Apple MacBook Air is ultra-light, with the M2 chip for fast performance and all-day battery.',
    ),
    Product(
      name: 'Dell XPS 13',
      price: 1199.0,
      imageUrl:
          'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc4/Dell-XPS-13-9340-laptop.JPG',
      category: 'Laptops',
      description:
          'Dell XPS 13 features a near-borderless display and premium build quality for professionals.',
    ),
    Product(
      name: 'Lenovo ThinkPad X1 Carbon',
      price: 1199.0,
      imageUrl:
          'https://p3-ofp.static.pub//fes/cms/2024/07/05/3euk5fn03von01bjlreh1bmgmzp3kf055467.png',
      category: 'Laptops',
      description:
          'Lenovo ThinkPad X1 Carbon is a business-class laptop with legendary keyboard and durability.',
    ),
    Product(
      name: 'MacBook Pro',
      price: 1499.0,
      imageUrl: 'https://iparts.com.gh/wp-content/uploads/2025/02/m4-max-1.jpg',
      category: 'Laptops',
      description:
          'MacBook Pro is designed for creators, with a powerful processor and brilliant Retina display.',
    ),
    Product(
      name: 'Microsoft Surface',
      price: 1099.0,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Surface_Pro_9_in_Sapphire_colour.jpg/960px-Surface_Pro_9_in_Sapphire_colour.jpg',
      category: 'Laptops',
      description:
          'Microsoft Surface is a versatile 2-in-1 laptop for productivity and creativity on the go.',
    ),
    // Watches
    Product(
      name: 'Galaxy Watch',
      price: 199.0,
      imageUrl:
          'https://i0.wp.com/directdealz.lk/wp-content/uploads/2024/09/Samsung-Galaxy-Watch-FE-40mm-Smart-Watch-7.jpg?fit=1200%2C1335&ssl=1',
      category: 'Watches',
      description:
          'Samsung Galaxy Watch FE offers fitness tracking, notifications, and a stylish look.',
    ),
    Product(
      name: 'Apple Watch Series 9',
      price: 399.0,
      imageUrl:
          'https://m.media-amazon.com/images/I/712wglSBTaL._AC_SL1500_.jpg',
      category: 'Watches',
      description:
          'Apple Watch Series 9 features advanced health sensors and seamless integration with iPhone.',
    ),
    Product(
      name: 'OnePlus Watch 3',
      price: 359.0,
      imageUrl:
          'https://image01.oneplus.net/media/202502/11/2420d5ac3cc36e8422d9711d917bc17c.jpg?x-amz-process=image/format,webp/quality,Q_80',
      category: 'Watches',
      description:
          'OnePlus Watch 3 is a stylish smartwatch with long battery life and fitness features.',
    ),
    Product(
      name: 'Apple Watch Ultra 2',
      price: 799.0,
      imageUrl:
          'https://powermaccenter.com/cdn/shop/files/Apple_Watch_Ultra_2_LTE_49mm_Titanium_Blue_Ocean_Band_PDP_Image_Position-1__en-US_4baecc60-c2cf-48d9-b333-6cdfa1248ebe.jpg?v=1699531392&width=1920',
      category: 'Watches',
      description:
          'Apple Watch Ultra 2 is built for adventure, with rugged design and advanced GPS.',
    ),
    // Cameras
    Product(
      name: 'Canon EOS 4000D',
      price: 699.0,
      imageUrl:
          'https://i5.walmartimages.com/seo/Canon-EOS-4000D-DSLR-Camera-EF-S-18-55-mm-F-3-5-5-6-III-Lens-Intl-Model_87e41624-5053-4b1b-b177-14b31e8ea8e2_1.f52dbc3ff9348a7535ac8ccb49b2dc08.jpeg?odnHeight=320&odnWidth=320&odnBg=FFFFFF',
      category: 'Cameras',
      description:
          'Canon EOS 4000D is a beginner-friendly DSLR with easy controls and great image quality.',
    ),
    Product(
      name: 'Nikon D3500',
      price: 499.0,
      imageUrl:
          'https://photographylife.com/wp-content/uploads/2019/07/Nikon-D3500.jpg',
      category: 'Cameras',
      description:
          'Nikon D3500 is a compact DSLR with excellent battery life and user-friendly interface.',
    ),
    Product(
      name: 'Sony Alpha A7 III',
      price: 1999.0,
      imageUrl:
          'https://i5.walmartimages.com/seo/Sony-Alpha-a7-III-Mirrorless-Digital-Camera-with-28-70mm-Lens_288e30c4-4949-4141-ab72-b4d9b7170105_1.53e9c79b9bc776f24226d4c3fee05c38.jpeg',
      category: 'Cameras',
      description:
          'Sony Alpha A7 III is a full-frame mirrorless camera for professionals and enthusiasts.',
    ),
    Product(
      name: 'Nikon D7500',
      price: 1499.0,
      imageUrl:
          'https://www.photobohemian.com/wp-content/uploads/Nikon-D7500.jpg',
      category: 'Cameras',
      description:
          'Nikon D7500 is a high-end DSLR with fast autofocus and 4K video recording.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((p) => p.category == category)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          '$category List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
                title: Text(product.name),
                subtitle: Text('GH₵${product.price.toStringAsFixed(2)}'),
                trailing: Icon(Icons.shopping_cart),
                onTap: () {
                  // Optionally, show product details or add to cart
                  onAddToCart(product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
