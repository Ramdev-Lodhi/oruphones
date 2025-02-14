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
        print('Data ${viewModel.productList.length}');
        return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 2,
              mainAxisSpacing: 4,
            ),

            itemCount: viewModel.productList.length,
            itemBuilder: (context, index) {
              return ProductCard(product: viewModel.productList[index]);
            },
          ),
        );
      },
    );
  }
}
