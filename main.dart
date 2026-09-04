import 'dart:convert';
import 'dart:io';

void main(){
  File file = File('data.json');
  String rawdata = file.readAsStringSync();


  List<dynamic> stuff = jsonDecode(rawdata);
 
  print("The average temp is: ${averagetemp(stuff)}");
  print("The highest temp is: ${highest(stuff)}");
  print("The lowest temp is: ${lowest(stuff)}");
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


num highest(List<dynamic> l){
  num h = 0;
  int it = 0;
  if(l.isEmpty){
    throw ArgumentError('List is empty, no variables to look through');
  }
  for(int i =0; i< l.length; i++){
    if(l[i]['temperature'] > h){
      h = l[i]['temperature'];
    }
    it++;
  }

  print(it);


  return h;
}


num lowest(List<dynamic> l){
  int it = 0;
  if(l.isEmpty){
    throw ArgumentError('List is empty');
  }
  num lo = l[0]['temperature'];

  for(int i = 0; i< l.length; i++){
    if(lo > l[i]['temperature']){
      lo = l[i]['temperature'];
    }
    it++;
  }
print(it);
  return lo;
}