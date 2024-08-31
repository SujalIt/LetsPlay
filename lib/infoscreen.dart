import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:LetsPlay/infoModel.dart';
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
  Slots infoObject = Slots();

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
    await infoObject.vendorData(widget.vendId);
    setState(() {
      isLoading = false;
    });
    await infoObject.getBookedSlots();
    if (mounted) {
      setState(() {});
    }
    infoObject.slotsAndLoadBookedSlots();
  }

  finalData() async {
    await gettingSlots();

    // for (var i in infoObject.groundOfObject!.offerPics!.photos!) {
    for (var i in infoObject.groundOfObject?.offerPics?.photos ?? [""]) {
      images.add(
          // Image.network(i,
          // width: double.infinity,
          // fit: BoxFit.fitWidth,
          // )
          CachedNetworkImage(
        imageUrl: i,
        placeholder: (context, url) => const Center(
            heightFactor: 0.5,
            widthFactor: 0.5,
            child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ));
    }
  }

  DateTime? hello;

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
                : infoObject.groundOfObject == null
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
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child:
                                          // Image.network(
                                          //   infoObject.groundOfObject?.offerPics?.photos?.first ?? '',
                                          //   fit: BoxFit.cover,
                                          // ),
                                          CachedNetworkImage(
                                        imageUrl: infoObject.groundOfObject
                                                ?.offerPics?.photos?.first ??
                                            '',
                                        placeholder: (context, url) =>
                                            const Center(
                                                heightFactor: 0.5,
                                                widthFactor: 0.5,
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, top: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        infoObject.groundOfObject!.name
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${infoObject.groundOfObject!.name} ${infoObject.groundOfObject!.addressLine1} ${infoObject.groundOfObject!.addressLine2} ${infoObject.groundOfObject!.city}\nPrice : ₹ ${infoObject.groundOfObject!.pricing}",
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
                                          var url = infoObject
                                              .groundOfObject!.groundLocation
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
                                        canLaunchUrl(Uri.parse(
                                            'tel:+91${infoObject.groundOfObject!.phone}'));
                                        if (await canLaunchUrl(Uri.parse(
                                            'tel:+91${infoObject.groundOfObject!.phone}'))) {
                                          await launchUrl(Uri.parse(
                                              'tel:+91${infoObject.groundOfObject!.phone}'));
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
                                      launchUrl(Uri.parse(
                                          "https://wa.me/91${infoObject.groundOfObject!.phone}"));
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
                              itemCount: infoObject.time24List.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (infoObject.groundOfObject!.createdBy !=
                                        null) {
                                      if (user ==
                                          infoObject
                                              .groundOfObject!.createdBy) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: infoObject
                                                      .time24List[index]
                                                      .isBooked!
                                                  ? const Text(
                                                      "Please tap on UNBOOK to cancel slot!",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    "Time : ${DateFormat('hh:mm a').format(DateTime.parse(infoObject.time24List[index].startDateTime ?? ""))}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  infoObject.time24List[index]
                                                          .isBooked!
                                                      ? infoObject
                                                                  .time24List[
                                                                      index]
                                                                  .notes ==
                                                              ""
                                                          ? const Text(
                                                              "Notes not found!",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          : Text(
                                                              infoObject
                                                                  .time24List[
                                                                      index]
                                                                  .notes
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                      : TextField(
                                                          controller:
                                                              notesControl,
                                                          maxLines: 3,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                "Write notes...",
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      width: 1),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      width: 110,
                                                      child: ElevatedButton(
                                                        onPressed: () {
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
                                                          if (infoObject
                                                              .time24List[index]
                                                              .isBooked!) {
                                                            Navigator.pop(
                                                                context);
                                                            // ...
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                      title:
                                                                          const Text(
                                                                        "Are you sure you want to unbook this slot",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      actions: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
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
                                                                                      infoObject.unbookSlot(index);
                                                                                      gettingSlots();
                                                                                      Navigator.pop(context);
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
                                                          } else {
                                                            infoObject.bookSlot(
                                                                index,
                                                                notesControl
                                                                    .text
                                                                    .toString());
                                                            gettingSlots();
                                                            notesControl
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
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
                                                        child: infoObject
                                                                .time24List[
                                                                    index]
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
                                          color: infoObject
                                                  .time24List[index].isBooked!
                                              ? const Color.fromARGB(
                                                  255, 231, 85, 85)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            style: BorderStyle.solid,
                                            color: infoObject
                                                    .time24List[index].isBooked!
                                                ? const Color.fromARGB(
                                                    255, 231, 85, 85)
                                                : Colors.green,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            DateFormat('hh:mm a').format(
                                                DateTime.parse(infoObject
                                                        .time24List[index]
                                                        .startDateTime ??
                                                    "")),
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
                                height: 20,
                              ),
                              Container(
                                width: 10,
                                child: AnimatedSmoothIndicator(
                                    activeIndex: no,
                                    count: images.length,
                                    effect: WormEffect(
                                      dotHeight: 9,
                                      dotWidth: 9,
                                      dotColor: Colors.green.shade300,
                                      activeDotColor: Colors.green.shade800,
                                      paintStyle: PaintingStyle.fill,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              )
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
