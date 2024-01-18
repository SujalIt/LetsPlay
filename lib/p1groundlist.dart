import 'package:flutter/material.dart';

class p1groundlist extends StatefulWidget {
  const p1groundlist({super.key});

  @override
  State<p1groundlist> createState() => _p1groundlistState();
}

class _p1groundlistState extends State<p1groundlist> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
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
                    const Text(
                      'SK Sports', style: TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const Text(
                      'Vandematram Road Gota,\nAhmedabad', style: TextStyle(fontSize: 13,
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
        },
      ),
    );
  }
}
      