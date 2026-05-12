import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/shared_widget/custom_button.dart';

class CountControlPanel extends StatelessWidget {
  const CountControlPanel({
    super.key,
    required this.increment,
    required this.decrement,
    required this.clear,
    required this.count,
    required this.price,
  });
  final VoidCallback increment;
  final VoidCallback decrement;
  final VoidCallback clear;
  final int count;
  final double price;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomButton(
                title: '+',
                hasShadow: false,
                isSelected: true,
                onTap: () {
                  increment();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.sidePadding,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(fontSize: SizeConfig.fontRegular),
                ),
              ),
              CustomButton(
                title: '-',
                isSelected: true,
                hasShadow: false,
                onTap: () {
                  decrement();
                },
              ),
              SizedBox(width: SizeConfig.sidePadding),

              GestureDetector(
                onTap: () {
                  clear();
                },
                child: Icon(Icons.restart_alt, size: SizeConfig.width * 0.07),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),
            child: RichText(
              text: TextSpan(
                text: formatPrice(price),
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: SizeConfig.fontMedium,
                  color: xMainColor,
                  fontFamily: 'NotoNaskhArabic',
                ),
                children: [
                  TextSpan(text: '  '),
                  TextSpan(
                    text: '\$',
                    style: TextStyle(
                      fontSize: SizeConfig.fontRegular,
                      color: const Color.fromARGB(255, 5, 222, 12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
