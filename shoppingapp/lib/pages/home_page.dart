import 'package:flutter/material.dart';
import 'package:shoppingapp/productlist.dart';

class ECommerceHomePage extends StatefulWidget {
  ECommerceHomePage({Key? key}) : super(key: key);

  @override
  State<ECommerceHomePage> createState() => _ECommerceHomePageState();
}

class _ECommerceHomePageState extends State<ECommerceHomePage> {
  final List<Product> cart = [];
  final List<String> categories = ['Phones', 'Laptops', 'Watches', 'Cameras'];
  final List<Map<String, String>> featuredProducts = [
    {
      'name': 'iPhone 16',
      'price': 'GH₵999',
      'image':
          'https://imageio.forbes.com/specials-images/imageserve/66f72215b501ed9bba57d064/An-Apple-iPhone-16-Pro-in-different-colors/960x0.jpg?format=jpg&width=1440',
    },
    {
      'name': 'MacBook Air',
      'price': 'GH₵1299',
      'image':
          'https://www.technocratng.com/wp-content/uploads/2021/03/Apple-MacBook-Air-with-Retina-display-2019-Gold.png',
    },
    {
      'name': 'Galaxy Watch',
      'price': 'GH₵199',
      'image':
          'https://i0.wp.com/directdealz.lk/wp-content/uploads/2024/09/Samsung-Galaxy-Watch-FE-40mm-Smart-Watch-7.jpg?fit=1200%2C1335&ssl=1',
    },
    {
      'name': 'Canon EOS',
      'price': 'GH₵699',
      'image':
          'https://i5.walmartimages.com/seo/Canon-EOS-4000D-DSLR-Camera-EF-S-18-55-mm-f-3-5-5-6-III-Lens_e1553ace-0600-40a4-8949-527a893a00ad.1c87b334cff4d61363dc1fed877909d7.jpeg',
    },
  ];

  void _addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopMate'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products',
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 10),

          // Categories
          Text('Categories', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => SizedBox(width: 12),
              itemBuilder: (context, index) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductApp(
                        category: categories[index],
                        cart: cart,
                        onAddToCart: _addToCart,
                      ),
                    ),
                  );
                },
                child: Text(categories[index]),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Promotional Banner using Stack
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?fit=crop&w=800&q=80',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black45,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mega Sale',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Up to 50% Off',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Featured Products Grid
          Text(
            'Featured Products',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),

          SingleChildScrollView(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: featuredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              product['image']!,
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
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          product['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product['price']!,
                          style: TextStyle(color: Colors.green[2]),
                        ),
                      ),
                      // Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> cart;
  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (c, e, s) => Icon(Icons.broken_image),
                  ),
                  title: Text(product.name),
                  subtitle: Text('GH₵${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
