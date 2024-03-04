import 'package:b05/models/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({required this.product, required this.quantity});

  double get totalPrice {
    return quantity * product.price;
  }

  void increment() {
    quantity++;
  }
  void decrement() {
    if (quantity == 0) return;
    quantity--;
  }
}