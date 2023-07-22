import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('About School',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w400, color: Colors.white)),
        leading: Builder(
          builder: (BuildContext context) {
            return const BackButton(
              color: Colors.white,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: const NetworkImage(
                      'https://lh3.googleusercontent.com/p/AF1QipNaT4qDQpoml4L04ZhktN6D2Pi7WTf3Bmm7LkAd=s680-w680-h510'),
                ),
              ),
              Text(
                'Managed by',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 15),
              ),
              Text(
                'SAFFRON EDUCATION AND CHARITABLE TRUST',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Blue Saffron Pre-School is established and managed by SAFFRON EDUCATION AND CHARITABLE TRUST',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Board of Members',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Card(
                        shadowColor: Theme.of(context).colorScheme.onBackground,
                        surfaceTintColor:
                            Theme.of(context).colorScheme.background,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.person,
                                size: 60,
                              ),
                            ),
                            const Text(
                              'Hitesh Gohil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            const Text(
                              '(President)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Card(
                        shadowColor: Theme.of(context).colorScheme.onBackground,
                        surfaceTintColor:
                            Theme.of(context).colorScheme.background,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: 60,
                              height: 60,
                              child: const Icon(
                                Icons.person,
                                size: 60,
                              ),
                            ),
                            const Text(
                              'Nehal Gohil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            const Text(
                              '(Member)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
