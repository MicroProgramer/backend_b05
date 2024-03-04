import 'dart:convert';
import 'dart:io';

import 'package:b05/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:path_provider/path_provider.dart';

class HttpDataController extends GetxController {
  var currentCountry = ''.obs;
  Map<String, dynamic> countriesData = {};

  @override
  onInit() {
    super.onInit();
    startFetchingData();
  }

  Future<void> startFetchingData() async {
    var allCountries = allCountriesJson;
    var mainDir = await getApplicationDocumentsDirectory();
    var filePath = '${mainDir.path}/countries_common.json';
    var file = File(filePath);
    if (!await file.exists()) {
      file.createSync(recursive: true);
    } else {
      countriesData = jsonDecode(await file.readAsString());
    }
    print(file.path);

    await Future.forEach(allCountries, (element) async {
      String id = element['Value'].toString();
      String name = element['Name'].toString();
      print("${allCountries.indexOf(element)+1}/${allCountries.length}: $name");
      if (!countriesData.containsKey(id)){

        currentCountry.value = name;
        List<Map<String, dynamic>> availableScales = [];
        var response = await http.post(
          Uri.parse('https://www.scholaro.com/gpa-calculator/Home/Scales_Read?countries=$id&common=1'),
        );
        try {
          availableScales = (jsonDecode(response.body) as List<dynamic>).map((e) => Map<String, dynamic>.from(e)).toList();
        } catch (e) {
          print("Error for $name: $e");
        }

        if (availableScales.isNotEmpty) {
          countriesData[id] = {
            'country': name,
            'availableScales': availableScales
          };
          var scaleDetails = <String, dynamic>{};

          await Future.forEach(availableScales, (scale) async {


            var scaleId = scale['GradingScaleID'].toString();
            print('\t\t\t\t-$scaleId');

            var gradesResponse = await http.get(
              Uri.parse('https://www.scholaro.com/gpa-calculator/Home/GradingScale?id=$scaleId'),
            );
            try {

              if (gradesResponse.statusCode == 200) {
                final htmlBody = gradesResponse.body;
                final document = htmlParser.parse(htmlBody);
                final scriptElement = document.querySelector('script');
                final scriptText = scriptElement?.text ?? '';

                RegExp regExp = RegExp(r'"Data"\s*:\s*(\[.*?\])');


                // Extract the JSON object substring
                String jsonSubstring = regExp.firstMatch(scriptText)?.group(1) ?? '';

                final jsonData = jsonDecode(jsonSubstring) as List<dynamic>;
                var grades = jsonData.map((e) => Map<String, dynamic>.from(e)).toList();

                scaleDetails[scaleId] = grades;

              } else {
                print('Failed to load HTML');
              }


            } catch (e) {
              print("Error for $name: $e");
            }
          });
          countriesData[id]['gradingScaleDetails'] = scaleDetails;

          file.writeAsStringSync(jsonEncode(countriesData));
        }
      }

    });
    currentCountry.value = "Done";

  }
}
