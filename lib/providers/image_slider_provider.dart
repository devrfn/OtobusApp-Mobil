import 'package:flutter/material.dart';

class ImageSliderProvider extends ChangeNotifier {
  final sliderItems = [
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          width: 300,
          height: 200,
          "assets/imgs/buss1.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          width: 300,
          height: 200,
          "assets/imgs/buss2.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          width: 300,
          height: 200,
          "assets/imgs/otobus_ic1.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          width: 300,
          height: 200,
          "assets/imgs/buss3.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          height: 200,
          width: 300,
          "assets/imgs/buss4.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
    Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          height: 200,
          width: 300,
          "assets/imgs/otobus_ic2.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
