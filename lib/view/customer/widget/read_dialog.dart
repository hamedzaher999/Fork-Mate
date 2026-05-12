import 'package:flutter/material.dart';
import 'package:fork_mate/utils/size_config.dart';

class ReadDialog extends StatelessWidget {
  const ReadDialog({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text, style: TextStyle(fontSize: SizeConfig.fontMedium)),
      ),
    );
  }
}
