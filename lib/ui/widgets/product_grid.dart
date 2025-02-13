import 'package:flutter/material.dart';
import 'package:oruphones/ui/widgets/product_card.dart';
import 'package:stacked/stacked.dart';
import '../views/home/home_viewmodel.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: viewModel.productList.length,
          itemBuilder: (context, index) {
            return ProductCard(product: viewModel.productList[index]);
          },
        );
      },
    );
  }
}
