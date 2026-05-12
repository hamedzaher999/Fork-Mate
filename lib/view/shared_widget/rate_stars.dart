import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/functions/confirmation_dialog.dart';
import 'package:fork_mate/utils/size_config.dart';

class RateStars extends GetView<ItemCustomizerController> {
  const RateStars({super.key, required this.rate});
  final int rate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) {
        int id = index + 1;
        return GestureDetector(
          onTap: () async {
            bool confirm = await confirmationDialog(
              message: 'rate  @id  stars'.trParams({'id': id.toString()}),
              showAlert: false,
              confirmText: 'rate',
            );
            if (confirm) {
              controller.rate(controller.itemModel.id, id);
            }
          },
          child: Icon(
            id <= rate ? CupertinoIcons.star_fill : CupertinoIcons.star,
            color: stars,
            size: SizeConfig.width * 0.05,
          ),
        );
      }),
    );
  }
}
