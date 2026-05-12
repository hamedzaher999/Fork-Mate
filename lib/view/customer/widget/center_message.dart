import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/utils/size_config.dart';

class CenterMessage extends StatelessWidget {
  const CenterMessage({super.key, this.icon, this.message});
  final String? message;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message?.tr ?? ''),
            SizedBox(width: SizeConfig.height * 0.02),
            Icon(icon ?? MdiIcons.exclamation, size: SizeConfig.fontRegular),
          ],
        ),
      ),
    );
  }
}
