import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        alignment: const Alignment(0, -1),
        children: [
          Column(
            children: [
              Container(
                height: height * 0.2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          Container(
            height: height * 0.33,
            width: width * 0.9,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                //  color: Colors.amber,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.065),
              child: Container(
                // width: width * 0.9,
                // height: height * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.086,
                    ),
                    Text(
                      'Harsh Makwana',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '(Junior kg)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      color: Colors.black,
                      height: 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.call,
                          size: 30,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: .1,
                          height: 40,
                        ),
                        const Icon(
                          Icons.mail_outline,
                          size: 35,
                        ),
                        Container(
                          //margin: const EdgeInsets.symmetric(vertical: 15),
                          color: Colors.black,
                          width: 0.1,
                          height: 40,
                        ),
                        const Icon(Icons.whatshot)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/smiley-boy-holding-stack-books_23-2148414545.jpg'),
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
    );
  }
}
