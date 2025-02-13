import 'package:dio/dio.dart';
import '../models/filter_model.dart';

class FilterService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://40.90.224.241:5000"));

  Future<FilterModel?> fetchFilters() async {
    try {
      Response response = await _dio.get("/showSearchFilters");
      print(response);
      if (response.statusCode == 200 && response.data["status"] == "SUCCESS") {
        return FilterModel.fromJson(response.data["dataObject"]);
      }
    } catch (e) {
      print("Error fetching filters: $e");
    }
    return null;
  }
}
