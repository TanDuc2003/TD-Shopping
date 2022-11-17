import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:td_shoping/constants/global_variables.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: GlobalVariables.carouselImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImages = GlobalVariables.carouselImages[index];
            return buildImages(urlImages, index);
          },
          options: CarouselOptions(
            aspectRatio: 1,
            enlargeCenterPage: true,
            viewportFraction: 0.95,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            height: 200,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 5,
          child: buildIndicator(),
        ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        effect: WormEffect(
          dotHeight: 9,
          dotWidth: 9,
          activeDotColor: Colors.red.withOpacity(1),
          dotColor: Colors.white,
        ),
        count: GlobalVariables.carouselImages.length,
      );

  Widget buildImages(String urlImages, int index) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Image.network(
            urlImages,
            fit: BoxFit.cover,
          ),
        ),
      );
}
