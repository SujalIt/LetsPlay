import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class information_Screen extends StatefulWidget {
  const information_Screen({super.key});

  @override
  State<information_Screen> createState() => _information_ScreenState();
}

class _information_ScreenState extends State<information_Screen> {
  List<Widget> images = [
    Image.network(
        "https://res.cloudinary.com/dwzmsvp7f/image/fetch/q_75,f_auto,w_1316/https://media.insider.in/image/upload/c_crop%2Cg_custom/v1632513596/olppsqyedxdb7uhq5yrs.jpg"),
    Image.network(
        'https://v3img.voot.com/kimg/kimg/536c156e50c34bf9b6fd8bd64e4b4780_1280X720.jpg'),
    Image.network(
        'http://1.bp.blogspot.com/-vSDShmvpuVU/VE9dE1NwQiI/AAAAAAAACAA/9SnMCdBKNCE/w1200-h630-p-k-no-nu/Team%2BAhmedabad%2BExpress%2Bof%2BBox%2BCricket%2BLeague%2BPhoto%2Band%2BWallpaper%2B(1).jpg')
  ];
  var no = 0;

  // var name= DateTime.now().add(Duration(days: 1));
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
final caller=Uri.parse('tel:+917043331929');
  final whatsapp=Uri.parse('https://wa.me/919510292323');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
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
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/p/AF1QipPsfa8Hfuulq9Q5xQjXz1DZLvFfxaP5zYkVVWTu=w1080-h608-p-no-v0',
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
                            'SK Sports',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vandematram Road Gota,Ahmedabad',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(whatsapp);
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
                                      canLaunchUrl(caller);
                                      if (await canLaunchUrl(caller)) {
                                      await launchUrl(caller);
                                      } else {}
                                    },
                                    icon: Icon(
                                      Icons.add_call,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);}, child: Text("Back"))
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.share))
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            height: 300,
                            aspectRatio: 2.0,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayInterval: Duration(seconds: 2),
                            onPageChanged: (index, reason) {
                              setState(() {
                                no = index;
                              });
                            }),
                        items: images),
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
            ),
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
                            onPressed: date, icon: Icon(Icons.calendar_today)),
                        hintText: DateFormat("dd-MM-yyyy").format(currentDate ?? DateTime.now() )
                           ,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
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
            SizedBox(
              height: 20,
            ),
            Text(
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
                      padding: EdgeInsets.all(10.0),
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
                            style: TextStyle(
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
