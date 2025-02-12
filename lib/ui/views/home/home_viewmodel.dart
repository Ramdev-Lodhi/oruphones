import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/product_service.dart';


class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

  List<String> products = [];

  Future<void> fetchProducts() async {
    setBusy(true);
    products = List<String>.from(await _productService.getProducts() ?? []);
    setBusy(false);
    notifyListeners(); // UI update karega
  }
}
