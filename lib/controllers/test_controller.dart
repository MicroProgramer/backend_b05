import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import '../models/person.dart';
import '../models/product.dart';

class TestController extends GetxController {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  RxList<Product> products = <Product>[].obs;
  RxList<Product> selectedProducts = <Product>[].obs;
  RxList<Order> orders = <Order>[].obs;

  Future<void> saveData(Person person) async {
    var instance = await SharedPreferences.getInstance();
    var map = person.toMap();
    var json = jsonEncode(map);
    await instance.setString('person', json);
  }

  Future<Person> loadData() async {
    var instance = await SharedPreferences.getInstance();
    var json = instance.getString('person');
    var map = jsonDecode(json!) as Map<String, dynamic>;
    return Person.fromMap(map);
  }

  void saveDataSync(Person person) {
    var map = person.toMap();
    GetStorage().write('person', map);
  }

  Person? loadDataSync() {
    var map = GetStorage().read('person') as Map<String, dynamic>?;
    if (map == null) return null;
    return Person.fromMap(map);
  }

  void addProduct(Product product) {
    var oldProducts = GetStorage().read('products') as List<Map<String, dynamic>>? ?? [];
    oldProducts.add(product.toMap());
    GetStorage().write('products', oldProducts);
  }

  void initGetStorageListen() {
    GetStorage().listenKey('products', (value) {
      initData(value);
    });
  }

  @override
  void onInit() {
    super.onInit();
    initData(GetStorage().read('products'));
    initGetStorageListen();
  }

  void initData(dynamic value) {
    var data = value as List<dynamic>? ?? [];
    print(data);
    products.value = data.map((e) => Product.fromMap(Map<String, dynamic>.from(e))).toList();
    orders.value = getOrdersHistory();
  }

  void selectUnselectProduct(Product product) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
  }

  double get totalSum {
    double sum = 0;
    selectedProducts.forEach((element) {
      sum += Get.put(CartItemController(product: element), tag: element.id).totalPrice;
    });
    return sum;
  }

  void placeOrder() {
    var order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      product: selectedProducts.first,
      quantity: selectedProducts.length,
    );
    selectedProducts.clear();
    orders.value = getOrdersHistory();


    GetStorage().write("order_${order.id}", order.toMap());
  }

  List<Order> getOrdersHistory() {
    List<Order> orders = [];
    var allOrderKeys = GetStorage().getKeys<Iterable<String>>().where((element) => element.startsWith('order_')).toList();

    allOrderKeys.forEach((element) {
      orders.add(Order.fromMap(GetStorage().read(element) as Map<String, dynamic>));
    });

    return orders;
  }
}

class CartItemController extends GetxController {
  var quantity = 0;

  void increment() {
    quantity++;
    update();
  }

  void decrement() {
    if (quantity == 0) return;
    quantity--;
    update();
  }

  double get totalPrice {
    return quantity * product.price;
  }

  Product product;

  CartItemController({
    required this.product,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemController.fromMap(Map<String, dynamic> map) {
    return CartItemController(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 0,
    );
  }
}
