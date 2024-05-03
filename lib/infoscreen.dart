import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'APIS/bookings.dart';
import 'datepiker.dart';
import 'package:http/http.dart'as http;


// ignore: must_be_immutable
class InformationScreen extends StatefulWidget {
  LetsPlay groundOfObject;

  InformationScreen({
    super.key,
    required this.groundOfObject,
  });


  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  List<Widget> images = [];
  var no = 0;
  List<Booking> timeList = [];
  List<Booking> bookings = [];

  Future<List<Booking>> getBookedSlots() async {
    final response = await http.get(
      Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/bookings?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&booking_date=eq.${DateTime.now()}'),
    );
    var data ;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      for (Map<String ,dynamic> i in data) {
        print('hello');
        bookings.add(Booking.fromJson(i));
      } return bookings;
    }else {
      return bookings;
    }
  }
  sloteBooking(DateTime now, DateTime end, int interwall) {
    DateTime currentTime = now;
    while (currentTime.isBefore(end)) {
      String formattedTime = DateFormat('HH:mm').format(currentTime);
      timeList.add(Booking(startDateTime: formattedTime));
      currentTime = currentTime.add(Duration(minutes: interwall));
    }
  }

  loadingBookedSlots(){
    for( Booking slot in timeList){
      for(Booking bookedSlot in bookings){
        String? bookedSlotTrim=bookedSlot.startDateTime?.trim();
        String? booked=bookedSlotTrim?.substring(0, bookedSlotTrim.length - 3);
        String? time=slot.startDateTime;
        if(time==booked){
            Booking().isBooked==true;
        }else {}
      }
    }
  }

  @override
  void initState() {
    loadingBookedSlots();
    getBookedSlots();
    super.initState();

     final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day); // Example start time
    final DateTime endTime =
    startTime.add(const Duration(days: 1)); // Example end time
    final int intervalMinutes = widget.groundOfObject.slotInternval?.toInt() ??
        0; // Example interval in minutes
    sloteBooking(startTime, endTime, intervalMinutes);
    for (var i in widget.groundOfObject.offerPics!.photos!) {
      images.add(Image.network(
        i,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 95, 251, 100),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 28,
          ),
        ),
        title: const Text(
          'LetsPlay',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 15,
          left: 15,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            widget.groundOfObject.offerPics?.photos?.first ??
                                '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7, top: 5),
                        child: Column(
                          children: [
                            Text(
                              widget.groundOfObject.name.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${widget.groundOfObject.name} ${widget.groundOfObject.addressLine1} ${widget.groundOfObject.addressLine2} ${widget.groundOfObject.city}",
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Share.share(
                                "${widget.groundOfObject.name} ${widget.groundOfObject.addressLine1} ${widget.groundOfObject.addressLine2} ${widget.groundOfObject.city}",
                              );
                            },
                            icon: const Icon(Icons.share)),
                        IconButton(
                          onPressed: () async {
                            canLaunchUrl(Uri.parse(
                                'tel:+91${widget.groundOfObject.phone}'));
                            if (await canLaunchUrl(Uri.parse(
                                'tel:+91${widget.groundOfObject.phone}'))) {
                              await launchUrl(Uri.parse(
                                  'tel:+91${widget.groundOfObject.phone}'));
                            } else {}
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "https://wa.me/91${widget.groundOfObject.phone}"));
                          },
                          child: SizedBox(
                              width: 22,
                              height: 22,
                              child: Image.asset(
                                'assets/whatsapp.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Slots Availability',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Datepiker(),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2.0),
                itemCount: timeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color:Booking().isBooked!?Colors.red:Colors.green,
                            width: 2,
                          ),
                        ),

                        child: Center(
                            child:Text(timeList[index].startDateTime.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ))),
                  );
                }),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Pricing and Offers',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  children: [
                    Stack(children: [
                      CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              autoPlayCurve: Curves.easeInOut,
                              autoPlayInterval: const Duration(seconds: 2),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  no = index;
                                });
                              }),
                          items: images),
                    ]),
                    AnimatedSmoothIndicator(
                      activeIndex: no,
                      count: images.length,
                      effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: Colors.green.shade300,
                          activeDotColor: Colors.green.shade800,
                          paintStyle: PaintingStyle.fill),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
