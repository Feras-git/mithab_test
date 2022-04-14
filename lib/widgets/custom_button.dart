import 'package:flutter/material.dart';
import 'package:mithab_test/common/constants.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final Color? borderColor;
  final Color? color;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? textColor;

  CustomButton({
    required this.text,
    this.onPressed,
    this.borderColor,
    this.color,
    this.textStyle,
    this.icon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 3.h,
          horizontal: 5.w,
        ),
        backgroundColor: color ?? kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.sp),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      ),
      icon: Icon(
        icon,
        color: textColor ?? Colors.white,
      ),
      onPressed: onPressed as void Function()?,
      label: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
