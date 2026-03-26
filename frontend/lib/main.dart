import 'package:flutter/material.dart';
import 'package:frontend/core/colors_style.dart';
import 'package:frontend/screens/Cliente/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.frederickaTheGreatTextTheme(),
      ),
      home: Scaffold(
        backgroundColor: AppColors.background,
        body: HomeScreen(),
        ),
      )
    ;
  }
}