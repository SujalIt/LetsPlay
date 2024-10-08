import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:LetsPlay/APIS/LetsPlay.dart';
import 'package:http/http.dart' as http;
import 'package:LetsPlay/search_with_date_time.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class apiIntigration extends StatefulWidget {
  const apiIntigration({
    super.key,
  });

  @override
  State<apiIntigration> createState() => _apiIntigration();
}

class _apiIntigration extends State<apiIntigration> {
  String? searchDate;
  String? searchStart;
  String? searchEnd;

  DateTime? today = DateTime.now();
  List<LetsPlay> apiList = [];

  Future<List<LetsPlay>> fetchGrounds() async {
    var data;
    final response = await http.get(
        Uri.parse('https://gdttugfvfxuisjkroszc.supabase.co/rest/v1/vendor?'),
        headers: {
          "apikey":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI",
        });
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      for (Map i in data) {
        apiList.add(LetsPlay.fromJson(i));
      }
      return apiList;
    } else {
      return apiList;
    }
  }

  final user = Supabase.instance.client.auth.currentUser?.id;

  List<LetsPlay> manager_data = [];

  Future<List<LetsPlay>> fetchMyGrounds() async {
    var my_data;

    final my_res = await http.get(
      Uri.parse(
          'https://gdttugfvfxuisjkroszc.supabase.co/rest/v1/vendor?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI&created_by=eq.$user'),
    );

    if (my_res.statusCode == 200) {
      my_data = jsonDecode(my_res.body.toString());
      for (Map i in my_data) {
        manager_data.add(LetsPlay.fromJson(i));
      }
      return manager_data;
    } else {
      return manager_data;
    }
  }

  List<LetsPlay> result = [];

  final session = Supabase.instance.client.auth.currentSession;

  @override
  void initState() {
    loadgrounds();
    super.initState();
  }

  void loadgrounds() async {
    if (session != null) {
      result = await fetchMyGrounds();
    } else {
      result = await fetchGrounds();
    }
    setState(() {});
  }

  updatedlist(String keyword) {
    if (keyword.isEmpty) {
      result = apiList;
    } else {
      result = apiList
          .where((users) =>
              users.name!.toLowerCase().contains(keyword.toLowerCase()) ||
              users.addressLine1!
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              users.addressLine2!
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              users.city!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  bool isLoading = false;

  Future<List<Map<String, dynamic>>> getList() async {
    if (searchDate == null || searchStart == null || searchEnd == null) {
      // Fluttertoast.showToast(
      //   msg: 'Please enter details!',
      //   backgroundColor: const Color.fromARGB(255, 231, 82, 82),
      //   textColor: Colors.black,
      //   toastLength: Toast.LENGTH_LONG,
      // );
      // Error
    } else {
      setState(() {
        isLoading = true;
      });
      String newDay = DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(searchDate ?? DateTime.now().toString()));

      DateTime parsedTime = DateFormat('hh:mm a').parse(searchStart ?? "");
      String nn = DateFormat('HH:mm:ss').format(parsedTime);
      String finalStartTime = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse('$newDay $nn'));

      DateTime parsedEndtime = DateFormat('hh:mm a').parse(searchEnd ?? "");
      String aa = DateFormat('HH:mm:ss').format(parsedEndtime);
      String finalEndTime = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse('$newDay $aa'));

      try {
        final response = await Supabase.instance.client
            .rpc('get_available_vendors_v1', params: {
          '_start_date_time': finalStartTime,
          '_end_date_time': finalEndTime
        });
        setState(() {
          isLoading = false;
        });
        final exerciseList = response.map((e) => LetsPlay.fromJson(e)).toList();
        result.clear();
        result = exerciseList.cast<LetsPlay>();
        setState(() {});
        return [];
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  final ifSession = Supabase.instance.client.auth.currentSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            onChanged: (value) => updatedlist(value),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              hintText: "Search grounds",
              suffixIcon: const Icon(Icons.search_rounded),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        if (ifSession == null)
          SearchDatewithTime(
            valueDate: (date) {
              searchDate = date;
            },
            valueStart: (start) {
              searchStart = start;
            },
            valueEnd: (end) {
              searchEnd = end;
            },
          ),
        const SizedBox(
          height: 5,
        ),
        if (ifSession == null)
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    getList();
                  },
                  style: const ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 95, 251, 100))),
                  child: const Text(
                    "Search Box",
                    style: TextStyle(fontSize: 19, color: Colors.black),
                  ))),
        const SizedBox(
          height: 5,
        ),
        isLoading
            ? const CircularProgressIndicator()
            : result.isEmpty
                ? Column(
                    children: [
                      Image.network(
                        "https://cdn4.iconfinder.com/data/icons/sports-1-4/100/Sports-08-512.png",
                        width: 240,
                        height: 240,
                      ),
                      const Center(
                        child: Text(
                          "Grounds Not Found...",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: result[index].profilePic ?? "",
                                placeholder: (context, url) => const Center(
                                  heightFactor: 0.5,
                                  widthFactor: 0.5,
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                height: 126,
                                width: 137,
                                fit: BoxFit.fill,
                              ),
                              // Image.network(
                              //   result[index].profilePic ?? '',
                              //   height: 126,
                              //   width: 137,
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${result[index].name}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${result[index].addressLine1}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${result[index].city}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Price : ₹ ${result[index].pricing}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    SizedBox(
                                      height: 32,
                                      width: 170,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            context.go(
                                                '/informationScreen/id=${result[index].id}');
                                          },
                                          style: const ButtonStyle(
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  3)))),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 95, 251, 100),
                                              )),
                                          child: const Text(
                                            'Check availability',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
      ],
    );
  }
}
