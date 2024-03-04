import 'package:b05/models/product.dart';
import 'package:b05/views/orders_history_screen.dart';
import 'package:b05/views/screen_cart.dart';
import 'package:b05/views/screen_input_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/test_controller.dart';

class ScreenTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TestController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Test'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      AlertDialog(
                        title: Text('Saved Data'),
                        content: Builder(builder: (context) {
                          var person = Get.put(TestController()).loadDataSync();

                          if (person == null) {
                            return Text('No data saved yet');
                          }

                          return Text('Name: ${person.name}, Age: ${person.age}, Gender: ${person.gender}');
                        }),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Close")),
                          TextButton(
                              onPressed: () {
                                GetStorage().erase();
                                Navigator.pop(context);
                              },
                              child: Text("Clear Data"))
                        ],
                      ),
                );
              },
              icon: Icon(Icons.print)),
          IconButton(
            onPressed: () {
              Get.to(ScreenCart());
            },
            icon: Obx(
              () {
                return Badge(
                  child: Icon(Icons.shopping_cart),
                  label: Text(controller.selectedProducts.length.toString()),
                  isLabelVisible: controller.selectedProducts.isNotEmpty,
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(OrdersHistoryScreen());
            },
            icon: Obx(() {
                return Badge(
                  child: Icon(Icons.history),
                  label: Text(controller.orders.length.toString()),
                  isLabelVisible: controller.orders.isNotEmpty,
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
          return controller.products.isNotEmpty
              ? ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              var item = controller.products[index];

              return ListTile(
                title: Text(item.name),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(item.image), fit: BoxFit.cover),
                  ),
                ),
                subtitle: Text(item.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.price.toString()),
                    Obx(() {
                        return Checkbox(
                            value: controller.selectedProducts.contains(item),
                            onChanged: (_) {
                              controller.selectUnselectProduct(item);
                            });
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: controller.products.length,
          )
              : Center(
            child: Text("No products exist"),
          );
        },

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var product = await Get.to<Product>(ScreenInputData());
          if (product != null) {
            Get.find<TestController>().addProduct(product);
          }
        },
        label: Text("Add product"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
