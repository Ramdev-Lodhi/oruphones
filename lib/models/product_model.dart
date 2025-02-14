class ProductModel {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final List<ImageModel> images;
  final ImageModel? defaultImage;
  final String listingState;
  final String listingLocation;
  final bool isVerified;

  ProductModel({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.images,
    required this.defaultImage,
    required this.listingState,
    required this.listingLocation,
    required this.isVerified,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"] ?? "",
      deviceCondition: json["deviceCondition"] ?? "",
      listedBy: json["listedBy"] ?? "",
      deviceStorage: json["deviceStorage"] ?? "",
      images: (json["images"] as List<dynamic>)
          .map((img) => ImageModel.fromJson(img))
          .toList(),
      defaultImage: json["defaultImage"] != null
          ? ImageModel.fromJson(json["defaultImage"])
          : null,
      listingState: json["listingState"] ?? "",
      listingLocation: json["listingLocation"] ?? "",
      isVerified: json["isVarified"] == "accepted",
    );
  }
}

class ImageModel {
  final String thumbImage;
  final String fullImage;

  ImageModel({required this.thumbImage, required this.fullImage});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      thumbImage: json["thumbImage"] ?? "",
      fullImage: json["fullImage"] ?? "",
    );
  }
}
