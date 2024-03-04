import 'package:b05/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: GetBuilder(
        builder: (logic) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var item = logic.selectedProducts[index];

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
                      subtitle: Text(item.price.toString()),
                      trailing: GetBuilder<CartItemController>(
                        tag: item.id,
                        builder: (cartLogic) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cartLogic.increment();
                                  logic.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "+",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    cartLogic.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  cartLogic.decrement();
                                  logic.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "-",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          );
                        },
                        init: Get.put(CartItemController(product: item), tag: item.id),
                      ),
                    );
                  },
                  itemCount: logic.selectedProducts.length,
                ),
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.all(20),
                color: Colors.grey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'TOTAL:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rs. ${logic.totalSum}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        logic.placeOrder();
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order placed successfully')));
                      },
                      child: Text('Place Order'),
                    )
                  ],
                ),
              )
            ],
          );
        },
        init: Get.put(TestController()),
      ),
    );
  }
}
