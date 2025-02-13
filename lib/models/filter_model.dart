class FilterModel {
  List<String> brands;
  List<String> ram;
  List<String> storage;
  List<String> conditions;
  List<String> warranty;
  List<String> verification = ["Verified Only"];
  FilterModel({
    required this.brands,
    required this.ram,
    required this.storage,
    required this.conditions,
    required this.warranty,
  });

  factory FilterModel.fromJson(Map<String, dynamic>? json) {
    return FilterModel(
      brands: List<String>.from(json?["Brand"]),
      ram: List<String>.from(json?["Ram"]),
      storage: List<String>.from(json?["Storage"]),
      conditions: List<String>.from(json?["Conditions"]),
      warranty: List<String>.from(json?["Warranty"]),
    );
  }


  List<String> getOptions(String category) {
    switch (category) {
      case "Brand":
        return brands;
      case "RAM":
        return ram;
      case "Storage":
        return storage;
      case "Condition":
        return conditions;
      case "Warranty":
        return warranty;
      case "Verification":
        return verification;
      default:
        return [];
    }
  }
}
