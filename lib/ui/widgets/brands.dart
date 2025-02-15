import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/brand_model.dart';
import '../views/home/home_viewmodel.dart';

class BrandListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.fetchBrands(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return Center(child: CircularProgressIndicator());
        }
        if (model.brands.isEmpty) {
          return Center(child: Text("No brands available"));
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Brands",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.brands.length > 10 ? 11 : model.brands.length,
                itemBuilder: (context, index) {
                  if (index == 10) {
                    return _viewAllButton(context, model.brands);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: _brandItem(model.brands[index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _brandItem(BrandModel brand) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Align(
          alignment: Alignment.center,
          child: ClipOval(
            child: Image.network(
              brand.imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }


  Widget _viewAllButton(BuildContext context, List<BrandModel> brands) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => _showBrandBottomSheet(context, brands),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "View All",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(width: 4), // Space between text & arrow
              Icon(Icons.arrow_forward, size: 16, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }


  void _showBrandBottomSheet(BuildContext context, List<BrandModel> brands) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.47,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select a Brand",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    return _brandItembottomsheet(brands[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _brandItembottomsheet(BrandModel brand) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Card(
        elevation: 2,
        shape: CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          child: Align(
            alignment: Alignment.center,
            child: Image.network(
              brand.imagePath,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
