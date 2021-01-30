import 'dart:convert';

Map<String,dynamic> getJSONMap(body){
  Map<String,dynamic> map =jsonDecode(body);
  return map;
}