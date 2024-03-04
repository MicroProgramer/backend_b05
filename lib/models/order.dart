import 'package:b05/models/product.dart';

class Order {
  String id;
  Product product;
  int quantity;

  Order({
    required this.id,
    required this.product,
    required this.quantity,
  });

  double get price => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'product': this.product.toMap(),
      'quantity': this.quantity,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      product: Product.fromMap(Map<String, dynamic>.from(map['product'])),
      quantity: map['quantity'] as int,
    );
  }
}
