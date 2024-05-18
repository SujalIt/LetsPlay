import 'package:flutter/material.dart';

class TimeSlot extends StatefulWidget {
  const TimeSlot({super.key});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {

  List<String> times = <String>['6 AM','7 AM','8 AM','9 AM','10 AM','6 PM','7 PM','8 PM','9 PM','10 PM',
  '11 PM','12 PM','1 AM','2 AM',];

  String? selectedTime = '6 AM';

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 160,
              child: Flexible(
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
                    items: times
                          .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: const TextStyle(fontSize: 14),)
                            )
                          ).toList(), 
                          onChanged: (item) => setState(() => selectedTime = item),
                            ),
              ),
            ),
            const Text('To'),
            Flexible(
              child: SizedBox(
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
                    items: times
                          .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: const TextStyle(fontSize: 14),)
                            )
                          ).toList(), 
                          onChanged: (item) => setState(() => selectedTime = item),
                            ),
              ),
            ),
          ],
        );
  }
}