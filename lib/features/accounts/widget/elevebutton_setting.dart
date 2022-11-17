import 'package:flutter/material.dart';

class ElevaButtonSetting extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color color;
  final Color textcolor;
  const ElevaButtonSetting({
    super.key,
    required this.onpress,
    required this.title,
    this.color = Colors.white,
    this.textcolor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: color,
            foregroundColor: Colors.black),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: textcolor,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
