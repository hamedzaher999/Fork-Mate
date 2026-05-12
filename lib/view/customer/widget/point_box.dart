import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/points_model.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_utils/get_utils.dart';

class PointBox extends StatelessWidget {
  const PointBox({super.key, required this.pointsModel});
  final PointsModel pointsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.sidePaddingX2),
      decoration: BoxDecoration(
        color: mainColor,
        boxShadow: shadow,
        border: Border.all(color: white),
        borderRadius: BorderRadius.circular(SizeConfig.radius),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'My Points'.tr,
            style: TextStyle(
              color: elegantYellow,
              fontSize: SizeConfig.fontMedium,
            ),
          ),
          SizedBox(height: SizeConfig.sidePadding),
          Text(
            "you have  @points  points worth  @value  S.P".trParams({
              'points': pointsModel.pointsCount.toStringAsFixed(1),
              'value': formatPrice(pointsModel.pointValue()),
            }),
          ),
        ],
      ),
    );
  }
}
