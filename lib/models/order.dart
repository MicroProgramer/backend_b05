import 'package:b05/models/product.dart';

class Order {
  String id;
  List<OrderCartItem> products;
  int timestamp;

  Order({required this.id, required this.products, required this.timestamp});

  double get totalSum {
    double sum = 0;
    products.forEach((element) {
      sum += element.price;
    });
    return sum;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'products': this.products.map((e) => e.toMap()).toList(),
      'timestamp': this.timestamp,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      products: (map['products'] as List<dynamic>).map((e) => OrderCartItem.fromMap(e as Map<String, dynamic>)).toList(),
      timestamp: map['timestamp'] as int,
    );
  }
}

class OrderCartItem {
  Product product;
  int quantity;

  OrderCartItem({required this.product, required this.quantity});

  double get price => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product': this.product.toMap(),
      'quantity': this.quantity,
    };
  }

  factory OrderCartItem.fromMap(Map<String, dynamic> map) {
    return OrderCartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }


}
