import 'package:flutter/material.dart';
import 'package:insta_med_ui/components/Section%20Header.dart';

class PopularDoctorsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Popular Doctors'),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DoctorCard(name: 'Gemma Davis', specialty: 'Cardiologist', rating: 4.8),
            DoctorCard(name: 'John Smith', specialty: 'Pediatrician', rating: 4.5),
          ],
        ),
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;

  const DoctorCard({required this.name, required this.specialty, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10),
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
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.teal,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(specialty, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5),
            Text('Rating: $rating'),
          ],
        ),
      ),
    );
  }
}
