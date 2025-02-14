import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../widgets/product_card.dart';

class FilterproductView extends StatelessWidget {
  final List<ProductModel> filterproduct;

  const FilterproductView({Key? key, required this.filterproduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filtered Products")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.55,
          ),
          itemCount: filterproduct.length,
          itemBuilder: (context, index) {
            return ProductCard(product: filterproduct[index]);
          },
        ),
      ),
    );
  }
}