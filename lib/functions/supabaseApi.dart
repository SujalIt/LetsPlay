import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../APIS/LetsPlay.dart';
import 'package:http/http.dart'as http;

class ApiCallingFunction{
  static List<LetsPlay>apiList(String inputes){
    var data=jsonDecode(inputes) as List<dynamic>;
    List<LetsPlay>output=data.map((e) => LetsPlay.fromJson(e)).toList();
    return output;
  }
static Future<List<LetsPlay>> ground() async {
  final response = await http.get(
      Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor'),
      headers: {
        "apikey":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU"
      });

  if (response.statusCode == 200) {
    return compute(apiList, response.body);
  }else{
    throw Exception('Error');
  }
}
}
