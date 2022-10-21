import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieScreen extends StatelessWidget {
  const LottieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_dXNLiFDtBY.json'),
      ),
    );
  }
}
