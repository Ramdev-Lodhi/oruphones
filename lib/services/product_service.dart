import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../models/brand_model.dart';
import '../models/faq_model.dart';
import '../models/filter_model.dart';
import 'api_service.dart';
import 'auth_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();
  final AuthService _authService = locator<AuthService>();
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


  //  Add to Favorites
  Future<bool> addToFavorites(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? csrfToken = prefs.getString("csrfToken");
      print(csrfToken);
      print(_authService.currentUser?.csrfToken);
      print(productId);
      Response? response = await _apiService.postRequest(
        "/favs",
        {"listingId": productId, "isFav": true},
        headers: {
          "X-CSRF-Token": "${_authService.currentUser?.csrfToken}",
        },
      );
      if (response != null &&
          response.statusCode == 200 &&
          response.data["success"] == true) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
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


  Future<FilterModel?> fetchFilters() async {
    try {
      Response? response = await _apiService.getRequest("/showSearchFilters");
      print(response);
      if (response?.statusCode == 200 && response?.data["status"] == "SUCCESS") {
        return FilterModel.fromJson(response?.data["dataObject"]);
      }
    } catch (e) {
      print("Error fetching filters: $e");
    }
    return null;
  }

  Future<List<dynamic>?> fetchFilteredData(Map<String, dynamic> filters) async {
    try {
      Response? response = await _apiService.postRequest("/filter", filters);
      print("Response Data: ${response?.data}");
      return response?.data["data"]["data"];
    } catch (e) {
      print("Error fetching filtered data: $e");
    }
    return null;
  }
}
