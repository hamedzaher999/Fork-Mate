import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OneLineNote extends StatelessWidget {
  const OneLineNote({
    super.key,
    required this.note,
    this.color,
    this.decoration = false,
    this.suffix,
  });
  final List<String> note;
  final Color? color;
  final bool decoration;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: decoration ? (SizeConfig.sidePadding / 3) : 0,
        horizontal: SizeConfig.sidePadding,
      ),
      decoration: decoration ? boxDecoration : null,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: SizeConfig.fontXSmall * 0.5,
                  color: color ?? Colors.black,
                ),
                SizedBox(width: SizeConfig.horizontalSpace),
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: SizeConfig.fontXSmall,
                    ),
                    children: note.expand((note) {
                      return [TextSpan(text: note.tr), TextSpan(text: ' ')];
                    }).toList(),
                  ),
                ),
              ],
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
