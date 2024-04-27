import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final Function()? onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({
    super.key, 
    required this.text, 
    required this.icon, 
    this.color = Colors.indigo, 
    this.isFilled = false,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(StadiumBorder()),
        backgroundColor: MaterialStatePropertyAll(color.withOpacity(0.5)),
        overlayColor: MaterialStatePropertyAll(color.withOpacity(0.3)),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon, color: Colors.white,),
          Text(text, style: const TextStyle(color: Colors.white))
        ]
      ),
    );
  }
}