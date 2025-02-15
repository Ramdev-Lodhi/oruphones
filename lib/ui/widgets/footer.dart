import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                'Get Notified About Our Latest Offers and Price Drops',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Container(
                width: 259,
                height: 43,
                padding: EdgeInsets.only(left: 15, top: 7, right: 7, bottom: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(72),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your email here',
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 500,
              color: Color(0xFF363636),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('Download App',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/social/image.png', height: 120),
                          Image.asset('assets/social/PlayStore.png', height: 40),
                        ],
                      ),
                      SizedBox(width: 20),
                      Image.asset('assets/social/qr.png', height: 160),
                    ],
                  ),
                  SizedBox(height: 60),
                  Text('Invite a Friend',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: -100, // Adjust this value for perfect positioning
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Invite a friend to ORUphones application. Tap to copy the respective download link to the clipboard.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/social/play_apple.png', height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 110),
        Text('Or Share', style: TextStyle(color: Colors.black)),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Image.asset('assets/social/insta.png'), onPressed: () {}),
              IconButton(icon: Image.asset('assets/social/teli.png'), onPressed: () {}),
              IconButton(icon: Image.asset('assets/social/twiter.png'), onPressed: () {}),
              IconButton(icon: Image.asset('assets/social/whatsapp.png'), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
