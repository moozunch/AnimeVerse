import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

//! buat warna gunanya sebagai background, makanya child nya child nnti kita isi
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [
        Color(0xFF1D1D2E),
        Color(0xFF252540),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      ),),
      child: child,
    );
  }
}
