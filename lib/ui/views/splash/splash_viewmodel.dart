import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';

class SplashViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void initialize() async {
    await Future.delayed(Duration(seconds: 3));

    var isLogin = await _authService.isLoggedIn();
    print("User logged in: $isLogin");

    if (isLogin) {
      var user = await _authService.getCurrentUser();
      print("Fetched user: $user");

      if (user != null && user.isNotEmpty) {
        _navigationService.replaceWith(Routes.mainView);
      } else {
        _navigationService.replaceWith(Routes.confirmNameView);
      }
    } else {
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
