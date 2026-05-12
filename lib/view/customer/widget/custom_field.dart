import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fork_mate/utils/size_config.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.title,
    this.onChanged,
    this.isNumber = false,
    this.error = false,
    this.controller,
    this.maxLength,
    this.width,
    this.suffix,
    this.focusNode,
    this.response,
    this.color,
    this.onSubmitted,
    this.readOnly = false,
    this.onTap,
    this.hint,
  });
  final String? title;
  final String? hint;
  final Map<String, dynamic>? response;
  final double? width;
  final bool isNumber;
  final bool error;
  final TextEditingController? controller;
  final int? maxLength;
  final Widget? suffix;
  final FocusNode? focusNode;
  final Color? color;
  // final Function(String? name)? onChanged;
  final VoidCallback? onSubmitted;
  final VoidCallback? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: EdgeInsetsDirectional.only(start: SizeConfig.sidePadding),
            child: Text(
              title!.tr,
              style: TextStyle(fontSize: SizeConfig.fontXSmall),
            ),
          ),
          SizedBox(height: SizeConfig.sidePadding / 2),
        ],
        SizedBox(
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  height: SizeConfig.height * 0.045,
                  decoration: BoxDecoration(
                    border: error ? Border.all(color: Colors.red) : null,
                    color: color ?? const Color.fromARGB(44, 158, 158, 158),
                    borderRadius: BorderRadius.circular(
                      SizeConfig.radius / 1.3,
                    ),
                  ),
                  child: TextFormField(
                    readOnly: readOnly,
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: isNumber ? TextInputType.number : null,
                    inputFormatters: [
                      if (isNumber) FilteringTextInputFormatter.digitsOnly,
                      if (maxLength != null)
                        LengthLimitingTextInputFormatter(maxLength),
                    ],
                    style: TextStyle(fontSize: SizeConfig.fontXSmall),

                    decoration: InputDecoration(
                      hintText: hint?.tr,
                      contentPadding: EdgeInsetsDirectional.only(
                        start: SizeConfig.sidePadding,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    onChanged: (_) {
                      onChanged?.call();
                    },
                    onFieldSubmitted: (_) {
                      onSubmitted?.call();
                    },
                    onTap: () {
                      onTap?.call();
                    },
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.sidePadding,
                  ),
                  child: suffix!,
                ),
            ],
          ),
        ),
        if (response != null) ...[
          SizedBox(height: SizeConfig.sidePadding / 3),
          Padding(
            padding: EdgeInsetsDirectional.only(start: SizeConfig.sidePadding),
            child: Text(
              response?['message'] ?? '',
              style: TextStyle(
                color: response?['status'] == "success"
                    ? Colors.green
                    : Colors.red,
                fontSize: SizeConfig.fontXXSmall,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
