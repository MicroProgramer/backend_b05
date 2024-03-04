import 'package:b05/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenInputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var desController = TextEditingController();
    var priceController = TextEditingController();
    var imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(label: Text("Name")),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: desController,
                decoration: InputDecoration(label: Text("Description")),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: priceController,
                decoration: InputDecoration(label: Text("Price")),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: imageController,
                decoration: InputDecoration(label: Text("Image Url")),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  var name = nameController.text;
                  var des = desController.text;
                  var price = double.tryParse(priceController.text) ?? 0;
                  var image = imageController.text;

                  var id = UniqueKey().toString();

                  var product = Product(
                    id: id,
                    name: name,
                    description: des,
                    price: price,
                    image: image,
                  );
                  Get.back(result: product);
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
