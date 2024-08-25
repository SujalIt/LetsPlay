import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:http/http.dart' as http;
import 'package:letsplay/APIS/bookings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Slots {
  LetsPlay? groundOfObject;

  Future<List<LetsPlay>> vendorData(num? vendorid) async {
    List<LetsPlay> vendorDataList = [];
    final vendorResponse = await http.get(
      Uri.parse('https://gdttugfvfxuisjkroszc.supabase.co/rest/v1/vendor?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI&id=eq.$vendorid'),
      // Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&id=eq.$vendorid'),
    );
    var vendorData;
    if (vendorResponse.statusCode == 200) {
      vendorData = jsonDecode(vendorResponse.body.toString());
      for (Map<String, dynamic> j in vendorData) {
        vendorDataList.add(LetsPlay.fromJson(j));
      }
      groundOfObject = vendorDataList[0];
      return [];
    } else {
      return [];
    }
  }

  List<Booking> bookings = [];
  DateTime today = DateTime.now();

  Future<List<Booking>> getBookedSlots() async {
    var next = DateFormat("yyyy-MM-dd").format(today);
    final response = await http.get(
      Uri.parse('https://gdttugfvfxuisjkroszc.supabase.co/rest/v1/bookings?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI&vendor_id=eq.${groundOfObject?.id}&booking_date=eq.$next'),
      // Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/bookings?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&vendor_id=eq.${groundOfObject?.id}&booking_date=eq.$next'),
      );
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in data) {
        bookings.add(Booking.fromJson(i));
      }
      return bookings;
    } else {
      return bookings;
    }
  }

  List<Booking> time24List = [];

  slotsAndLoadBookedSlots() {
    slotsGenerate();
    loadingBookedSlots();
  }

  slotsGenerate() {
    DateTime startTime = DateTime(today.year, today.month, today.day);
    DateTime endTime = startTime.add(const Duration(days: 1));
    int intervalMinutes = groundOfObject!.slotinternval?.toInt() ?? 0;
    time24List.clear();
    while (startTime.isBefore(endTime)) {
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime);
      time24List.add(Booking(startDateTime: formattedDateTime));
      startTime = startTime.add(Duration(minutes: intervalMinutes));
    }
  }


  loadingBookedSlots() {
    for (int i = 0; i < time24List.length; i++) {
      time24List[i].isBooked = false;
      for (int j = 0; j < bookings.length; j++) {
        String? bookedTime = bookings[j].startDateTime;
        String bookedTimeTrim = DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.parse(bookedTime ?? ""));
        String? time = time24List[i].startDateTime;
        if (time == bookedTimeTrim) {
          time24List[i].id = bookings[j].id;
          time24List[i].notes = bookings[j].notes;
          time24List[i].isBooked = true;
        }
      }
    }
  }

  bookSlot(int index, String notesControl) async {
    String stTime = time24List[index].startDateTime ?? "";
    DateTime afterAddSt = DateTime.parse(stTime)
        .add(Duration(minutes: groundOfObject!.slotinternval?.toInt() ?? 0));
    await Supabase.instance.client
        .from('bookings')
        .insert([
          {
            "created_at": DateFormat("yyyy-MM-dd HH:mm:ss").format(today),
            "vendor_id": groundOfObject!.id,
            "start_date_time": stTime,
            "end_date_time":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(afterAddSt),
            "notes": notesControl,
            "booking_date": DateFormat("yyyy-MM-dd").format(today)
          }
        ])
        .select()
        .then((value) {
          // gettingSlots();
          // notesControl.clear();
          // Navigator.pop(context);
        });
  }

  unbookSlot(int index) async {
    await Supabase.instance.client
        .from("bookings")
        .delete()
        .match({"id": time24List[index].id!}).then((value) {
      // gettingSlots();
      // Navigator.pop(context);
    });
  }
}