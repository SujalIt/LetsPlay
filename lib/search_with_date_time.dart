import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:letsplay/time_slot.dart';

class SearchDatewithTime extends StatefulWidget {
  const SearchDatewithTime({super.key});

  @override
  State<SearchDatewithTime> createState() => _SearchDatewithTimeState();
}

class _SearchDatewithTimeState extends State<SearchDatewithTime> {

  DateTime? today = DateTime.now();
  bool selectedDate = false;
  DateTime? currentDate ;

  date() async {
    DateTime? datepikeker = await showDatePicker(
        context: context,
        initialDate:today,
        firstDate: today!,
        lastDate: DateTime(2025)
        ).then((Value) {
          selectedDate = true;
          currentDate = Value;
          setState(() {
            
          });
        });
    return datepikeker;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(onPressed: () {},
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green,
                  width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
              ),
               child: Text(style: const TextStyle(fontSize: 11, color: Colors.black),
                "Today\n${DateFormat("dd-MMM").format(today!)}",
               textAlign: TextAlign.center,)),
            ),
            SizedBox(
                width: 105,
                height: 50,
                child: ElevatedButton(onPressed: () {},
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
                ),
                 child: Text(style: const TextStyle(fontSize: 11,color: Colors.black),
                  "Tomorrow\n${DateFormat("dd-MMM").format(today!.add(const Duration(days: 1)))}",
                 textAlign: TextAlign.center,)),
              ),
              SizedBox(
                width: 136,
                height: 50,
                child: ElevatedButton(onPressed: () {},
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     IconButton(onPressed: date,
                      icon: const Icon(Icons.calendar_month_outlined, color: Colors.black,),
                      ), 
                      selectedDate ? Text(style: const TextStyle(fontSize: 11,color: Colors.black),
                      "Other\n${DateFormat("dd-MMM").format(currentDate!).toString()}") : const Text(
                        style: TextStyle(fontSize: 11, color: Colors.black),
                      "Other\nDates")
                   ],
                 ),
                 )
              ),
          ],
        ),
        const SizedBox(height: 6,),
        const TimeSlot(),
        const SizedBox(height: 6,),
        SizedBox(
          width: 350,
          height: 50,
          child: ElevatedButton(
            onPressed: () {}, 
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 95, 251, 100))
            ),
            child: const Text("Search Box",
            style: TextStyle(
              fontSize: 19,
              color: Colors.black
            ),)))
      ],
    );
  }
}