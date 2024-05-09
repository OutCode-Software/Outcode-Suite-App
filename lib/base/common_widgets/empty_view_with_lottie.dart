// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_styles.dart';

class EmptyViewWithLottie extends StatelessWidget {
  EmptyViewWithLottie(this.lottie, this.message, {super.key});
  String lottie;
  String message;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 250,
      height: 300,
      child: Column(children: [
        Lottie.asset('assets/lottie/$lottie.json', repeat: true),
        Text(
          message,
          style: AppStyles.regularSmall(),
        )
      ]),
    ));
  }
}
