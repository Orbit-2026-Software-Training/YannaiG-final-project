import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:io';

const optimalMotorTemp = 25; // not used in current code version
void main() async {
  final url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Programming?type=single&amount=10',
  );
  final response = await http.get(url);
  File jsonfile = File('jsonFile.json');
  jsonfile.writeAsStringSync(response.body);

  Map<String, dynamic> raws = jsonDecode(jsonfile.readAsStringSync());
  List<dynamic> temp = raws['jokes'];

  List<String> singularJokes = [
    for (final joke in temp) joke['joke'] as String,
  ];

  print(
    "The highest amount of letters in the given jokes is ${highest(singularJokes)} ",
  );
  print(
    "The lowest amount of leters in the given jokes is ${lowest(singularJokes)}",
  );
  print(
    "The average number of letters in all the jokes is ${averagej(singularJokes)}",
  );
  // File file = File('data.json');                       all made for older versions.
  //String rawdata = file.readAsStringSync();

  //List<dynamic> stuff = jsonDecode(rawdata);

  //print("The average temp is: ${averagej(stuff)}");
  //print("The highest temp is: ${highest(stuff)}");
  //print("The lowest temp is: ${lowest(stuff)}");
  //print("The motor worked on the optimal temp  ${mosteffective(stuff)} times.");
}

double averagej(List<dynamic> list) {
  double average = 0;
  num sum = 0;

  if (list.isEmpty) {
    throw ArgumentError('List is empty! Please correct and try again.');
  }
  for (int i = 0; i < list.length; i++) {
    sum += list[i].length;
  }
  average = (sum / list.length);

  return average;
}

num highest(List<dynamic> list) {
  num highestnum = 0;
  int index = 0;
  if (list.isEmpty) {
    throw ArgumentError('List is empty, no variables to look through');
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i].length > highestnum) {
      highestnum = list[i].length;
      index = i;
    }
  }
  print(list[index]);
  return highestnum;
}

num lowest(List<dynamic> list) {
  int index = 0;
  if (list.isEmpty) {
    throw ArgumentError('List is empty');
  }
  num lowestnum = list[0].length;

  for (int i = 0; i < list.length; i++) {
    if (lowestnum > list[i].length) {
      lowestnum = list[i].length;
      index = i;
    }
  }
  print(list[index]);
  return lowestnum;
}
/*
num mosteffective(List<dynamic> list) {
  num counter = 0;
  if (list.isEmpty) {
    throw ArgumentError('List is empty, no data to check');
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i]['temperature'].length > optimalMotorTemp) {
      counter++;
    }
  }

  return counter;
}
*/
