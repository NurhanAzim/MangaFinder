import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/manga_model.dart';
import 'carousel_item.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.list,
  });

  final List<MangaModel> list;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: list
            .map((item) => CarouselItem(
                  malId: item.malId,
                  imageUrl: item.imageUrl,
                  title: item.title,
                ))
            .toList(),
        options: CarouselOptions(
          aspectRatio: 1 / 0.8,
          autoPlay: true,
          viewportFraction: 1,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          enlargeCenterPage: false,
        ));
  }
}
