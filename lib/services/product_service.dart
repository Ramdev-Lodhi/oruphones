import 'package:dio/dio.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // ✅ Get FAQs
  Future<List<dynamic>?> getFAQs() async {
    Response? response = await _apiService.getRequest("/faq");
    return response?.data;
  }

  // ✅ Apply Filters
  Future<List<dynamic>?> applyFilters(Map<String, dynamic> filters) async {
    Response? response = await _apiService.postRequest("/filter", filters);
    return response?.data;
  }

  // ✅ Add to Favorites
  Future<bool> addToFavorites(Map<String, dynamic> favData) async {
    Response? response = await _apiService.postRequest("/favs", favData);
    return response != null && response.statusCode == 200;
  }

  // ✅ Get Products with Images
  Future<List<dynamic>?> getProducts() async {
    Response? response = await _apiService.getRequest("/makeWithImages");
    return response?.data;
  }

  // ✅ Get Search Filters
  Future<List<dynamic>?> getSearchFilters() async {
    Response? response = await _apiService.getRequest("/showSearchFilters");
    return response?.data;
  }
}
