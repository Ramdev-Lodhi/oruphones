import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../views/filter/filter_viewmodel.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<FilterViewModel>.reactive(
      viewModelBuilder: () => FilterViewModel(),
      onModelReady: (viewModel) => viewModel.loadFilters(),
      builder: (context, viewModel, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),

              Expanded(
                child: Row(
                  children: [
                    // Left Sidebar
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: ListView(
                        children: [
                          _buildCategoryItem("Brand", viewModel),
                          _buildCategoryItem("Condition", viewModel),
                          _buildCategoryItem("Storage", viewModel),
                          _buildCategoryItem("RAM", viewModel),
                          _buildCategoryItem("Verification", viewModel),
                          _buildCategoryItem("Warranty", viewModel),
                          _buildCategoryItem("Price Range", viewModel),
                        ],
                      ),
                    ),

                    // Right Side
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildRightPanel(viewModel,context),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: viewModel.resetFilters,
                    child: Text("Clear All", style: TextStyle(color: Colors.orange)),
                  ),
                  ElevatedButton(
                    onPressed: viewModel.applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF6C018),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    ),
                    child: Text(" Apply ", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(String title, FilterViewModel viewModel) {
    bool isSelected = viewModel.selectedCategory == title;

    return Container(
      color: isSelected ? Colors.yellow.shade50 : Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => viewModel.selectCategory(title),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // **Right Side Dynamic Panel**
  Widget _buildRightPanel(FilterViewModel viewModel,BuildContext context) {
    if (viewModel.filters == null) {
      return Center(child: CircularProgressIndicator());
    }

    switch (viewModel.selectedCategory) {
      case "Brand":
        return _buildBrandFilter(viewModel);
      case "RAM":
        return _buildCheckboxFilter("RAM", viewModel.filters!.ram, viewModel);
      case "Storage":
        return _buildCheckboxFilter("Storage", viewModel.filters!.storage, viewModel);
      case "Condition":
        return _buildCheckboxFilter("Condition", viewModel.filters!.conditions, viewModel);
      case "Warranty":
        return _buildCheckboxFilter("Warranty", viewModel.filters!.warranty, viewModel);
      case "Verification":
        return _buildCheckboxFilter("Verification", viewModel.filters!.verification, viewModel);
      case "Price Range":
        return _buildPriceRange(viewModel,context);
      default:
        return Center(child: Text("Select a category"));
    }
  }


  Widget _buildBrandFilter(FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: viewModel.searchBrand,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            hintText: "Search brands...",
            prefixIcon: Icon(Icons.search, color: Colors.orangeAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: viewModel.isAllBrandsSelected,
              onChanged: (selected) {
                viewModel.toggleSelectAllBrands(selected!);
              },
            ),
            Text(
              "All Brands",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Divider(),
        Expanded(
          child: ListView(
            children: viewModel.filteredBrands.map((brand) {
              return Padding(
                padding: EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: viewModel.selectedBrands.contains(brand),
                      onChanged: (selected) {
                        viewModel.toggleBrandSelection(brand);
                      },
                    ),
                    Expanded(child: Text(brand)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


  Widget _buildCheckboxFilter(String title, List<String> options, FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            Checkbox(
              value: viewModel.isAllSelected(title),
              onChanged: (selected) {
                viewModel.toggleSelectAll(title, selected!);
              },
            ),
            Text("All", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        Divider(),
        Expanded(
          child: ListView(
            children: options.map((option) {
              return Padding(
                padding: EdgeInsets.only(left: 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: viewModel.selectedOptions[title]?.contains(option) ?? false,
                      onChanged: (selected) {
                        viewModel.toggleOptionSelection(title, option);
                      },
                    ),
                    Expanded(child: Text(option)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }



  Widget _buildPriceRange(FilterViewModel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text("Maximum Price", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("₹${viewModel.maxPrice.toInt()}",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 250,
          child: RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
                activeTrackColor: Colors.black,
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.black,
                overlayColor: Colors.black.withOpacity(0.2),
              ),
              child: RangeSlider(
                values: RangeValues(
                  viewModel.minPrice.clamp(1000, 50000),
                  viewModel.maxPrice.clamp(1000, 50000),
                ),
                min: 1000,
                max: 50000,
                divisions: 10,
                labels: RangeLabels(
                  "₹${viewModel.minPrice.toInt()}",
                  "₹${viewModel.maxPrice.toInt()}",
                ),
                onChanged: (RangeValues values) {
                  viewModel.setMinPrice(values.start.toString());
                  viewModel.setMaxPrice(values.end.toString());
                },
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text("₹${viewModel.minPrice.toInt()}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Minimum Price", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

}
