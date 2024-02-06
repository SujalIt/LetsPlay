import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Datepiker extends StatefulWidget {
  const Datepiker({super.key});

  @override
  State<Datepiker> createState() => _DatepikerState();
}

class _DatepikerState extends State<Datepiker> {
  TextEditingController datecontroller = TextEditingController();
  date() async {
    DateTime? datepikeker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100))
        .then((value) {
      receivedDate = value.toString();
      currentDate = value;
      setState(() {});
    });
    return datepikeker;
  }
  DateTime? currentDate;
  String? receivedDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Flexible(
          child: Container(
            height: 42,
            child: TextField(
              onTap: date,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.none,
              controller: datecontroller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: date,
                    icon: const Icon(Icons.calendar_today)),
                hintText: DateFormat("dd-MM-yyyy")
                    .format(currentDate ?? DateTime.now()),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.green, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.green, width: 2)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              onPressed: () {
                //2024-01-12 14:45:20.265410
                DateTime? days = currentDate;
                receivedDate =
                    DateFormat("yyyy-MM-dd HH:mm:ss.SSSS")
                        .format(days!.add(const Duration(days: 1)));
                currentDate =
                    DateTime.parse(receivedDate.toString());
                setState(() {});
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)))),
                  backgroundColor:
                  MaterialStatePropertyAll(Colors.green)),
              child: const Text(
                'Next Day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }
}
