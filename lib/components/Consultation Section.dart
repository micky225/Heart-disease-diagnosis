import 'package:flutter/material.dart';
import 'package:insta_med_ui/components/Section%20Header.dart';

class ConsultationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Consultations'),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Angela Cham', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Dentist'),
                  Text('16 July, 2021 at 10:30 AM', style: TextStyle(color: Colors.grey)),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
