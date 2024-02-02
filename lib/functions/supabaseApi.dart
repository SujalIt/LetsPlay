import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../APIS/LetsPlay.dart';
import 'package:http/http.dart'as http;
List<LetsPlay> ApiList = [];


Future<List<LetsPlay>> ground() async {
  var data ;
  final response = await http.get(
      Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor'),
      headers: {
        "apikey":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU"
      });

  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
    for (Map i in data) {
      ApiList.add(LetsPlay.fromJson(i));
    }
    return ApiList;
  } else {
    return ApiList;
  }
}
Stream ground2(){
  final data=Supabase.instance.client.from('vendor').stream(primaryKey: ['id']);
  return data;
}