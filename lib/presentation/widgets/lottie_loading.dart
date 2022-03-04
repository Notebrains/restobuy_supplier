import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  const LottieLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Lottie.asset('assets/animations/lottiefiles/3_line_loading.json',
            fit: BoxFit.cover, width: 300, height: 250,
        ),
      ),
    );
  }

}