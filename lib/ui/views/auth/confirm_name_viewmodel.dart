import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';


class ConfirmNameViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String name = '';
  bool get isButtonEnabled => name.length >= 1;
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  Future<void> saveName() async {
    if (name.isEmpty) return;
    setBusy(true);
    await _authService.updateUserName(name);
    setBusy(false);
    _navigationService.navigateTo(Routes.mainView);
  }
}
