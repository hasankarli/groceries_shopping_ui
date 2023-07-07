class Product {
  final String name;
  final String description;
  final double price;
  final String image;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class ProductItem {
  final Product product;
  int quantity;

  ProductItem({required this.product, required this.quantity});
}

final products = [
  Product(
      name: 'Newman\'s Own Sockarooni Pasta Sauce',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 6.02,
      image: 'assets/images/products/product1.png'),
  Product(
      name: 'Newman\'s Own Sockarooni Pasta Sauce ',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 6.02,
      image: 'assets/images/products/product1.png'),
  Product(
      name: 'Seggiano Organic Tagliatelle',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 7.99,
      image: 'assets/images/products/product2.png'),
  Product(
      name: 'Rummo Fusilli No\n48 Pasta',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 14.99,
      image: 'assets/images/products/product3.png'),
  Product(
      name: 'Biona Organic\nWhite Spelt Fusilli',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 3.69,
      image: 'assets/images/products/product4.png'),
  Product(
      name: 'Seggiano Organic Tagliatelle ',
      description:
          'Rummo, a family business of master pasta makers since 1846. Your sauce deserves the best tasting gluten-free pasta!',
      price: 7.99,
      image: 'assets/images/products/product2.png'),
];
