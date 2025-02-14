import 'package:dio/dio.dart';
import '../models/brand_model.dart';
import '../models/faq_model.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  // Get FAQs
  Future<List<FAQModel>?> getFAQs() async {
    try {
      Response? response = await _apiService.getRequest("/faq");
      if (response != null && response.statusCode == 200) {
        List<dynamic> data = response.data['FAQs'];
        return data.map((json) => FAQModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching FAQs: $e");
    }
    return null;
  }

  // Apply Filters
  Future<List<dynamic>?> applyFilters(Map<String, dynamic> filters) async {
    Response? response = await _apiService.postRequest("/filter", filters);
    return response?.data;
  }

  //  Add to Favorites
  Future<bool> addToFavorites(Map<String, dynamic> favData) async {
    Response? response = await _apiService.postRequest("/favs", favData);
    return response != null && response.statusCode == 200;
  }

  // Get Products with Images
  Future<List<BrandModel>?> getBrands() async {
    Response? response = await _apiService.getRequest("/makeWithImages");
    print(response);
    if (response?.data != null && response?.data is Map<String, dynamic>) {
      List<dynamic> brandList = response?.data["dataObject"] ?? [];
      return brandList.map((brand) => BrandModel.fromJson(brand)).toList();
    }
    return null;
  }

  // Get Search Filters
  Future<List<dynamic>?> getSearchFilters() async {
    Response? response = await _apiService.getRequest("/showSearchFilters");
    return response?.data;
  }
}
