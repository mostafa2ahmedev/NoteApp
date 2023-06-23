import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.type,
      this.validator,
      this.ispassword = false,
      required this.text,
      required this.prefixIcon,
      @required this.ontap,
      required this.controller});
  final TextInputType type;
  final bool ispassword;
  final String? Function(String?)? validator;
  final String text;
  final IconData prefixIcon;
  final VoidCallback? ontap;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: ontap,
      keyboardType: type,
      obscureText: ispassword,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: border(),
        focusedBorder: border(),
        hintText: text,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
  }
}
