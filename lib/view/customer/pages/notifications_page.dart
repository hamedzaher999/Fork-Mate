import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/custom_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  // flutter pub add firebase_core
  // flutter pub add firebase_messaging
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SizedBox(
        child: ListView.separated(
          padding: EdgeInsets.only(
            top: SizeConfig.sidePaddingX2,
            left: SizeConfig.sidePadding,
            right: SizeConfig.sidePadding,
            bottom: SizeConfig.height * 0.1,
          ),
          itemCount: 20,
          separatorBuilder: (_, _) =>
              SizedBox(height: SizeConfig.sidePadding / 3),
          itemBuilder: (_, _) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.sidePadding,
                horizontal: SizeConfig.sidePadding * 1.3,
              ),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(SizeConfig.radius * 1.3),
              ),
              height: SizeConfig.height * 0.11,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // spacing: SizeConfig.sidePadding,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'benefits',
                        style: TextStyle(fontSize: SizeConfig.fontXSmall),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: SizeConfig.sidePadding,
                        ),
                        child: Text(
                          'you got a free delivery coupon got a free delivery coupon got a free delivery coupon got a free delivery coupon got a free delivery coupon got a free delivery coupon',
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: const Color.fromARGB(255, 139, 137, 96),

                            fontSize: SizeConfig.fontXXSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '12:55 pm',
                        style: TextStyle(
                          // color: const Color.fromARGB(255, 139, 137, 96),
                          fontSize: SizeConfig.fontXXSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
