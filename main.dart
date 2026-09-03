import 'dart:convert';
import 'dart:io';

void main(){
  File file = File('data.json');
  String rawdata = file.readAsStringSync();


  List<dynamic> stuff = jsonDecode(rawdata);
  print(stuff[0]['time']);
  print(stuff[0]['temperature']);
  print(averagetemp(stuff));
}

double averagetemp(List<dynamic> l){
  double av = 0;
  num sum = 0;
  int it =0;
  if(l.isEmpty){
    throw ArgumentError('List is empty! Please correct and try again.');
  }
  for(int i = 0; i < l.length; i++){
    sum += l[i]['temperature'];
    it++;
  }
  av = (sum / l.length);
  print(it);


return av;
}