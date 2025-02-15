import 'package:flutter/material.dart';

class Dummycard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final String? image1;
  final String? image2;
  final String? image3;
  final VoidCallback onPressed;

  const Dummycard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.image1,
    this.image2,
    this.image3,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color(0XFFf9f0da),
      elevation: 4,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6C018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: image3 != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonText,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      )
                    : Text(
                        buttonText,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
          if (image1 != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(image1!, width: 150, fit: BoxFit.cover),
            ),
          if (image2 != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(image2!, width: 150),
            ),
          if (image3 != null)
            Positioned(
              right: 0,
              left: 0,
              top: 135,
              child: Image.asset(
                "assets/category/3.png",
                width: 230,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
