import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:io';



void main() async {
  final dynamic url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Programming?type=single&amount=10',
  );
  final dynamic  response = await http.get(url);
  File jsonfile = File('jsonFile.json');
  jsonfile.writeAsStringSync(response.body);

  Map<String, dynamic> raws = jsonDecode(jsonfile.readAsStringSync());
  List<dynamic> temp = raws['jokes'];

  List<String> singularJokes = [
    for (final dynamic joke in temp) joke['joke'] as String,
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


}

(String,double) averagej(List<dynamic> list) {
  double average = 0;
  num sum = 0;
  String possible  = list[0];
  if (list.isEmpty) {
    throw ArgumentError('List is empty! Please correct and try again.');
  }
  for (int i = 0; i < list.length; i++) {
    sum += list[i].length;
  }
  average = (sum / list.length);
  for(int i = 0; i< list.length; i++){
    if((list[i].length - average).abs() < (possible.length - average).abs()){
      possible = list[i];
    }
    else if(list[i].length == average){
      possible = list[i];
    }
  }


  return (possible,average);
}

(String,num) highest(List<dynamic> list) {
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
  
  return (list[index],highestnum);
}

(String,num) lowest(List<dynamic> list) {
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
 
  return (list[index],lowestnum);
}
