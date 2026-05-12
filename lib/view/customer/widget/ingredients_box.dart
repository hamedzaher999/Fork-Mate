import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/controller/item_customizer_controller.dart.dart';
import 'package:fork_mate/utils/size_config.dart';

class IngredientsBox extends GetView<ItemCustomizerController> {
  const IngredientsBox({super.key, this.open = true});
  final bool open;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.arrow_drop_down, size: SizeConfig.fontXLarge),
            Text(
              'Ingredients'.tr,
              style: TextStyle(fontSize: SizeConfig.fontRegular),
            ),
          ],
        ),
        open
            ? Container(
                padding: EdgeInsets.all(SizeConfig.sidePadding),
                width: SizeConfig.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(SizeConfig.radius),
                ),
                child: Center(
                  child: Text(
                    controller.itemModel.ingredients.join(' _ '),
                    style: TextStyle(fontSize: SizeConfig.fontMedium),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
