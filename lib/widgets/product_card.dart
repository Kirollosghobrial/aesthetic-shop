import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl, 
                height: 100, 
                width: double.infinity, 
                fit: BoxFit.cover
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title, 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.green),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Cart.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.title} added to cart")),
                );
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}