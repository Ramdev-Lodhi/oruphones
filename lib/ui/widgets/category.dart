import 'package:flutter/material.dart';

class CategoryWidgets extends StatelessWidget {
  const CategoryWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'assets/category/1.png',
      'assets/category/2.png',
      'assets/category/3.png',
      'assets/category/4.png',
      'assets/category/5.png',
      'assets/category/6.png',
      'assets/category/7.png',
      'assets/category/8.png',
      'assets/category/9.png',
      'assets/category/10.png',
      'assets/category/11.png',
      'assets/category/12.png',
      'assets/category/13.png',
      'assets/category/14.png',
      'assets/category/15.png',
      'assets/category/16.png',
      'assets/category/17.png',
      'assets/category/18.png',
      'assets/category/19.png',
    ];

    final List<String> categoryNames = [
      "Buy Used Phones",
      "Sell Used Phones",
      "Compare Price",
      "My Profile",
      "My Listings",
      "Open Store",
      "Services",
      "Device Health Check",
      "Battery Health Check",
      "IME Verification",
      "Device Details",
      "Data Wipe",
      "Under Warranty Phones",
      "Premium Phones",
      "Like New Phones",
      "Refurbished Phones",
      "Verified Phones",
      "My Negotiation",
      "Favourites"
    ];

    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 12, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                "What's on your mind?",
                style: TextStyle(
                  fontSize: 18,
                  
                ),
              ),
            ),
            // Horizontal Scrollable List
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return Column(
                      children: [
                        Container(
                          width: 115,
                          height: 115,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                categories[index],
                                width: index < 5 ? 115 : 72,
                                height: index < 5 ? 115 : 72,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        // Category Name
                        SizedBox(
                          width: 90,
                          child: Text(
                            categoryNames[index],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
