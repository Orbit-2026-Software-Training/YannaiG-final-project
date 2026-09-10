import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:csv/csv.dart';

File csvfile = File('logs.csv');
List<List<dynamic>> logs = [
  ['Timestamp', 'Stage', 'Message'],
];
void main() {
  getHttp();
  List<dynamic> testData = getDataFromJsonFile();
  List<dynamic> jokesData = getJokesFromJson();
  num firstmaximum = getMax(testData);
  num firstminimum = getMin(testData);
  num firstaverage = getAverage(testData);
  num secmaximum = getMax(jokesData);
  num secminimum = getMin(jokesData);
  num secaverage = getAverage(jokesData);
  List<num> percentages = [
    getPercent(firstaverage, firstminimum),
    getPercent(firstaverage, firstmaximum),
    getPercent(secaverage, secminimum),
    getPercent(secaverage, secmaximum),
  ];
  num maxvalue = percentages[0];
  List<String> names = [
    "minium from original file",
    "maximum from original file",
    "minimum from joke file",
    "maximum from joke file",
  ];
  String maxAnchor = "";
  for (int i = 0; i < percentages.length; i++) {
    if (maxvalue < percentages[i]) {
      maxvalue = percentages[i];
      maxAnchor = names[i];
    }
  }
  print(
    "The maximum percentage is: $maxvalue and it comes from the $maxAnchor",
  );
  csvfile.writeAsStringSync(csv.encode(logs));
  
}

void getHttp() async {
  final dynamic url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Programming?type=single&amount=10',
  );
  logs.add([
  DateTime.now().toIso8601String(),
  'Http request',
  'Calling API through HTTP',
  ]);
  final dynamic response = await http.get(url);
  File jsonfile = File('jsonFile.json');
  jsonfile.writeAsStringSync(response.body);

}

List<dynamic> getJokesFromJson() {
  File file = File('jsonFile.json');
  Map<String, dynamic> raws = jsonDecode(file.readAsStringSync());
  List<dynamic> temp = raws['jokes'];
  List<String> singularJokes = [
    for (final dynamic joke in temp) joke['joke'] as String,
  ];
  List<dynamic> jokevalues = [];
  for (int i = 0; i < singularJokes.length; i++) {
    jokevalues.add(singularJokes[i].length);
  }
  logs.add([
    DateTime.now().toIso8601String(),
    'Json Loading',
    'Loading Joke Json file',
  ]);
  
  return jokevalues;
}
List<dynamic> getDataFromJsonFile() {
  File jsonfile = File('data.json');
  List<dynamic> uncheckedData = jsonDecode(jsonfile.readAsStringSync());
  List<dynamic> temperatures = [];
  for (int i = 0; i < uncheckedData.length; i++) {
    temperatures.add(uncheckedData[i]['temperature']);
  }
  logs.add([
    DateTime.now().toIso8601String(),
    'Json Loading',
    'Loading Temperatures Json file',
  ]);

  return temperatures;
}

num getMax(List<dynamic> list) {
  num Max = list[0];
  for (int i = 0; i < list.length; i++) {
    if (list[i] > Max) {
      Max = list[i];
    }
  }

  return Max;
}

num getMin(List<dynamic> list) {
  num Min = list[0];
  for (int i = 0; i < list.length; i++) {
    if (list[i] < Min) {
      Min = list[i];
    }
  }
  return Min;
}

num getAverage(List<dynamic> list) {
  num average = list[0];
  num sum = 0;
  for (int i = 0; i < list.length; i++) {
    sum += list[i];
  }
  average = sum / list.length;

  return average;
}

num getPercent(num average, num extremeNumber) {
  num percent = ((extremeNumber - average).abs() / average) * 100;
  logs.add([
    DateTime.now().toIso8601String(),
    'Calculating',
    'Calculating average percentage value',
  ]);

  return percent;
}
