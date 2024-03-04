import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../controllers/history_controller.dart';

class ScreenHistoryStream extends StatelessWidget {
  const ScreenHistoryStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text("${controller.students.length} Students");
        }),
          actions: [
            IconButton(
              onPressed: () {
                GetStorage().remove('historyList');
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            )
          ]
      ),
      body: Obx(() => controller.students.isNotEmpty
          ? ListView.builder(
              itemCount: controller.students.length,
              itemBuilder: (context, index) {
                var student = controller.students[index];

                return Card(
                  child: ListTile(
                    title: Text(student.name),
                    leading: Text(student.rollNum.toString()),
                    subtitle: Text("${student.gender} (Age: ${student.age.toString()})"),
                    trailing: Text(DateFormat('hh:mm:ss - dd MMM yyyy EEEE').format(DateTime.fromMillisecondsSinceEpoch(student.timestamp))),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Delete Student"),
                                content: Text("Are you sure you want to delete the student \"${student.name}\"?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.deleteObj(student);
                                      },
                                      child: Text("Delete")),
                                ],
                              ));
                    },
                  ),
                );
              })
          : Center(
              child: Text("No data"),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addRandomStudent();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
