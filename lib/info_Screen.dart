import 'package:intl/intl.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class information_Screen extends StatefulWidget {
  var name;
  var address1;
  var address2;
  var city;
  var num;
  var photo;
  OfferPics? photos_slider;

   information_Screen({super.key,required this.photos_slider,required this.name,required this.address1,required this.address2,required this.city,required this.num,required this.photo});
   @override

  State<information_Screen> createState() => _information_ScreenState();
}

class _information_ScreenState extends State<information_Screen> {
  List<Widget> images = [];

  var no = 0;
  date() async {
    DateTime? datepikeker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)).then((value) {
          receivedDate=value.toString();
          currentDate = value;
          setState(() {

          });
    });
    return datepikeker;
  }


  TextEditingController datecontroller = TextEditingController();
  List<String> Timing = [
    "7-8 AM",
    "8-9 AM",
    "9-10 AM",
    "10-11 AM",
    "11-12 AM",
    "5-6 PM",
    "6-7 PM",
    "7-8 PM",
    "8-9 PM",
    "9-10 PM",
    "10-11 PM",
    "11-12 PM",
  ];

  DateTime? currentDate;
   String? receivedDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    for (var i in widget.photos_slider!.photos!){
      images.add(Image.network(
        i,width:double.infinity,fit: BoxFit.fitWidth,));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(
            255, 40, 252, 7),
        leading: GestureDetector(onTap: () {
          Navigator.pop(context);
        },
          child: const CircleAvatar(backgroundColor:Color.fromARGB(
              255, 40, 252, 7) ,child:
          Icon(
            Icons.arrow_back,
            color: Colors.redAccent,
            size: 28,
          )
          ),
        ),
        title: const Text('LetsPlay',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 30,
          left: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                      borderRadius:const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(widget.photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.address1},${widget.address2},${widget.city}"
                                ,
                                style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse("https://wa.me/91${widget.num}"));
                                    },
                                    child: SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: Image.asset(
                                          'assets/whatsapp.png',
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  IconButton(
                                    onPressed: ()async {
                                      canLaunchUrl(Uri.parse('tel:+91${widget.num}'));
                                      if (await canLaunchUrl(Uri.parse('tel:+91${widget.num}'))) {
                                      await launchUrl(Uri.parse('tel:+91${widget.num}'));
                                      } else {}
                                    },
                                    icon: const Icon(
                                      Icons.add_call,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                IconButton(onPressed: () {
                  Share.share('sujal');
                }, icon: const Icon(Icons.share))
              ],
            ),
            const Text(
              'Pricing and Offers',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Stack(
                    children:[ CarouselSlider(
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
                                     ] ),
                  const SizedBox(height: 10,),
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
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 42,
                    child: TextField(
                      onTap: date,
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.none,
                      controller: datecontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: date, icon: const Icon(Icons.calendar_today)),
                        hintText: DateFormat("dd-MM-yyyy").format(currentDate ?? DateTime.now() )
                           ,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.greenAccent, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.green, width: 2)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        //2024-01-12 14:45:20.265410
                        DateTime? days = currentDate;
                        receivedDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSSS")
                            .format(days!.add(const Duration(days: 1)));
                        currentDate = DateTime.parse(receivedDate.toString());
                        setState(() {
                        });
                      },
                      style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      child: const Text(
                        'Next Day',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Slots Availability',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2.0),
                  itemCount: Timing.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.green,
                              width: 3,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            Timing[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ))),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
