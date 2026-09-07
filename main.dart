import 'dart:convert';

import 'dart:io';



void main() {
  
  File jsonfile = File('data.json');
  String rawdata = jsonfile.readAsStringSync();

  List<dynamic> uncheckedData = jsonDecode(rawdata);
   
  List <dynamic> temperatures = [];
  for(int i =0; i< uncheckedData.length; i++){
    temperatures.add(uncheckedData[i]['temperature']);
  }
  temperatures.sort();
  print("These are the sorted temperatures: $temperatures");
}