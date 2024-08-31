import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:LetsPlay/time_slot.dart';

// ignore: must_be_immutable
class SearchDatewithTime extends StatefulWidget {
  Function(String?)? valueDate;
  Function(String?)? valueStart;
  Function(String?)? valueEnd;

  SearchDatewithTime(
      {super.key, this.valueDate, this.valueStart, this.valueEnd});

  @override
  State<SearchDatewithTime> createState() => _SearchDatewithTimeState();
}

class _SearchDatewithTimeState extends State<SearchDatewithTime> {
  DateTime today = DateTime.now();
  bool selectedDate = false;
  DateTime? currentDate;

  String? storeDate;
  String? tomorrow;

  String? startTime;
  String? endTime;

  date() async {
    DateTime? datepikeker = await showDatePicker(
            context: context,
            initialDate: today,
            firstDate: today,
            lastDate: DateTime(2025))
        .then((value) {
      selectedDate = true;
      currentDate = value;
      storeDate = value.toString();
      setState(() {
        widget.valueDate!(storeDate?.toString());
      });
      return null;
    });
    return datepikeker;
  }

  bool todayColor = false;
  bool tomorrowColor = false;
  bool otherColor = false;

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
              child: ElevatedButton(
                  onPressed: () {
                    todayColor = true;
                    tomorrowColor = false;
                    otherColor = false;
                    storeDate = DateFormat('yyyy-MM-dd').format(today);
                    setState(() {
                      widget.valueDate!(storeDate.toString());
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      todayColor
                          ? const Color.fromARGB(255, 95, 251, 100)
                          : Colors.white,
                    ),
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                  ),
                  child: Text(
                    style: const TextStyle(fontSize: 11, color: Colors.black),
                    "Today\n${DateFormat("dd-MMM").format(today)}",
                    textAlign: TextAlign.center,
                  )),
            ),
            SizedBox(
              width: 105,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    todayColor = false;
                    tomorrowColor = true;
                    otherColor = false;
                    tomorrow = DateFormat('yyyy-MM-dd')
                        .format(today.add(const Duration(days: 1)));
                    storeDate = tomorrow;
                    setState(() {
                      widget.valueDate!(storeDate.toString());
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      tomorrowColor
                          ? const Color.fromARGB(255, 95, 251, 100)
                          : Colors.white,
                    ),
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                  ),
                  child: Text(
                    style: const TextStyle(fontSize: 11, color: Colors.black),
                    "Tomorrow\n${DateFormat("dd-MMM").format(today.add(const Duration(days: 1)))}",
                    textAlign: TextAlign.center,
                  )),
            ),
            SizedBox(
                width: 136,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    date();
                    todayColor = false;
                    tomorrowColor = false;
                    otherColor = true;
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      otherColor
                          ? const Color.fromARGB(255, 95, 251, 100)
                          : Colors.white,
                    ),
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: date,
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black,
                        ),
                      ),
                      if (currentDate == null)
                        const Text(
                            style: TextStyle(fontSize: 11, color: Colors.black),
                            "Other\nDates"),
                      if (currentDate != null)
                        Text(
                            style: const TextStyle(
                                fontSize: 11, color: Colors.black),
                            "Other\n${DateFormat("dd-MMM").format(currentDate!).toString()}")
                      // selectedDate
                      //     ? Text(
                      //         style: const TextStyle(
                      //             fontSize: 11, color: Colors.black),
                      //         "Other\n${DateFormat("dd-MMM").format(currentDate!).toString()}")
                      //     : const Text(
                      //         style: TextStyle(
                      //             fontSize: 11, color: Colors.black),
                      //         "Other\nDates")
                    ],
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        TimeSlot(
          callBackValue1: (start) {
            startTime = start;
            setState(() {
              widget.valueStart!(startTime);
            });
          },
          callBackValue2: (end) {
            endTime = end;
            setState(() {
              widget.valueEnd!(endTime);
            });
          },
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
