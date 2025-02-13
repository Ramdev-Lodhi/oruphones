class BrandModel {
  final String make;
  final String imagePath;

  BrandModel({required this.make, required this.imagePath});

  // Factory method to convert JSON into a BrandModel object
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      make: json["make"] ?? "",
      imagePath: json["imagePath"] ?? "",
    );
  }

  // Method to convert BrandModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      "make": make,
      "imagePath": imagePath,
    };
  }
}
