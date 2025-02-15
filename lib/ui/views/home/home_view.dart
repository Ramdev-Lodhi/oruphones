import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oruphones/ui/widgets/footer.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/accordion.dart';
import '../../widgets/banners.dart';
import '../../widgets/brands.dart';
import '../../widgets/category.dart';
import '../../widgets/filter_bottomsheet.dart';
import '../../widgets/product_grid.dart';
import '../../widgets/sort_bottomsheet.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => SingleChildScrollView(
        child: Column(
          children: [
            BannerWidgets(),
            CategoryWidgets(),
            BrandListWidget(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Best Deal Near You (India)",
                      style: TextStyle(fontSize: 18)),
                  Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      final selectedSort = await showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SortBottomSheet(),
                      );
                      if (selectedSort != null) {
                        print("Selected Sort Option: $selectedSort");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: Icon(Icons.sort, color: Colors.black),
                    label: Row(
                      children: [
                        Text("Sort", style: TextStyle(color: Colors.black)),
                        SizedBox(width: 5),
                        Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => FilterBottomSheet(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: Icon(Icons.tune_sharp, color: Colors.black),
                    label: Row(
                      children: [
                        Text("Filters", style: TextStyle(color: Colors.black)),
                        SizedBox(width: 5),
                        Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ProductGrid(),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // Add some spacing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 24, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 20),
            Accordion(),
            SizedBox(height: 20),
            Footer(),
          ],
        ),
      ),
    );
  }
}
