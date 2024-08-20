import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_med_ui/widgets/featured_services_widget.dart';
import 'package:insta_med_ui/widgets/header_widget.dart';
import 'package:insta_med_ui/widgets/services_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: 20.h),
            ServicesWidget(),
            SizedBox(height: 20.h),
            FeaturedServicesWidget(),
          ],
        ),
      ),
    );
  }
}
