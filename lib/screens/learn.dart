import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        appBar: AppBar(
          title: Text('B'),
          backgroundColor: Colors.blue, 
        ),
       
        body: Container(
          color: Colors.lightBlueAccent, 
          child: Center(
            child: Text(
              'Hello, James ',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
