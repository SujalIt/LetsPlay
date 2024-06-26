import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:letsplay/infoModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'datepiker.dart';

// ignore: must_be_immutable
class InformationScreen extends StatefulWidget {
  num? vendId;

  InformationScreen({
    super.key,
    required this.vendId,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {

  Slots object = Slots();
  
  TextEditingController notesControl = TextEditingController();
  List<Widget> images = [];
  var no = 0;
  DateTime? today = DateTime.now();
  final user = Supabase.instance.client.auth.currentUser?.id;
  bool isLoading = false;

  gettingSlots() async {
    setState(() {
      isLoading = true;
    });
    await object.vendorData(widget.vendId);
    setState(() {
      isLoading = false;
    });
    await object.getBookedSlots();
    object.loadingBookedSlots();
    if(mounted){
      setState(() {
        object.time24List;
        object.bookings;
      });
    }
  }
  finalData() async {
    await gettingSlots();
    object.slots();
    object.loadingBookedSlots();

    for (var i in object.groundOfObject!.offerPics!.photos!) {
      images.add(Image.network(
        i,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    finalData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 95, 251, 100),
        leading: Semantics(
          identifier: 'Back',
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
              onPressed: () {
                context.go('/');
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 28,
              ),
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
                      "https://letsplaycricket-a007a.web.app/#/informationScreen/id=${widget.vendId}");
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
            child: isLoading
                ? const Center(
                    heightFactor: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 95, 251, 100),
                      ),
                    ))
                : object.groundOfObject == null
                    ? const Center(
                        heightFactor: 20,
                        child: Text(
                          "Data Not Found!",
                          style: TextStyle(fontSize: 25),
                        ))
                    : Column(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.network(
                                      object.groundOfObject
                                              ?.offerPics?.photos?.first ??
                                          '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, top: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        object.groundOfObject!.name.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${object.groundOfObject!.name} ${object.groundOfObject!.addressLine1} ${object.groundOfObject!.addressLine2} ${object.groundOfObject!.city}\nPrice : ₹ ${object.groundOfObject!.pricing}",
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Semantics(
                                    identifier: 'GoogleMap',
                                    child: IconButton(
                                        onPressed: () async {
                                          var url = object.groundOfObject!
                                              .groundLocation
                                              .toString();
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
                                        canLaunchUrl(Uri.parse('tel:+91${object.groundOfObject!.phone}'));
                                        if (await canLaunchUrl(Uri.parse('tel:+91${object.groundOfObject!.phone}'))) {
                                          await launchUrl(Uri.parse('tel:+91${object.groundOfObject!.phone}'));
                                        }
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
                                      launchUrl(Uri.parse("https://wa.me/91${object.groundOfObject!.phone}"));
                                    },
                                    child: SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: Semantics(
                                          identifier: 'Whatsapp',
                                          child: Image.asset('assets/whatsapp.png',
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
                              itemCount: object.time24List.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (object.groundOfObject!.createdBy != null) {
                                      if (user == object.groundOfObject!.createdBy) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: object.time24List[index].isBooked!
                                                  ? const Text(
                                                      "Please tap on UNBOOK to cancel slot!",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  : const Text(
                                                      "Please tap on BOOK to confirm slot!",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        fontWeight:FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    "Time : ${object.time24List[index].startDateTime}",
                                                    style: const TextStyle(
                                                        fontWeight:FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  object.time24List[index].isBooked!
                                                      ? SizedBox(
                                                          child: FutureBuilder<String>(
                                                              future:object.matchNotes(index),
                                                              builder: (context,
                                                                  AsyncSnapshot<String>snapshot) {
                                                                if (snapshot.hasData) {
                                                                  return Text(snapshot.data.toString());
                                                                }else{
                                                                return const Text("Notesnotfound");
                                                                }
                                                                // else {
                                                                //   return
                                                                //       // const Text("Notes not found!");
                                                                //       const CircularProgressIndicator();
                                                                // }
                                                              }))
                                                      : TextField(
                                                          controller:notesControl,
                                                          maxLines: 3,
                                                          decoration:const InputDecoration(
                                                            hintText:"Write notes...",
                                                            enabledBorder:OutlineInputBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            ),
                                                            focusedBorder:OutlineInputBorder(
                                                              borderSide:BorderSide(width: 1),
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      width: 110,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // print(timeList[index].toJson());
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          90,
                                                                          252,
                                                                          95)),
                                                        ),
                                                        child: const Text(
                                                          'CANCEL',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 111,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (object.time24List[index].isBooked!) {
                                                            Navigator.pop(context);
                                                            // ...
                                                            showDialog(
                                                                context:context,
                                                                builder:(BuildContext context) {
                                                                  return AlertDialog(
                                                                      title:const Text(
                                                                        "Are you sure you want to unbook this slot",
                                                                        style: TextStyle(
                                                                            fontSize:18,
                                                                            fontWeight:FontWeight.bold),
                                                                      ),
                                                                      actions: [
                                                                        Row(
                                                                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 40,
                                                                                width: 110,
                                                                                child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 90, 252, 95))),
                                                                                    child: const Text(
                                                                                      "CANCEL",
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    )),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 40,
                                                                                width: 110,
                                                                                child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    object.unbookSlot(index);
                                                                                    gettingSlots();
                                                                                    Navigator.pop(context);// new class
                                                                                  },
                                                                                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 90, 252, 95))),
                                                                                  child: const Text(
                                                                                      "YES",
                                                                                      style: TextStyle(color: Colors.black),
                                                                                  )),
                                                                              ),
                                                                            ])
                                                                      ]);
                                                                });
                                                            // unbookSlot(index);
                                                          } else {
                                                            object.bookSlot(index,notesControl.text.toString());
                                                            gettingSlots();
                                                            notesControl.clear();
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        style: const ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStatePropertyAll(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        90,
                                                                        252,
                                                                        95))),
                                                        child: object.time24List[index]
                                                                .isBooked!
                                                            ? const Text(
                                                                "UNBOOK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            : const Text(
                                                                "BOOK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
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
                                          color: object.time24List[index].isBooked!
                                              ? const Color.fromARGB(
                                                  255, 231, 85, 85)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: object.time24List[index].isBooked!
                                                ? const Color.fromARGB(
                                                    255, 231, 85, 85)
                                                : Colors.green,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            object.viewList[index]
                                                .startDateTime
                                                .toString(),
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
                                        autoPlayInterval:
                                            const Duration(seconds: 2),
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
