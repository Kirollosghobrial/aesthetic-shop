import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../L10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  
  const CartScreen({required this.setLocale, Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _switchLanguage() {
    final currentLocale = Localizations.localeOf(context);
    final newLocale = currentLocale.languageCode == 'ar' 
        ? const Locale('en') 
        : const Locale('ar');
    widget.setLocale(newLocale);
  }

  double getTotalPrice() {
    return cart.fold(0, (total, product) => total + product.price);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("${loc!.translate('app_title')} - Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: _switchLanguage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          "Your cart is empty",
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final Product product = cart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl, 
                            width: 56, 
                            height: 56, 
                            fit: BoxFit.cover
                          ),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                Cart.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cart.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Checkout logic here
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}