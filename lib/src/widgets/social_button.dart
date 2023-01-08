import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Color color;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
