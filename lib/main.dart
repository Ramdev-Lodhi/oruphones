import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oruphones/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'state/auth_bloc.dart';  // ✅ BLoC Class Import
import 'state/theme_provider.dart';  // ✅ Provider Class Import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // ✅ Provider Example
        BlocProvider(
          create: (_) => AuthBloc(locator<AuthService>()), // ✅ Fix Applied
        ), // ✅ BLoC Example
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ORUPhones',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.splashView,
      theme: Provider.of<ThemeProvider>(context).currentTheme, // ✅ Provider Se Theme Apply
    );
  }
}
