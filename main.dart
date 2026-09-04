import 'dart:convert';
import 'dart:io';

const optimalMotorTemp = 25;
void main() {
  File file = File('data.json');
  String rawdata = file.readAsStringSync();

  List<dynamic> stuff = jsonDecode(rawdata);

  print("The average temp is: ${averagetemp(stuff)}");
  print("The highest temp is: ${highest(stuff)}");
  print("The lowest temp is: ${lowest(stuff)}");
  print("The motor worked on the optimal temp  ${mosteffective(stuff)} times.");
}

double averagetemp(List<dynamic> list) {
  double average = 0;
  num sum = 0;

  if (list.isEmpty) {
    throw ArgumentError('List is empty! Please correct and try again.');
  }
  for (int i = 0; i < list.length; i++) {
    sum += list[i]['temperature'];
  }
  average = (sum / list.length);

  return average;
}

num highest(List<dynamic> list) {
  num highestnum = 0;

  if (list.isEmpty) {
    throw ArgumentError('List is empty, no variables to look through');
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i]['temperature'] > highestnum) {
      highestnum = list[i]['temperature'];
    }
  }

  return highestnum;
}

num lowest(List<dynamic> list) {
  if (list.isEmpty) {
    throw ArgumentError('List is empty');
  }
  num lowestnum = list[0]['temperature'];

  for (int i = 0; i < list.length; i++) {
    if (lowestnum > list[i]['temperature']) {
      lowestnum = list[i]['temperature'];
    }
  }

  return lowestnum;
}

num mosteffective(List<dynamic> list) {
  num counter = 0;
  if (list.isEmpty) {
    throw ArgumentError('List is empty, no data to check');
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i]['temperature'] > optimalMotorTemp) {
      counter++;
    }
  }

  return counter;
}
