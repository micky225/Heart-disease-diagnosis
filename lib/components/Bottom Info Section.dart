import 'package:flutter/material.dart';

class BottomInfoSection extends StatelessWidget {
  final List<Map<String, String>> features = [
    {
      'icon': 'assets/icons/public-relations.png',
      'label': 'Find specialist doctors'
    },
    {
      'icon': 'assets/icons/schedule.png',
      'label': 'Schedule appointments easily'
    },
    {
      'icon': 'assets/icons/conversation.png',
      'label': 'Book online or offline consultations'
    },
    {'icon': 'assets/icons/results.png', 'label': 'Track your test results'},
    {
      'icon': 'assets/icons/stationery.png',
      'label': 'Get medical supplies faster & simpler'
    },
    {
      'icon': 'assets/icons/call-center-agent.png',
      'label': 'Reliable & verified information'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text(feature['label']!, style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
