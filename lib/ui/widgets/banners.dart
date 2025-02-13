import 'dart:async';
import 'package:flutter/material.dart';

class BannerWidgets extends StatefulWidget {
  const BannerWidgets({super.key});

  @override
  State<BannerWidgets> createState() => _BannerWidgetsState();
}

class _BannerWidgetsState extends State<BannerWidgets> {
  final PageController _controller = PageController();
  int pageIndex = 0;
  Timer? _timer;

  final List<String> banners = [
    'assets/banners/Banner 1.png',
    'assets/banners/Banner 2.png',
    'assets/banners/Banner 3.png',
    'assets/banners/Banner 4.png',
    'assets/banners/Banner 5.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller.hasClients) {
        int nextPage = (pageIndex + 1) % banners.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 358,
            height: 175,
            child: PageView.builder(
              controller: _controller,
              itemCount: banners.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(11.88),
                  child: Image.asset(
                    banners[index],
                    width: 358,
                    height: 175,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              banners.length,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: dotIndicator(index: index, pageIndex: pageIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dotIndicator({required int index, required int pageIndex}) {
    return AnimatedContainer(
      height: 8,
      width: index == pageIndex ? 8 : 8,
      duration: const Duration(milliseconds: 310),
      decoration: BoxDecoration(
        color: index == pageIndex ? Colors.blue : Color(0xFFABABAB),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
