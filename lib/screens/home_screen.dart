import 'package:flutter/material.dart';
import '../models/product.dart';
// Remove the unused import: import '../models/cart.dart';
import '../widgets/product_card.dart';
import '../widgets/offers_item.dart';
import '../L10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  
  // Remove 'const' from constructor since 'products' is non-constant
  HomeScreen({required this.setLocale, Key? key}) : super(key: key);

  // 👉 Product list WITH price
  final List<Product> products = List.generate(
    6,
    (i) => Product(
      id: i.toString(),
      title: 'Product ${i + 1}',
      imageUrl: 'https://picsum.photos/200?random=${i + 1}',
      price: (i + 1) * 9.99,
    ),
  );

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
        title: Text(loc!.translate('our_products')),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _switchLanguage(context),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Featured products PageView
            SizedBox(
              height: 200,
              child: PageView(
                children: products
                    .map((p) => Image.network(p.imageUrl, fit: BoxFit.cover))
                    .toList(),
              ),
            ),

            // GridView of products
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),

            // Hot Offers
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                loc.translate('hot_offers'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return OffersItem(
                  imageUrl: 'https://picsum.photos/200?offer=$index',
                  description: 'Special discount on Product ${index + 1} - Save up to ${20 + index * 10}%!',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}