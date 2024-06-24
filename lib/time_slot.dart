import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeSlot extends StatefulWidget {

  Function(String?)? callBackValue1;
  Function(String?)? callBackValue2;
  TimeSlot({super.key ,this.callBackValue1,this.callBackValue2});
  
  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {

  List<String> times = <String>['01:00 AM','02:00 AM','03:00 AM','4:00 AM','5:00 AM','06:00 AM','07:00 AM','08:00 AM','09:00 AM','10:00 AM','11:00 AM','12:00 PM','01:00 PM','02:00 PM','03:00 PM','04:00 PM','05:00 PM','06:00 PM','07:00 PM','08:00 PM','09:00 PM','10:00 PM',
  '11:00 PM','12:00 AM',];

  String? startTime = '06:00 AM';
  String? endTime;
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
                  value: startTime,
                  items: times
                        .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: const TextStyle(fontSize: 14),)
                          )
                        ).toList(), 
                        onChanged: (item) => setState(() {startTime = item;
                        newTimeIndex = times.indexOf(item ?? "");
                        widget.callBackValue1!(startTime);
                        filterSlot();
                        endTime = null;
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
                  value: endTime,
                  items: finalTime
                        .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,   style: const TextStyle(fontSize: 14),)
                          )
                        ).toList(), 
                        onChanged: (item) => setState((){
                          endTime = item;
                          widget.callBackValue2!(endTime);
                        }),
                          ),
            ),
          ],
        );
  }
}