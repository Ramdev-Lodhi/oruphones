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
    final String response =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> data = json.decode(response);
    productList = data.map((item) => ProductModel.fromJson(item)).toList();
    notifyListeners();
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
