import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'APIS/bookings.dart';
import 'datepiker.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class InformationScreen extends StatefulWidget {

  num? vendId;

  LetsPlay groundOfObject ;

  InformationScreen({
    super.key,
    // required this.vendId,
    required this.groundOfObject,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  TextEditingController notesControl = TextEditingController();

  List<Widget> images = [];
  List originalList = [];
  var no = 0;
  List<Booking> timeList = [];
  List<Booking> bookings = [];
  DateTime? today = DateTime.now();
  final user = Supabase.instance.client.auth.currentUser?.id;

  Future<List<Booking>> getBookedSlots() async {
    var next = DateFormat("yyyy-MM-dd").format(today!);
    final response = await http.get(
      Uri.parse(
          'https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/bookings?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&vendor_id=eq.${widget.groundOfObject.id}&booking_date=eq.$next'),
    );
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      bookings.clear();
      for (Map<String, dynamic> i in data) {
        bookings.add(Booking.fromJson(i));
      }
      return bookings;
    } else {
      return bookings;
    }
  }
  List<LetsPlay> vendorDataList = [];

  Future<List<LetsPlay>> vendorData() async{
    final vendorResponse = await http.get(
      Uri.parse(
          'https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&id=eq.4')
    );
    var vendorData ;
    if(vendorResponse.statusCode == 200){
      vendorData = jsonDecode(vendorResponse.body.toString());
      for (Map<String ,dynamic> j in vendorData){
        vendorDataList.add(LetsPlay.fromJson(j));
        print("response");
        print(vendorDataList[0].addressLine1);
      }
      return vendorDataList;
    }else {
      return vendorDataList;
    }
  }

  sloteBooking(DateTime now, DateTime end, int interwall) {
    DateTime currentTime = now;
    timeList.clear();
    while (currentTime.isBefore(end)) {
      String formattedTime = DateFormat('HH:mm').format(currentTime);
      timeList.add(Booking(startDateTime: formattedTime));
      String originalFormate = DateFormat.jm().format(currentTime);
      originalList.add(Booking(startDateTime: originalFormate));
      currentTime = currentTime.add(Duration(minutes: interwall));
    }
  }

  loadingBookedSlots() {
    for (int i = 0; i < timeList.length; i++) {
      timeList[i].isBooked = false;
      for (int j = 0; j < bookings.length; j++) {
        String? bookedSlotTrim = bookings[j].startDateTime;
        String stTime = DateFormat("HH:mm")
            .format(DateTime.parse(bookedSlotTrim!));
        String? time = timeList[i].startDateTime;
        if (time == stTime) {
          timeList[i].id = bookings[j].id;
          timeList[i].isBooked = true;
        }
      }
    }
    if (mounted) {
      setState(() {
        timeList;
        bookings;
      });
    }
  }

  gettingSlots() async {
    await vendorData();
    await getBookedSlots();
    loadingBookedSlots();
  }

  unbookSlot(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Are you sure you want to unbook this slot?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 90, 252, 95)
                          )
                        ),
                        child: const Text("CANCEL",
                        style: TextStyle(
                          color: Colors.black
                        ),)),
                  ),
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () async {
                          await Supabase.instance.client
                              .from("bookings")
                              .delete()
                              .match({"id": timeList[index].id!}).then((value) {
                            gettingSlots();
                            Navigator.pop(context);
                          });
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 90, 252, 95)
                          )
                        ),
                        child: const Text("YES",
                        style: TextStyle(
                          color: Colors.black
                        ),)),
                  ),
                ],
              )
            ],
          );
        });
  }

  bookSlot(int index) async {
    String newDay = DateFormat("yyyy-MM-dd").format(today ?? DateTime.now());
    String stTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse("$newDay ${timeList[index].startDateTime}:00"));
    DateTime afterAddSt = DateTime.parse(stTime).add(
        Duration(minutes: widget.groundOfObject.slotinternval?.toInt() ?? 0));
    await Supabase.instance.client
        .from('bookings')
        .insert([
          {
            "created_at":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(today ?? DateTime.now()),
            "vendor_id": widget.groundOfObject.id,
            "start_date_time": stTime,
            "end_date_time": DateFormat("yyyy-MM-dd HH:mm:ss").format(afterAddSt),
            "notes": notesControl.text.toString(),
            "booking_date":
                DateFormat("yyyy-MM-dd").format(today ?? DateTime.now())
          }
        ])
        .select()
        .then((value) {
          gettingSlots();
          notesControl.clear();
          Navigator.pop(context);
        });
  }

  Future<String> matchNotes(int index) async{
    String date = DateFormat("yyyy-MM-dd").format(today ?? DateTime.now());
    String matchStartTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.parse("$date ${timeList[index].startDateTime}:00"));
    final matchNotes = await Supabase.instance.client
    .from("bookings")
    .select('notes')
    .match({"start_date_time" : matchStartTime});
    String notes = matchNotes[0]['notes'];
    return notes;
    }
    
  @override
  void initState() {
    super.initState();
    gettingSlots();
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day); // Example start time
    final DateTime endTime =
        startTime.add(const Duration(days: 1)); // Example end time
    final int intervalMinutes = widget.groundOfObject.slotinternval?.toInt() ??
        0; // Example interval in minutes
    sloteBooking(startTime, endTime, intervalMinutes);
    loadingBookedSlots();

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
          child: Semantics(
            identifier: 'Back',
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 28,
            ),
          ),
        ),
        title: const Text(
          'LetsPlay',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Semantics(
              identifier: 'Share',
              child: IconButton(
              onPressed: () {
              Share.share(
              "${widget.groundOfObject.name} ${widget.groundOfObject.addressLine1} ${widget.groundOfObject.addressLine2} ${widget.groundOfObject.city}  \nContact No :${widget.groundOfObject.phone} \n${widget.groundOfObject.groundLocation}",
              );
            },
              icon: const Icon(Icons.share)),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 15,
          left: 18,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 120,
                        width: 120,
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
                              "${widget.groundOfObject.name} ${widget.groundOfObject.addressLine1} ${widget.groundOfObject.addressLine2} ${widget.groundOfObject.city}\nPrice : ₹ ${widget.groundOfObject.pricing}",
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
                        Semantics(
                          identifier: 'GoogleMap',
                          child: IconButton(
                              onPressed: () async {
                                var url = widget.groundOfObject.groundLocation.toString();
                                if (await canLaunch(url)) {
                                   await launch(url);
                                } else {
                                   throw 'Could not launch $url';
                                }
                              },
                              icon: const Icon(Icons.location_on)),
                        ),
                        Semantics(
                          identifier: 'Call',
                          child: IconButton(
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
                              child: Semantics(
                                identifier: 'Whatsapp',
                                child: Image.asset(
                                  'assets/whatsapp.png',
                                  fit: BoxFit.cover,
                                ),
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
                Datepiker(
                  dateCall: (date) {
                    today = date;
                    gettingSlots();
                  },
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 2.0),
                    itemCount: timeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (widget.groundOfObject.createdBy != null) {
                            if (user == widget.groundOfObject.createdBy) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: timeList[index].isBooked!
                                        ? const Text(
                                            "Please tap on UNBOOK to cancel slot!",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : const Text(
                                            "Please tap on BOOK to confirm slot!",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Date : ${DateFormat("yyyy-MM-dd").format(today!)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          "Time : ${timeList[index].startDateTime}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        timeList[index].isBooked!
                                            ? SizedBox(child: FutureBuilder<String>(
                                                future : matchNotes(index),
                                                builder : (context, AsyncSnapshot<String> snapshot){
                                                  if(snapshot.hasData){
                                                    return Text(snapshot.data.toString());
                                                  } else {
                                                    return const CircularProgressIndicator();
                                                  }
                                                }
                                              ))
                                            : TextField(
                                                controller: notesControl,
                                                maxLines: 3,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Write notes...",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide(width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 110,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 90, 252, 95)),
                                              ),
                                              child:  const Text('CANCEL',
                                              style: TextStyle(
                                                color: Colors.black
                                              ),),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 110,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (timeList[index].isBooked!) {
                                                  Navigator.pop(context);
                                                  unbookSlot(index);
                                                } else {
                                                  bookSlot(index);
                                                }
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor: WidgetStatePropertyAll(
                                                  Color.fromARGB(255, 90, 252, 95)
                                                )
                                              ),
                                              child: timeList[index].isBooked!
                                                  ? const Text("UNBOOK", 
                                                  style: TextStyle(color: Colors.black),)
                                                  : const Text("BOOK",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                  ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: timeList[index].isBooked!
                                ? const Color.fromARGB(255, 231, 85, 85)
                                : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: timeList[index].isBooked!
                                      ? const Color.fromARGB(255, 231, 85, 85)
                                      : Colors.green,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  originalList[index].startDateTime.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              )),
                        ),
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
                    const SizedBox(
                      height: 5,
                    ),
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
