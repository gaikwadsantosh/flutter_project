import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  final List imageList = [
    {
      "id": 1,
      "image_path":
          "https://images-eu.ssl-images-amazon.com/images/W/MEDIAX_792452-T1/images/G/31/img22/Toys/HTL2023/GW/Homepage_DesktopHeroTemplate_3000x1200_Unrec._CB570906581_.jpg"
    },
    {
      "id": 1,
      "image_path":
          "https://images-eu.ssl-images-amazon.com/images/W/MEDIAX_792452-T1/images/G/31/img15/4th/sept/unrechero/8thslot/Tws_Tallhero_3000x1200._CB596103422_.jpg"
    },
    {
      "id": 1,
      "image_path":
          "https://images-eu.ssl-images-amazon.com/images/W/MEDIAX_792452-T1/images/G/31/img23/Softlines_JWL_SH_GW_Assets/Dec23/Shoes/EOSS/Unrec/AU/SportsShoes/v1/3000-min._CB586568496_.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (kDebugMode) {
              print("Carousel clicked : $currentIndex");
            }
          },
          child: CarouselSlider(
            items: imageList
                .map(
                  (item) => CachedNetworkImage(
                    imageUrl: item['image_path'],
                    fit: BoxFit.fill,
                    width: double.infinity,
                    //height: 100,
                  ),
                )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              aspectRatio: 8,
              viewportFraction: 0.75,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 17 : 7,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          currentIndex == entry.key ? Colors.red : Colors.teal),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
