class ProductModel {
  final String imageUrl;
  final String title;
  final double price;
  final double oldPrice;
  final String location;
  final String date;
  final bool isVerified;
  final bool isFavorite;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.location,
    required this.date,
    this.isVerified = false,
    this.isFavorite = false,
  });

  // Factory method to create an instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json['imageUrl'],
      title: json['title'],
      price: json['price'].toDouble(),
      oldPrice: json['oldPrice'].toDouble(),
      location: json['location'],
      date: json['date'],
      isVerified: json['isVerified'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Convert object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
      'oldPrice': oldPrice,
      'location': location,
      'date': date,
      'isVerified': isVerified,
      'isFavorite': isFavorite,
    };
  }
}
