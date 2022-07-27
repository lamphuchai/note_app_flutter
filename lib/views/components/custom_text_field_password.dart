import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatefulWidget {
  const CustomTextFieldPassword({
    Key? key,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.suffixIcon,
    this.textInputType,
    this.textEditingController,
    this.textInputAction,
  }) : super(key: key);
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextFieldPassword> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldPassword> {
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      obscureText: obscureText,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black87),
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
          filled: false,
          hintText: widget.hintText,
          errorText: widget.errorText,
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
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: () => setState(() => obscureText = !obscureText),
                  splashRadius: 20,
                  color: obscureText ? Colors.grey : Colors.black54,
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off))
              : null),
    );
  }
}
