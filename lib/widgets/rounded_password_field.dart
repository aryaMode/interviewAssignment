import 'package:flutter/material.dart';
import 'package:internship_assignment/widgets/text_field_container.dart';

import '../constants/color_scheme.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final Function()? showPass;
  const RoundedPasswordField({
    required this.onChanged,
    this.obscureText = true,
    this.showPass,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: obscureText,
        onChanged: (onChanged),
        cursorColor: kYellow,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kYellow,
          ),
          suffixIcon: InkWell(
            onTap: showPass,
            child: Icon(
              Icons.visibility,
              color: obscureText ? Colors.grey : kYellow,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
