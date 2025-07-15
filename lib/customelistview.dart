import 'package:flutter/material.dart';

void main() => runApp(ProductApp());

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class ProductApp extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Smartphone',
      price: 699.99,
      imageUrl: 'https://images.unsplash.com/photo-1510552776732-03e61cf4b144',
    ),
    Product(
      name: 'Headphones',
      price: 199.99,
      imageUrl:
          'https://as2.ftcdn.net/v2/jpg/04/27/66/15/1000_F_427661547_ceXaauKleQxdS060pd2AmSHnyaNYWpRy.jpg',
    ),
    Product(
      name: 'Laptop',
      price: 1200.00,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Smartwatch',
      price: 249.99,
      imageUrl:
          'https://i5.walmartimages.com/seo/Mingdaln-Smartwatch-for-Android-and-iPhone-1-39-Inch-Fitness-Tracker-with-Bluetooth-Answer-Make-Calls-for-Men-and-Women-Alloy-Black_6e504f63-6abc-4567-8e4d-c12a543f35b3.20f648fc7baf2e3c776fbc93e42141f1.jpeg?odnHeight=2000&odnWidth=2000&odnBg=FFFFFF',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Product List')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      products[index].imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    products[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'GH₵${products[index].price.toStringAsFixed(2)}',
                  ),
                  trailing: Icon(Icons.shopping_cart),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${products[index].name} selected'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
