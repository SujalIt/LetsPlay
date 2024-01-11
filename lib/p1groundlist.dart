import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class p1groundlist extends StatelessWidget {
  const p1groundlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index){
          return SizedBox(
            height: 111,
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 95,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                  )
                ),
                width: 85,
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ14kWhEzjxa7WMypn5ykydcGG_O_Nbrc6U1QNfd95zb2YAGjN_H2FuDqtqQUGFJ6Bgll0&usqp=CAU", fit: BoxFit.cover,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27, right: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SK Sports', style: TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    const Text(
                      'Vandematram Road Gota,\nAhmedabad', style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                        height: 7,
                        ),
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(onPressed: (){}, 
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        )),
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 72, 255, 78))
                      ),child: const Text('Check availability', style: TextStyle(
                        color: Color.fromARGB(255, 44, 27, 27),
                        fontSize: 11.5,
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
      