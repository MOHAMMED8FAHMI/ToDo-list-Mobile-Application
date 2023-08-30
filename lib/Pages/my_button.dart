import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color(0xFF3366FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, // Change text color here
          // You can add more text styling properties if needed
        ),
      ),
    );
  }
}
