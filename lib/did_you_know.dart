import 'package:flutter/material.dart';
import 'dart:math';

class DidYouKnowPage extends StatefulWidget {
  @override
  _DidYouKnowPageState createState() => _DidYouKnowPageState();
}

class _DidYouKnowPageState extends State<DidYouKnowPage> {
  final List<String> _triviaList = [
    "HTML was first released in 1993!",
    "CSS was first proposed in 1994 and became a standard in 1996.",
    "JavaScript was created in just 10 days in 1995!",
    "The first website ever made is still online at info.cern.ch.",
    "Web development jobs are expected to grow by 13% by 2030!",
    "Over 50% of websites use WordPress as a CMS!",
    "The 'div' tag is one of the most commonly used HTML elements.",
  ];

  String _currentTrivia = "Click 'What?' to learn a fact!";

  void _showRandomTrivia() {
    setState(() {
      _currentTrivia = _triviaList[Random().nextInt(_triviaList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Did You Know?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _currentTrivia,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showRandomTrivia,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "What?",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
