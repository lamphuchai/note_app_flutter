import 'package:flutter/material.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';

class AppButtonLong extends StatelessWidget {
  const AppButtonLong({Key? key, required this.child, required this.onPressed})
      : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff16a085),
          minimumSize: Size(context.screenSize.width, 55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPressed,
      child: child,
    );
  }
}
