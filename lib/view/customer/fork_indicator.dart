import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:lottie/lottie.dart';

class ForkIndicator extends StatelessWidget {
  const ForkIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width * 0.13,
      height: SizeConfig.width * 0.13,
      child: Lottie.asset('assets/animation/fork_orange.json', animate: true),
    );
  }
}
