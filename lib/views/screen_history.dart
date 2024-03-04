import 'package:b05/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HistoryController());
    //enum

    return Scaffold(
      appBar: AppBar(title: Text("History"), actions: [
        IconButton(
          onPressed: () {
            controller.clearHistory().then((value) {
              Get.back();
            });
          },
          icon: Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.sort),
        )
      ]),
      body: FutureBuilder<List<String>>(
        future: controller.getOldData(),
        builder: (context, snapshot) {
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          var data = snapshot.data ?? [];
          var students = controller.toStudentsObjects(data);
          students.sort((a, b) => a.age.compareTo(b.age));

          return students.isNotEmpty
              ? ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    var student = students[index];

                    return Card(
                      child: ListTile(
                        title: Text(student.name),
                        leading: Text(student.rollNum.toString()),
                        subtitle: Text("${student.gender} (Age: ${student.age.toString()})"),
                        trailing: Text(DateFormat('hh:mm:ss - dd MMM yyyy EEEE').format(DateTime.fromMillisecondsSinceEpoch(student.timestamp))),
                      ),
                    );
                  })
              : Center(
                  child: Text("No data"),
                );
        },
      ),
    );
  }
}
