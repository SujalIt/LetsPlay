import 'dart:convert';
import 'package:http/http.dart'as http;
import '../APIS/LetsPlay.dart';

class ApiCallingFunction{
  static List<LetsPlay>apiList(String inputes){
    var data=jsonDecode(inputes) as List<dynamic>;
    List<LetsPlay>output=data.map((e) => LetsPlay.fromJson(e)).toList();
    return output;
  }
static Future<List<LetsPlay>> ground() async {
  // List<> vendor = [];
  final response = await http.get(
      Uri.parse('https://gdttugfvfxuisjkroszc.supabase.co/rest/v1/vendor?'),
      headers: {
        "apikey":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI"
      });
    
  // var dataNew;

  if (response.statusCode == 200) {
    // dataNew = jsonDecode(response.body.toString());
    // for (Map<String,dynamic> i in dataNew){
    //   // bookings.add(Booking.fromJson(i));
    // }
    return [];
  }else{
    return [];
  }
}
}
