import 'package:flutter/material.dart';
import '../L10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  
  const WelcomeScreen({required this.setLocale, Key? key}) : super(key: key);

  void _switchLanguage(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    final newLocale = currentLocale.languageCode == 'ar' 
        ? const Locale('en') 
        : const Locale('ar');
    setLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.translate('app_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _switchLanguage(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // two images in a row: local + online
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/local_logo.png",
                    height: 100,
                    width: 100,
                    errorBuilder: (_, __, ___) => Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.shopping_cart, size: 40),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.network(
                    "https://picsum.photos/150",
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Welcome to Our Shop",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(loc.translate('welcome_sign_up')),
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: Text(loc.translate('welcome_sign_in')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}