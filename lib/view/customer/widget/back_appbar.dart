import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_back_button.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key, this.title, this.onBackCallBack});
  final String? title;
  final VoidCallback? onBackCallBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title?.tr ?? '',
            style: TextStyle(fontSize: SizeConfig.fontMedium),
          ),
          CustomBackButton(onBackCallback: onBackCallBack),
        ],
      ),
    );
  }
}
