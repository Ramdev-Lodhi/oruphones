import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/product_model.dart';
import '../../../services/auth_service.dart';
import '../../components/bottom_sheets.dart';
import '../../widgets/product_card.dart';
import '../../views/home/home_viewmodel.dart';

class FilterproductView extends StatelessWidget {
  final List<ProductModel> filterproduct;

  const FilterproductView({Key? key, required this.filterproduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = locator<AuthService>();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Filtered Products")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.53,
              ),
              itemCount: filterproduct.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filterproduct[index],
                  onFavoriteToggle: () async {
                    bool res = await _authService.isLoggedIn();
                    if (res) {
                      viewModel.toggleFavorite(index);
                    } else {
                      showLoginBottomSheet(context);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
