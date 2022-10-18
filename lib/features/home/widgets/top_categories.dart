import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: GlobalVariables.carouselImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]['image']!,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Text(
                GlobalVariables.categoryImages[index]['title']!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
