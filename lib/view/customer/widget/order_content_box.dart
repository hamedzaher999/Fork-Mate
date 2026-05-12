import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_price.dart';
import 'package:fork_mate/models/customer/running_order_model2.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/utils.dart';

class OrderContentBox extends StatelessWidget {
  const OrderContentBox({super.key, required this.order});
  final RunningOrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      padding: EdgeInsets.all(SizeConfig.sidePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (order.items.isNotEmpty) ...[
            ...order.items.map(
              (item) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.center,
                          item.count.toString(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          textAlign: TextAlign.end,
                          formatPrice(item.price),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.sidePadding / 2),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig.sidePadding / 2,
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ...item.chosenPreference.map(
                          (preference) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_box_outlined,
                                color: elegantYellow,
                                size: SizeConfig.fontSmall,
                              ),
                              SizedBox(width: SizeConfig.sidePadding / 2),

                              Text(
                                preference,
                                style: TextStyle(
                                  fontSize: SizeConfig.fontXSmall,
                                ),
                              ),
                              SizedBox(width: SizeConfig.sidePadding),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.withAlpha(100)),
                ],
              ),
            ),
            // Divider(),
          ],
          if (order.offers.isNotEmpty) ...[
            ...order.offers.map(
              (offer) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      offer.name,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      offer.count.toString(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      textAlign: TextAlign.end,
                      formatPrice(offer.price),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
          if (order.gifts.isNotEmpty) ...[
            ...order.gifts.map(
              (gift) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wallet_giftcard,
                        color: elegantYellow,
                        size: SizeConfig.fontXSmall,
                      ),
                      SizedBox(width: SizeConfig.sidePadding),
                      Text('gift number'.tr),
                      SizedBox(width: SizeConfig.sidePadding),
                      Text(
                        gift.giftNumber,
                        style: TextStyle(fontSize: SizeConfig.fontXSmall),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.sidePadding / 2),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig.sidePadding,
                    ),
                    child: Text(
                      gift.description,
                      style: TextStyle(fontSize: SizeConfig.fontXXSmall),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'.tr),
              Text(
                formatPrice(order.contentPrice),
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
