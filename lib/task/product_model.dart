class Product {
  final String? id;
  final String? title;
  final String? image;
  final double? price;
  final String? description;
  final int? quantity;

  Product({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    this.quantity = 1,
  });

  // Convert a Product to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  // Create a Product from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String?,
      title: map['title'] as String?,
      image: map['image'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      description: map['description'] as String?,
      quantity: (map['quantity'] as int?) ?? 1,
    );
  }

  // Create a copy of the product with updated values
  Product copyWith({
    String? id,
    String? title,
    String? image,
    double? price,
    String? description,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}