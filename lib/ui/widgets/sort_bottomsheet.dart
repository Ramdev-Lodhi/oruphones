import 'package:flutter/material.dart';

class SortBottomSheet extends StatefulWidget {
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  final List<String> sortOptions = [
    "Value For Money",
    "Price: Low to High",
    "Price: High to Low",
    "Latest",
    "Distance"
  ];

  String? selectedSort = "Latest";
  String? initialSort = "Latest";

  @override
  Widget build(BuildContext context) {
    bool hasChanged = selectedSort != initialSort;

    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sort", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          Divider(),
          // Sort Options List
          Expanded(
            child: ListView.builder(
              itemCount: sortOptions.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedSort == sortOptions[index];
                return Container(
                  color: isSelected ? Colors.yellow.shade50 : Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSort = sortOptions[index];
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(sortOptions[index]),
                        Radio<String>(
                          value: sortOptions[index],
                          groupValue: selectedSort,
                          activeColor: Color(0xFFF6C018),
                          onChanged: (value) {
                            setState(() {
                              selectedSort = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedSort = initialSort;
                  });
                },
                child: Text("Clear", style: TextStyle(color: Colors.orange)),
              ),
              ElevatedButton(
                onPressed: hasChanged
                    ? () => Navigator.pop(context, selectedSort)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasChanged ? Color(0xFFF6C018) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                child: Text("Apply", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
