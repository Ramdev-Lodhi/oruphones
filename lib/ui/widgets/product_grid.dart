import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oruphones/ui/widgets/dummyCard.dart';
import 'package:oruphones/ui/widgets/product_card.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../services/auth_service.dart';
import '../components/bottom_sheets.dart';
import '../views/home/home_viewmodel.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late ScrollController _scrollController;
  final AuthService _authService = locator<AuthService>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<HomeViewModel>().fetchMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
              if (index == viewModel.productList.length) {
                return viewModel.isLoadingMore
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox.shrink();
              }
              if ((index + 1) % 8 == 0) {
                return ((index + 1) ~/ 8) % 2 == 1 ? _buildDummyProduct() : _buildDummyProduct2();
              }

              return ProductCard(
                product: viewModel.productList[index],
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
        );
      },
    );
  }

  Widget _buildDummyProduct() {
    return Dummycard(
      title: "Want to sell your Phone?",
      description: "Make some extra cash by selling your old phone near you",
      buttonText: "SELL NOW",
      onPressed: () {},
      image1: "assets/images/hand_phone.png",
      image2: "assets/images/money.png",
    );
  }

  Widget _buildDummyProduct2() {
    return Dummycard(
      title: "Compare and Get the Best Deal",
      description: "Compare prices across multiple sellers before making your purchase",
      buttonText: "Compare Price",
      onPressed: () {},
      image3: "assets/category/3.png",
    );
  }

}
