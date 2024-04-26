import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotPageFoundView extends StatelessWidget {
  const NotPageFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404 - Página no encontrada',
        style: GoogleFonts.montserratAlternates().copyWith(
          fontSize: 50,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}