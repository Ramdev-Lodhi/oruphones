import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset(
            "assets/splashscreen/Splash.json",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
