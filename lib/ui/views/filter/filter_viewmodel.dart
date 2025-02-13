import 'package:stacked/stacked.dart';
import '../../../models/filter_model.dart';
import '../../../services/filter_service.dart';


class FilterViewModel extends BaseViewModel {
  final FilterService _filterService = FilterService();
  FilterModel? filters;
  String selectedCategory = "Brand";

  List<String> filteredBrands = [];
  List<String> selectedBrands = [];
  Map<String, List<String>> selectedOptions = {};

  double minPrice = 0;
  double maxPrice = 100000;
  double priceRange = 50000;




  Future<void> loadFilters() async {
    setBusy(true);
    filters = await _filterService.fetchFilters();
    print(filters?.brands);
    if (filters != null) {
      print("filters is available");
      filteredBrands = filters!.brands;
      print(filteredBrands);
    } else {
      print("Error: filters is null");
      filters = FilterModel(brands: [], ram: [], storage: [], conditions: [], warranty: []);
    }

    setBusy(false);
    notifyListeners();  // UI Update ke liye notifyListeners add kiya
  }


  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void searchBrand(String query) {
    filteredBrands = filters!.brands
        .where((brand) => brand.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // Toggle Single Brand Selection
  void toggleBrandSelection(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
    notifyListeners();
  }

  // Select All Brands
  bool get isAllBrandsSelected => selectedBrands.length == filteredBrands.length;

  void toggleSelectAllBrands(bool selectAll) {
    if (selectAll) {
      selectedBrands = List.from(filteredBrands);
    } else {
      selectedBrands.clear();
    }
    notifyListeners();
  }

  // Check if All Options Selected for a Category
  bool isAllSelected(String category) {
    return selectedOptions[category]?.length == (filters?.getOptions(category).length ?? 0);
  }

  // Select/Deselect All for a Category
  void toggleSelectAll(String category, bool selectAll) {
    if (selectAll) {
      selectedOptions[category] = List.from(filters!.getOptions(category));
    } else {
      selectedOptions[category]?.clear();
    }
    notifyListeners();
  }

  // Toggle Selection for an Individual Option
  void toggleOptionSelection(String category, String option) {
    if (!selectedOptions.containsKey(category)) {
      selectedOptions[category] = [];
    }

    if (selectedOptions[category]!.contains(option)) {
      selectedOptions[category]!.remove(option);
    } else {
      selectedOptions[category]!.add(option);
    }
    notifyListeners();
  }

  void setMinPrice(String value) {
    double parsedValue = double.tryParse(value) ?? 1000;
    minPrice = parsedValue.clamp(1000, maxPrice); // Ensure minPrice is within range
    notifyListeners();
  }

  void setMaxPrice(String value) {
    double parsedValue = double.tryParse(value) ?? 50000;
    maxPrice = parsedValue.clamp(minPrice, 50000); // Ensure maxPrice is within range
    notifyListeners();
  }

  void updatePriceRange(double value) {
    priceRange = value.clamp(1000, 50000); // Ensure price is within range
    notifyListeners();
  }

  void applyFilters() {
    print("Filters Applied!");
  }

  void resetFilters() {
    selectedBrands.clear();
    selectedOptions.clear();
    minPrice = 0;
    maxPrice = 100000;
    notifyListeners();
  }
}

