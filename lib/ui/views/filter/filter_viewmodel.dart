
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/filter_model.dart';
import '../../../models/product_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/product_service.dart';


class FilterViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
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
    filters = await _productService.fetchFilters();
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
    notifyListeners();
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


  bool isAllSelected(String category) {
    return selectedOptions[category]?.length == (filters?.getOptions(category).length ?? 0);
  }


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
    minPrice = parsedValue.clamp(1000, maxPrice);
    notifyListeners();
  }

  void setMaxPrice(String value) {
    double parsedValue = double.tryParse(value) ?? 50000;
    maxPrice = parsedValue.clamp(minPrice, 50000);
    notifyListeners();
  }

  void updatePriceRange(double value) {
    priceRange = value.clamp(1000, 50000);
    notifyListeners();
  }
  List<ProductModel> filterproduct = [];
  void applyFilters() async {
    print("Applying Filters...");

    Map<String, dynamic> filterParams = {
      "filter": {
        "condition": selectedOptions["Condition"] ?? [],
        "make": selectedBrands.isNotEmpty ? selectedBrands : [],
        "storage": selectedOptions["Storage"] ?? [],
        "ram": selectedOptions["RAM"] ?? [],
        "warranty": selectedOptions["Warranty"] ?? [],
        "priceRange": [minPrice.toInt(), maxPrice.toInt()],
        "verified": selectedOptions["Verification"]?.contains("Verified Only") ?? true,
        "sort": {},
        "page": 1,
      }
    };

    print(filterParams);

    setBusy(true);
    try {
      var response = await _productService.fetchFilteredData(filterParams);
      print("Filtered Response: $response");
      if (response != null) {
        filterproduct = response.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
        print(filterproduct);
        final currentUser = _authService.currentUser;
        print(currentUser?.favListings);
        if (currentUser?.favListings != null) {
          for (var product in filterproduct) {
            if (currentUser!.favListings.contains(product.id)) {
              product.isLiked = true;
            }
          }
        }
        print("Filtered Data Fetched Successfully!");
        _navigationService.navigateTo(
          Routes.filterproductView,
          arguments: FilterproductViewArguments(filterproduct: filterproduct),
        );
      } else {
        filterproduct = [];
        print("No Data Found!");
      }
    } catch (e) {
      print("Error fetching filtered data viewmodel: $e");
    }
    setBusy(false);
  }


  void resetFilters() {
    selectedBrands.clear();
    selectedOptions.clear();
    minPrice = 0;
    maxPrice = 100000;
    notifyListeners();
  }
}

