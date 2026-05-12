import 'package:flutter/material.dart';
import 'package:fork_mate/controller/cart_controller.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/view/customer/widget/counter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/network_image_container.dart';
import 'package:fork_mate/view/customer/widget/preferences_box.dart';

class EditableOrderItemBox extends GetView<CartController> {
  const EditableOrderItemBox({
    super.key,
    required this.itemModel,
    required this.itemKey,
    required this.orderId,
    this.editable = false,
  });
  final ItemModel itemModel;
  final int itemKey;
  final int orderId;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.sidePadding / 2),
      child: Container(
        padding: EdgeInsets.all(editable ? SizeConfig.sidePadding : 0),
        decoration: editable ? boxDecoration : null,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    NetworkImageContainer(
                      imageURL: itemModel.image,
                      width: SizeConfig.width * 0.12,
                      height: SizeConfig.width * 0.12,
                      radius: SizeConfig.radius / 1.4,
                    ),
                    SizedBox(width: SizeConfig.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemModel.name,
                          style: TextStyle(fontSize: SizeConfig.fontMedium),
                        ),
                        if (editable)
                          Counter(
                            count: itemModel.count,
                            increment: () {
                              itemModel.increment();
                              controller.update();
                            },
                            decrement: () {
                              itemModel.decrement();
                              controller.update();
                            },
                          ),
                        if (!editable) Text('${itemModel.count}'),
                      ],
                    ),
                  ],
                ),
                Text(
                  formatPrice(itemModel.getTotalPrice()),
                  style: TextStyle(fontSize: SizeConfig.fontSmall),
                ),
              ],
            ),
            if (editable)
              Column(
                children: [
                  Divider(),
                  SizedBox(
                    width: SizeConfig.width,
                    child: Wrap(
                      children: itemModel.preferences.map((preference) {
                        return PreferencesBox(
                          preferencesModel: preference,
                          itemModel: itemModel,
                          size: SizeConfig.fontSmall,
                          callback: controller.update,
                        );
                      }).toList(),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: GestureDetector(
                      onTap: () {
                        controller.cart[orderId]!.removeItem(
                          itemId: itemModel.id,
                          itemKey: itemKey,
                        );
                        controller.update();
                      },
                      child: Icon(MdiIcons.delete, color: elegantYellow),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
