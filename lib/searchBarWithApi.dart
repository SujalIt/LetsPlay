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

List<LetsPlay> ApiList = [];
// List<LetsPlay> SecondApiList = List.from(ApiList);

class _apiIntigration extends State<apiIntigration> {
  Future<List<LetsPlay>> ground() async {
    final response = await http.get(
        Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor'),
        headers: {
          "apikey":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU"
        });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        ApiList.add(LetsPlay.fromJson(i));
      }
      return ApiList;
    } else {
      return ApiList;
    }
  }

  List<LetsPlay> NewList = [];

  @override
  void initState() {
    NewList = ApiList;
    super.initState();
  }

  updatedlist(String keyword) {
    List<LetsPlay> _result = [];
    if (keyword.isEmpty) {
      _result = ApiList;
    } else {
      _result = ApiList.where((users) =>
          users.name!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.addressLine1!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.addressLine2!.toLowerCase().contains(keyword.toLowerCase()) ||
          users.city!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
      NewList = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 48,
              width: 260,
              child: TextField(
                  onChanged: (value) => updatedlist(value),
                  textAlignVertical: TextAlignVertical.bottom,
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
        FutureBuilder(
          future: ground(),
          builder: (context, AsyncSnapshot<List<LetsPlay>> snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading');
            } else {
              return NewList.length == 0
                  ? const Center(child: Text("Result not found"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: NewList.length,
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
                              NewList[index].profilePic ?? '',
                              fit: BoxFit.fill,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${NewList[index].name}",style: TextStyle(
                                    fontWeight: FontWeight.w700
                                ),),
                                Text(
                                  "${NewList[index].addressLine1},", style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${NewList[index].addressLine2},", style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${NewList[index].city}", style: TextStyle(fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                width: 152,
                                child: ElevatedButton(onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(
                                            builder: (context) =>
                                                information_Screen(
                                              num: NewList[index].phone,
                                              address1:
                                                  NewList[index].addressLine1,
                                              address2:
                                                  NewList[index].addressLine2,
                                              city: NewList[index].city,
                                              name: NewList[index].name,
                                              photo:
                                                  NewList[index].profilePic,
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
                      });
            }
          },
        ),
      ],
    );
  }
}
