import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'infoscreen.dart';

class apiIntigration extends StatefulWidget {
  const apiIntigration({
    super.key,
  });

  @override
  State<apiIntigration> createState() => _apiIntigration();
}

class _apiIntigration extends State<apiIntigration> {
  List<LetsPlay> apiList = [];

  Future<List<LetsPlay>> fetchGrounds() async {
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
      Uri.parse('https://gmoflxgrysuxaygnjemp.supabase.co/rest/v1/vendor?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU&created_by=eq.$user'),
    );

    if (my_res.statusCode == 200) {
      my_data = jsonDecode(my_res.body.toString());
      for (Map i in my_data) {
         manager_data.add(LetsPlay.fromJson(i));
    } return manager_data;
    }else {
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
    if (session != null){
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
      result = apiList.where((users) =>
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
        if (result.isEmpty)
          Column(
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
          ),
        if (result.isNotEmpty)
          ListView.builder(
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
                        child: Image.network(
                          result[index].profilePic ?? '',
                          height: 126,
                          width: 137,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8,),
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
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${result[index].addressLine2}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${result[index].city}",
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InformationScreen(
                                                    groundOfObject:
                                                        result[index]),
                                          ));
                                    },
                                    style: const ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Color.fromARGB(255, 95, 251, 100),
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
