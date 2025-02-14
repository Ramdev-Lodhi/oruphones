import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:oruphones/models/brand_model.dart';
import 'package:oruphones/services/product_service.dart';
import '../../../app/app.locator.dart';
import '../../../models/faq_model.dart';
import '../../../models/product_model.dart';
import '../../../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

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
}
