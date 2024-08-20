import 'package:flutter/material.dart';
import 'package:insta_med_ui/components/Section%20Header.dart';

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.favorite, 'label': 'Cardiology'},
    {'icon': Icons.accessibility_new, 'label': 'Orthopedics'},
    {'icon': Icons.north, 'label': 'Dental'},
    {'icon': Icons.biotech, 'label': 'Pathology'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Categories'),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                  child: Icon(category['icon'], color: Colors.teal),
                ),
                SizedBox(height: 5),
                Text(category['label'], style: TextStyle(fontSize: 12)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
