class Product {
  final int? id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}