import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/check_if_preference_there.dart';
import 'package:fork_mate/functions/quick_dialog.dart';
import 'package:fork_mate/models/customer/items_model.dart';
import 'package:fork_mate/utils/size_config.dart';

class PreferencesBox extends StatelessWidget {
  const PreferencesBox({
    super.key,
    required this.preferencesModel,
    required this.itemModel,
    required this.size,
    this.callback,
  });
  final PreferencesModel preferencesModel;
  final ItemModel? itemModel;
  final VoidCallback? callback;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.sidePadding),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: preferencesModel.preference.map((preference) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              checkIfPreferenceThere(
                    preference: preference.name,
                    preferences:
                        itemModel?.chosenPreference[preferencesModel.id],
                  )
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        itemModel?.removePreference(
                          preferencesModel.id,
                          preference.name,
                        );
                        showQuickDialog(-1 * preference.priceDifference);
                        callback?.call();
                      },
                      child: Icon(
                        Icons.check_box_outlined,
                        color: elegantYellow,
                        size: size,
                      ),
                    )
                  : GestureDetector(
                      behavior: HitTestBehavior.opaque,

                      onTap: () {
                        itemModel?.addPreference(
                          preferencesModel.id,
                          preferencesModel.type,
                          preference.name,
                          preference.priceDifference,
                        );
                        showQuickDialog(preference.priceDifference);
                        callback?.call();
                      },
                      child: Icon(Icons.check_box_outline_blank, size: size),
                    ),
              SizedBox(width: SizeConfig.width * 0.01),
              Text(preference.name, style: TextStyle(fontSize: size)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
