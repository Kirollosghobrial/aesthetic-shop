import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/welcome_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'models/product.dart';
import 'L10n/app_localizations.dart';

// Global cart list (accessible from anywhere)
List<Product> cart = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(setLocale: setLocale),
        '/signin': (context) => SignInScreen(setLocale: setLocale),
        '/signup': (context) => SignUpScreen(setLocale: setLocale),
        '/home': (context) => HomeScreen(setLocale: setLocale),
        '/cart': (context) => CartScreen(setLocale: setLocale),
      },
    );
  }
}