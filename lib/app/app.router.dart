// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:oruphones/models/product_model.dart' as _i10;
import 'package:oruphones/ui/views/auth/confirm_name_view.dart' as _i5;
import 'package:oruphones/ui/views/auth/login_view.dart' as _i3;
import 'package:oruphones/ui/views/auth/verify_otp_view.dart' as _i4;
import 'package:oruphones/ui/views/filter/filterproduct_view.dart' as _i8;
import 'package:oruphones/ui/views/home/home_view.dart' as _i7;
import 'package:oruphones/ui/views/main/main_view.dart' as _i6;
import 'package:oruphones/ui/views/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const splashView = '/';

  static const loginView = '/login-view';

  static const verifyOtpView = '/verify-otp-view';

  static const confirmNameView = '/confirm-name-view';

  static const mainView = '/main-view';

  static const homeView = '/home-view';

  static const filterproductView = '/filterproduct-view';

  static const all = <String>{
    splashView,
    loginView,
    verifyOtpView,
    confirmNameView,
    mainView,
    homeView,
    filterproductView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.verifyOtpView,
      page: _i4.VerifyOtpView,
    ),
    _i1.RouteDef(
      Routes.confirmNameView,
      page: _i5.ConfirmNameView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i6.MainView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i7.HomeView,
    ),
    _i1.RouteDef(
      Routes.filterproductView,
      page: _i8.FilterproductView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplashView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(),
        settings: data,
      );
    },
    _i4.VerifyOtpView: (data) {
      final args = data.getArgs<VerifyOtpViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.VerifyOtpView(phoneNumber: args.phoneNumber),
        settings: data,
      );
    },
    _i5.ConfirmNameView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ConfirmNameView(),
        settings: data,
      );
    },
    _i6.MainView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.MainView(),
        settings: data,
      );
    },
    _i7.HomeView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.HomeView(),
        settings: data,
      );
    },
    _i8.FilterproductView: (data) {
      final args = data.getArgs<FilterproductViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.FilterproductView(
            key: args.key, filterproduct: args.filterproduct),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class VerifyOtpViewArguments {
  const VerifyOtpViewArguments({required this.phoneNumber});

  final String phoneNumber;

  @override
  String toString() {
    return '{"phoneNumber": "$phoneNumber"}';
  }

  @override
  bool operator ==(covariant VerifyOtpViewArguments other) {
    if (identical(this, other)) return true;
    return other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode;
  }
}

class FilterproductViewArguments {
  const FilterproductViewArguments({
    this.key,
    required this.filterproduct,
  });

  final _i9.Key? key;

  final List<_i10.ProductModel> filterproduct;

  @override
  String toString() {
    return '{"key": "$key", "filterproduct": "$filterproduct"}';
  }

  @override
  bool operator ==(covariant FilterproductViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.filterproduct == filterproduct;
  }

  @override
  int get hashCode {
    return key.hashCode ^ filterproduct.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyOtpView({
    required String phoneNumber,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verifyOtpView,
        arguments: VerifyOtpViewArguments(phoneNumber: phoneNumber),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToConfirmNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.confirmNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFilterproductView({
    _i9.Key? key,
    required List<_i10.ProductModel> filterproduct,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.filterproductView,
        arguments:
            FilterproductViewArguments(key: key, filterproduct: filterproduct),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerifyOtpView({
    required String phoneNumber,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verifyOtpView,
        arguments: VerifyOtpViewArguments(phoneNumber: phoneNumber),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithConfirmNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.confirmNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFilterproductView({
    _i9.Key? key,
    required List<_i10.ProductModel> filterproduct,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.filterproductView,
        arguments:
            FilterproductViewArguments(key: key, filterproduct: filterproduct),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
