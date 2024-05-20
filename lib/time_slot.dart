import 'package:flutter/material.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({super.key});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {

  List<String> times = <String>['1 AM','2 AM','3 AM','4 AM','5 AM','6 AM','7 AM','8 AM','9 AM','10 AM','11 AM','12 PM','1 PM','2 PM','3 PM','4 PM','5 PM','6 PM','7 PM','8 PM','9 PM','10 PM',
  '11 PM','12 AM',];

  String? staticTime = '6 AM';
  String? selectedTime;
  late int  newTimeIndex;

  List filterTime = [];
  List finalTime = [];

  filterSlot() {
    filterTime.clear();
    for(int i = 0;i < times.length;i++){
      if(i > newTimeIndex){
      filterTime.add(times[i]);
      }
    }  

    finalTime = filterTime.sublist(0,4);

    setState(() {
      filterTime;
      finalTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 160,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, 
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                  value: staticTime,
                  items: times
                        .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: const TextStyle(fontSize: 14),)
                          )
                        ).toList(), 
                        onChanged: (item) => setState(() {staticTime = item;
                        newTimeIndex = times.indexOf(item!);
                        filterSlot();
                        }),
                          ),
            ),
            const Text('To'),
            SizedBox(
              height: 50,
              width: 160,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, 
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,
                    width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                  value: selectedTime,
                  items: finalTime
                        .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: const TextStyle(fontSize: 14),)
                          )
                        ).toList(), 
                        onChanged: (item) => setState((){
                          selectedTime = item;
                        }),
                          ),
            ),
          ],
        );
  }
}