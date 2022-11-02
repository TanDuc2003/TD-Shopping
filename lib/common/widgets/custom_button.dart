import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final VoidCallback onTap;
  final IconData? icondata;
  final bool enableIcon;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.textSize = 20,
    this.icondata,
    this.enableIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: enableIcon
          ? Row(
              children: [
                Icon(
                  icondata,
                  size: 28,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: textSize,
                    color: color == null ? Colors.white : Colors.black,
                  ),
                ),
              ],
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                color: color == null ? Colors.white : Colors.black,
              ),
            ),
    );
  }
}
