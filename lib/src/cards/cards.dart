import 'package:flutter/material.dart';


// Helper function to display community cards
  Widget buildCard(String imagePath) {
    return Container(
      child: Image.asset(
        imagePath,
        width: 46, // Card width
        height: 60, // Card height
      ),
    );
  }