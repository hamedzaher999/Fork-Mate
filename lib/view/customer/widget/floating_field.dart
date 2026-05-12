import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fork_mate/app/colors.dart';
import 'package:fork_mate/utils/size_config.dart';

class FloatingField extends StatelessWidget {
  const FloatingField({
    super.key,
    required this.onSubmit,
    this.onChange,
    this.hint,
    this.initValue,
  });
  final void Function(String code) onSubmit;
  final void Function(String data)? onChange;
  final String? hint;
  final String? initValue;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = initValue ?? '';
    return PopScope(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),

        child: Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: SizeConfig.height * 0.07,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.sidePadding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.radius / 2,
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        onChanged: (info) {
                          onChange?.call(info);
                        },
                        onSubmitted: (code) {
                          if (code.isNotEmpty) {
                            Get.back();
                            onSubmit(code);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: hint ?? '',
                          hintStyle: TextStyle(
                            fontSize: SizeConfig.fontXSmall,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.sidePadding,
                            vertical: SizeConfig.height * 0.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.radius / 2,
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final code = controller.text.trim();
                    if (code.isNotEmpty) {
                      Get.back();
                      onSubmit(code);
                    }
                  },
                  child: Icon(Icons.send, color: elegantYellow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
