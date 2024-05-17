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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 99,
              height: 50,
              child: ElevatedButton(onPressed: () {},
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
              ),
               child: Text("Today\n${DateFormat("dd-MMM").format(today!)}",
               textAlign: TextAlign.center,)),
            ),
            SizedBox(
                width: 113,
                height: 50,
                child: ElevatedButton(onPressed: () {},
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
                ),
                 child: Text("Tomorrow\n${DateFormat("dd-MMM").format(today!.add(const Duration(days: 1)))}",
                 textAlign: TextAlign.center,)),
              ),
              SizedBox(
                width: 144,
                height: 50,
                child: ElevatedButton(onPressed: () {},
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
                ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     IconButton(onPressed: date,
                      icon: const Icon(Icons.calendar_month_outlined),
                      ), 
                      selectedDate ? Text("Other\n${DateFormat("dd-MMM").format(currentDate!).toString()}") : const Text("Other\nDates")
                   ],
                 ),
                 )
              ),
          ],
        ),
        // TimeSlot(),
        SizedBox(
          width: 365,
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
              fontSize: 24,
              color: Colors.black
            ),)))
      ],
    );
  }
}