import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Datepiker extends StatefulWidget {
  Function(DateTime?)? dateCall;
  Datepiker({super.key, this.dateCall});

  @override
  State<Datepiker> createState() => _DatepikerState();
}

class _DatepikerState extends State<Datepiker> {
  TextEditingController datecontroller = TextEditingController();
  date() async {
    DateTime? datepikeker = await showDatePicker(
        context: context,
        initialDate:currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100))
        .then((value) {
      receivedDate = value.toString();
      currentDate = value;
      widget.dateCall!(currentDate);
      setState(() {});
      return null;
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
    return  Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
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
                  widget.dateCall!(currentDate);
                  setState(() {});
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)))),
                    backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 95, 251, 100),)),
                child: const Text(
                  'Next Day',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
