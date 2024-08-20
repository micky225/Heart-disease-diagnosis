import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:insta_med_ui/screens/homescreen/HistoryScree.dart';
import 'package:insta_med_ui/screens/homescreen/InputScreen.dart';
import 'package:insta_med_ui/screens/homescreen/chatscreen.dart';
import 'package:insta_med_ui/screens/homescreen/profile.dart';
import '../screens/home_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    HistoryScreen(),
    ChatScreen(),
    InputScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r), // Increased corner radius
            topRight: Radius.circular(25.r),
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).cardColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, -7),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 30.w),
          child: CurvedNavigationBar(
            height: 70.h > 75.0 ? 75.0 : 70.h,
            items: <Widget>[
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.history, "History", 1),
              _buildNavItem(Icons.chat, "Chat", 2),
              _buildNavItem(Icons.search, "Detect", 3), // Using search icon for "Entry"
              _buildNavItem(Icons.person, "Profile", 4),
            ],
            color: Colors.transparent,
            buttonBackgroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: _onItemTapped,
            letIndexChange: (index) => true,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30.sp,
          color: isSelected ? Colors.white : Colors.grey,
        ),
        if (isSelected)
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Container(
              height: 3.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
      ],
    );
  }
}
