import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:http/http.dart' as http;
import 'package:letsplay/info_Screen.dart';


class apiIntigration extends StatefulWidget {
  const apiIntigration({
    super.key,
  });

  @override
  State<apiIntigration> createState() => _apiIntigration();
}


class _apiIntigration extends State<apiIntigration> {

  List<LetsPlay> ApiList = [];


  Future<List<LetsPlay>> ground() async {
    var data ;
    final response = await http.get(
        Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor'),
        headers: {
          "apikey":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU"
        });

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      for (Map i in data) {
        ApiList.add(LetsPlay.fromJson(i));
      }
      return ApiList;
    } else {
      return ApiList;
    }
  }

  List<LetsPlay> result = [];

  @override
  void initState() {
    loadgrounds();
    super.initState();
  }

  void loadgrounds() async {
    result = await ground();
    setState(() {
      
    });
  }

  updatedlist(String keyword) {
    if (keyword.isEmpty) {
      result = ApiList;
    } else {
      result = ApiList.where((users) =>
          users.name!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.addressLine1!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.addressLine2!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.city!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                  style: const TextStyle(height: 1),
                  onChanged: (value) => updatedlist(value),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    hintText: "Search grounds",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  )),
            ),
            const SizedBox(
              width: 3,
            ),
            const Icon(
              Icons.search,
              size: 39,
            ),
          ],
        ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 130,
                          child: Row(
                            children: [
                            Container(
                            height: 108,
                            width: 137,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                              result[index].profilePic ?? '',
                              fit: BoxFit.fill,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${result[index].name}",style: const TextStyle(
                                    fontWeight: FontWeight.w700
                                ),),
                                Text(
                                  "${result[index].addressLine1},", style: const TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${result[index].addressLine2},", style: const TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${result[index].city}", style: const TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                width: 152,
                                child: ElevatedButton(onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(
                                            builder: (context) =>
                                                information_Screen(
                                              num: result[index].phone,
                                              address1:
                                                  result[index].addressLine1,
                                              address2:
                                                  result[index].addressLine2,
                                              city: result[index].city,
                                              name: result[index].name,
                                              photo:
                                                  result[index].profilePic,
                                            ),
                                          )
                                  );
                                },
                                    style: const ButtonStyle(
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(3))
                                        )),
                                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 72, 255, 78))
                                    ),child: const Text('Check availability', style: TextStyle(
                                      color: Color.fromARGB(255, 44, 27, 27),
                                      fontSize: 13,
                                    ),)),
                              )
                              ],
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
