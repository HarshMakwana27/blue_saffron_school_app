import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class GallaryScreen extends StatelessWidget {
  const GallaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Gallary',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://lh3.googleusercontent.com/p/AF1QipNaT4qDQpoml4L04ZhktN6D2Pi7WTf3Bmm7LkAd=s680-w680-h510'),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://lh3.googleusercontent.com/p/AF1QipPgyjIqqmeenBwaIOF_e9focezHIOLJD6o_lSz8=s680-w680-h510'),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://lh3.googleusercontent.com/p/AF1QipOia2zG_OPuVJ40Wc5OZlvwXYP1GLqIlb_SnMll=s680-w680-h510'),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://lh3.googleusercontent.com/p/AF1QipOOufMCQ6b6eUEhjFR4wXA7j6bpEbTm93P60_4z=s680-w680-h510'),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: const NetworkImage(
                    'https://lh3.googleusercontent.com/p/AF1QipOHzmk7brtv2b48Y3cMXY1Tj5_SizuMlGaNuRXw=s680-w680-h510'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
