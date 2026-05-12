import 'package:flutter/material.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/functions/format_date.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:fork_mate/view/customer/widget/back_appbar.dart';
import 'package:fork_mate/view/customer/widget/gradient_tape.dart';

class MothArchivePage extends StatelessWidget {
  const MothArchivePage({
    super.key,
    required this.monthArchive,
    required this.month,
  });
  final String month;

  final List monthArchive;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(title: 'Archive'),
      body: Column(
        children: [
          GradientTape(text: month, tapeWidth: SizeConfig.height * 0.04),
          SizedBox(height: SizeConfig.sidePadding * 2),
          Wrap(
            direction: Axis.horizontal,
            runSpacing: SizeConfig.sidePadding,
            spacing: SizeConfig.sidePadding,
            children: [
              ...monthArchive.map((monthArchive) {
                return Container(
                  padding: EdgeInsets.all(SizeConfig.sidePadding),
                  width: SizeConfig.width / 2.2,
                  decoration: boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.numbers,
                            color: elegantYellow,
                            size: SizeConfig.fontMedium,
                          ),
                          SizedBox(width: SizeConfig.sidePadding / 2),
                          Text(monthArchive['orderNumber'].toString()),
                        ],
                      ),
                      SizedBox(height: SizeConfig.sidePadding / 2),
                      SizedBox(height: SizeConfig.sidePadding),
                      Text(
                        formatDate(monthArchive['created_at']),
                        style: TextStyle(fontSize: SizeConfig.fontXXSmall),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
