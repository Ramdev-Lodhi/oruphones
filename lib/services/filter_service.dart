import 'package:dio/dio.dart';
import '../models/filter_model.dart';
import 'api_service.dart';

class FilterService {
  final ApiService _apiService = ApiService();

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
