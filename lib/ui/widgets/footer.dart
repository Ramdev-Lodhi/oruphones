import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email here',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          height: 500,
            color: Color(0xFF363636),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Download App',
                    style:
                        TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/social/image.png', height: 120),
                        // SizedBox(height: 10),
                        Image.asset('assets/social/PlayStore.png', height: 40),
                      ],
                    ),
                    SizedBox(width: 20),
                    Image.asset('assets/social/qr.png', height: 160),
                  ],
                ),
                SizedBox(height: 60),
                Text('Invite a Friend',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            )),

        Transform.translate(
          offset: Offset(0, -160),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Or Share',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Image.asset('assets/social/insta.png'),
                          onPressed: () {}),
                      IconButton(
                          icon: Image.asset('assets/social/teli.png'),
                          onPressed: () {}),
                      IconButton(
                          icon: Image.asset('assets/social/twiter.png'),
                          onPressed: () {}),
                      IconButton(
                          icon: Image.asset('assets/social/whatsapp.png'),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
