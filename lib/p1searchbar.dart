import 'package:flutter/material.dart';
import 'package:letsplay/model_grounds.dart';
class p1searchbar extends StatefulWidget {
  const p1searchbar({super.key,});

  @override
  State<p1searchbar> createState() => _p1searchbarState();
}

class _p1searchbarState extends State<p1searchbar> {

  static List<groundnames> main_list = [
    groundnames("MK Sports", "Gota road,\nAhmedabad"),
    groundnames("SK Sports", "Jagatpur road,\nAhmedabad"),
    groundnames("DK Sports", "Vandemataram road,\nAhmedabad"),
    groundnames("CK Sports", "Science city road,\nAhmedabad"),
    groundnames("RK Sports", "SG highway,\nAhmedabad"),
    groundnames("TK Sports", "Thaltej road,\nAhmedabad"),
  ];


  List<groundnames> display_list = List.from(main_list);

  void updatelist(String name){
    setState(() {
      display_list = main_list.where((element){
        return (element.name!.toLowerCase().contains(name.toLowerCase()) || element.address!.toLowerCase().contains(name.toLowerCase()));
        }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 48,
                width: 290,
                child: TextField(
                  onChanged: (name) => updatelist(name),
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                    hintText: "Search grounds",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  )
                ),
              ),
              const SizedBox(width: 3,),
              const Icon(Icons.search,size: 39,),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: display_list.length == 0 ? const Center(
              child: Text("Result not found")):
            
            ListView.builder(
                  itemCount: display_list.length,
                  itemBuilder: (context, index){
                    return SizedBox(
          height: 130,
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 108,
              width: 147,
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(4),
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ14kWhEzjxa7WMypn5ykydcGG_O_Nbrc6U1QNfd95zb2YAGjN_H2FuDqtqQUGFJ6Bgll0&usqp=CAU", fit: BoxFit.cover,)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    "${display_list[index].name}", style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                   Text(
                    '${display_list[index].address}', style: TextStyle(fontSize: 13,
                    fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                      height: 18,
                      ),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, "i");
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
          )
        ],
      ),
    );
  }
}