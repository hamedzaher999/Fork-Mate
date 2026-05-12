import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class LocalImageContainer extends StatelessWidget {
  const LocalImageContainer({
    super.key,
    required this.imageURL,
    required this.width,
    required this.height,
    this.radius,
  });
  final String imageURL;
  final double width;
  final double height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: imagePlaceHolderColor,
        borderRadius: BorderRadius.circular(SizeConfig.radius * 1.8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? SizeConfig.radius * 1.8),
        child: Image.asset(fit: BoxFit.cover, imageURL),
      ),
    );
  }
}
