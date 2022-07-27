import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.suffixIcon,
    this.textInputType,
    this.obscureText = false,
    this.textEditingController,
    this.textInputAction,
  }) : super(key: key);
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      obscureText: obscureText,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black87),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: false,
        hintText: hintText,
        errorText: errorText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey),
        contentPadding: const EdgeInsets.all(18),
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xff34495e), width: 2)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red, width: 2)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
    );
  }
}
