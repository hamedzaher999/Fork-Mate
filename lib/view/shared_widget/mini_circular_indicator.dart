import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class MiniCircularIndicator extends StatelessWidget {
  const MiniCircularIndicator({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.02,
      width: SizeConfig.height * 0.02,
      child: CircularProgressIndicator(strokeWidth: 1.5, color: color ?? black),
    );
  }
}
