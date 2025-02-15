import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:oruphones/models/user_model.dart';
import 'package:oruphones/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:oruphones/models/brand_model.dart';
import 'package:oruphones/services/product_service.dart';
import '../../../app/app.locator.dart';
import '../../../models/faq_model.dart';
import '../../../models/product_model.dart';
import '../../../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final AuthService _authService = locator<AuthService>();
  bool isLoadingMore = false;
  bool isLoggedIn = false;
  List<BrandModel> brands = [];

  Future<void> fetchBrands() async {
    setBusy(true);
    brands = await _productService.getBrands() ?? [];
    setBusy(false);
    notifyListeners();
  }

  List<ProductModel> productList = [];

  Future<void> loadProducts() async {
    setBusy(true); // Show loading state
    try {
      final String response =
          await rootBundle.loadString('assets/data/products.json');
      final data = json.decode(response);
      // print("Full JSON: $data");
      // print("Products List: ${data['products']}");
      if (data["products"] == null) {
        throw Exception("Products key is missing in JSON");
      }

      productList = (data["products"] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      final currentUser = _authService.currentUser;
      print(currentUser?.favListings);
      if (currentUser?.favListings != null) {
        print(" fav listings${currentUser?.favListings}");
        for (var product in productList) {
          print(product.id);
          if (currentUser!.favListings.contains(product.id)) {
            product.isLiked = true;
          }
        }
      }
      // print("Mapped Products: $productList");
    } catch (e) {
      // print("Error loading products: $e");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  HomeViewModel() {
    loadProducts();
  }

  List<FAQModel>? faqs = [];

  Future<void> fetchFAQs() async {
    setBusy(true);
    faqs = await _productService.getFAQs();
    setBusy(false);
    notifyListeners();
  }

  void toggleFAQ(int index) {
    faqs![index].isExpanded = !faqs![index].isExpanded;
    notifyListeners();
  }

  Future<void> fetchMoreProducts() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    List<ProductModel> newProducts = List.generate(
        5,
        (index) => ProductModel(
              id: index.toString(),
              listedBy: "User $index",
              deviceStorage: "128GB",
              deviceCondition: "Good",
              listingLocation: "Mumbai",
              listingState: "Maharashtra",
              isVerified: index % 2 == 0,
              isLiked: false,
              defaultImage: ImageModel(
                  fullImage:
                      "https://res.cloudinary.com/dflq4agdp/image/upload/v1739604789/image_or9dnc.png",
                  thumbImage:
                      'https://res.cloudinary.com/dflq4agdp/image/upload/v1739604789/image_or9dnc.png'),
              images: [],
            ));

    productList.addAll(newProducts);
    isLoadingMore = false;
    notifyListeners();
  }


  void toggleFavorite(int index) async {
    ProductModel product = productList[index];
    product.isLiked = !product.isLiked;
    notifyListeners();
    bool success = await _productService.addToFavorites(product.id);
    if (!success) {
      product.isLiked = !product.isLiked;
      notifyListeners();
    }
  }

  Future<bool> loginUser() async {
    await Future.delayed(Duration(seconds: 2));
    isLoggedIn = true;
    notifyListeners();
    return true;
  }
}
