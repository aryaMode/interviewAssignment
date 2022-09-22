import 'package:flutter/material.dart';
import 'package:internship_assignment/widgets/text_field_container.dart';

import '../constants/color_scheme.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  // final IconData icon;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;
  final Widget prefixWidget;
  const RoundedInputField({
    this.hintText,
    // this.icon = Icons.person,
    required this.onChanged,
    this.prefixWidget = const Icon(
      Icons.person,
      color: kYellow,
    ),
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        cursorColor: kYellow,
        decoration: InputDecoration(
          icon: prefixWidget,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
