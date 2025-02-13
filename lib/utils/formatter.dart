// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../sort_viewmodel.dart';
// import '../sort_bottom_sheet.dart';
// import 'Flutter_Bottom_Sheet.dart';
//
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sorting Example")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                   ),
//                   builder: (context) => SortBottomSheet(),
//                 );
//               },
//               child: Text("Open Sort Bottom Sheet"),
//             ),
//             SizedBox(height: 10,),
//             ElevatedButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (context) => FilterBottomSheet(),
//                 );
//               },
//               child: Text("Open Filter Bottom Sheet"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isBottomNavVisible = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (_isBottomNavVisible) {
              setState(() {
                _isBottomNavVisible = false;
              });
            }
          } else if (notification.direction == ScrollDirection.forward) {
            if (!_isBottomNavVisible) {
              setState(() {
                _isBottomNavVisible = true;
              });
            }
          }
          return true;
        },
        child: ListView.builder(
          itemCount: 50, // Print 50 times
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Add some spacing
                child: Text(
                  "Selected Tab: $_selectedIndex",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),

      // Floating Action Button with a Black Circle inside an Amber Circle
      floatingActionButton: _isBottomNavVisible
          ? Stack(
              alignment: Alignment.center,
              children: [
                // Outer Amber Circle
                Container(
                  width: 65, // Slightly larger than FAB
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
                // Inner Black Circle (Actual FAB)
                FloatingActionButton(
                  onPressed: () {
                    // Add action here
                  },
                  shape: CircleBorder(),
                  backgroundColor: Colors.black,
                  child: Icon(Icons.add, size: 30, color: Colors.amber),
                ),
              ],
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Animated Bottom Navigation Bar
      bottomNavigationBar: _isBottomNavVisible
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut, // Add a curve
              height: 70, // Fixed height, only shown when visible
              child: BottomAppBar(
                notchMargin: 8,
                child: SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navItem(Icons.home, "Home", 0),
                        navItem(Icons.list, "My Listings", 1),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text("Sell", style: TextStyle(fontSize: 19)),
                        ),
                        navItem(Icons.build, "Services", 2),
                        navItem(Icons.person, "Account", 3),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null, // Hide completely when not visible
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: _selectedIndex == index ? Colors.black : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.black : Colors.grey,
              fontWeight:
                  _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
