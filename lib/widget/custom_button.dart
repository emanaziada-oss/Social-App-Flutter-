import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String route;

  const CustomButton({
    super.key,
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: OutlinedButton.styleFrom(
          // side: const BorderSide(color: Color(0xFFFF6A77), width: 2),
          // foregroundColor: Color(0xFFFF6A77),
          side: const BorderSide(color: Colors.white, width: 2),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
