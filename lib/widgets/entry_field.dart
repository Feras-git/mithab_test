import 'package:flutter/material.dart';
import 'package:mithab_test/common/constants.dart';

class EntryField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? errorText;
  EntryField({
    this.controller,
    this.hintText = '',
    this.icon,
    this.onChanged,
    this.obscureText = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: kMainColor,
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: kMainColor,
        ),
        hintText: hintText,
        border: OutlineInputBorder(),
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
