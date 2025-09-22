import 'product.dart';

List<Product> cart = [];

class Cart {
  static List<Product> get items => cart;

  static void add(Product product) {
    cart.add(product);
  }

  static void remove(Product product) {
    cart.remove(product);
  }

  static void removeAt(int index) {
    cart.removeAt(index);
  }

  static void clear() {
    cart.clear();
  }
}