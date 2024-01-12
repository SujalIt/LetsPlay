import 'package:intl/intl.dart';

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

  date() async {
    DateTime? datepikeker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    return datepikeker;
  }

  TextEditingController datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 3),
                  ),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/p/AF1QipPsfa8Hfuulq9Q5xQjXz1DZLvFfxaP5zYkVVWTu=w1080-h608-p-no-v0',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                'Vandrematram Road Gota,Ahmedabad',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: Image.asset(
                                        'assets/whatsapp (1).png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_call,
                                      color: Colors.blue,
                                    ),
                                  )
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
                        dotHeight: 15,
                        dotWidth: 15,
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
                  child: TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: date, icon: Icon(Icons.calendar_today)),
                      hintText:
                          '${DateFormat("dd-MM-yyyy").format(DateTime.now())}',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 3),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide:
                              BorderSide(color: Colors.green, width: 3)),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
