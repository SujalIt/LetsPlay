import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'infoscreen.dart';

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
    var data;
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
    setState(() {});
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
    setState(() {});
  }

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
                suffixIcon: Icon(Icons.search_rounded),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.green, width: 2)),
              )),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${result[index].name}",overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,
                                       fontSize: 15,color: Colors.black,
                                  ),),
                                  Text(
                                    "${result[index].addressLine1}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600
                                      ),
                                  ),
                                  Text(
                                    "${result[index].addressLine2}", style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600,
                                      ),
                                  ),
                                  Text(
                                    "${result[index].city}", style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w600,
                                      ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  width: 152,
                                  child: ElevatedButton(onPressed: (){
                                    Navigator.push(context,
                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  information_Screen(
                                                  photos_slider: result[index].offerPics,
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
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)))),
                                      backgroundColor:
                                          MaterialStatePropertyAll(Color.fromARGB(255, 95, 251, 100),)),
                                  child: const Text(
                                    'Check availability',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600
                                    ),
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
