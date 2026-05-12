import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/one_line_note.dart';
import 'package:get/get_utils/get_utils.dart';

class RunningOrderNotesSection extends StatelessWidget {
  const RunningOrderNotesSection({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.sidePadding),

          Text(
            'addition details'.tr,
            style: TextStyle(fontSize: SizeConfig.fontMedium),
          ),
          SizedBox(height: SizeConfig.sidePadding),
          ...order.usedCoupon.entries.map(
            (coupon) => OneLineNote(
              note: [
                'A coupon worth',
                '  '
                    "${coupon.value} %",
                '  ',
                'has been applied',
              ],
              color: Colors.green,
            ),
          ),
          ...order.usedCode.entries.map(
            (code) => OneLineNote(
              note: [
                "A code worth",
                '  ',
                "${code.value} %",
                '  ',
                'has been activated',
              ],
              color: elegantYellow,
            ),
          ),
          if (order.freeDeliveryCoupons)
            OneLineNote(
              note: ['A free delivery coupon has been used'],
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
