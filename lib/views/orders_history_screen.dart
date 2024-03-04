import 'package:b05/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TestController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders History'),
      ),
      body: Obx(() {
        var orders = controller.orders;

        return orders.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var order = orders[index];

                  return ListTile(
                    title: Text(
                      "${order.products.length} Products",
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Order Details"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...order.products
                                          .map((e) => ListTile(
                                                title: Text(e.product.name),
                                                leading: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(image: NetworkImage(e.product.image), fit: BoxFit.cover),
                                                  ),
                                                ),
                                                trailing: Text(e.price.toString()),
                                                subtitle: Text(
                                                  "Unit Price: ${e.product.price}, Qty: ${e.quantity}",
                                                  style: TextStyle(fontSize: 10),
                                                ),
                                              ))
                                          .toList(),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [Text("Total: "), Text(order.totalSum.toString())],
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Dismiss"))
                                ],
                              ));
                    },
                    trailing: Text(order.totalSum.toString()),
                    subtitle: Text(DateFormat('dd MMM yyyy - hh:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(order.timestamp))),
                  );
                },
                itemCount: orders.length,
                shrinkWrap: true,
                reverse: true,
              )
            : Center(
                child: Text("No orders yet"),
              );
      }),
    );
  }
}
