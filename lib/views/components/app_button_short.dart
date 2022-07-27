import 'package:flutter/material.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';

class AppButtonShort extends StatelessWidget {
  const AppButtonShort(
      {Key? key, required this.child, required this.onPressed, this.color})
      : super(key: key);
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color ?? const Color(0xff16a085),
          minimumSize: Size(context.screenSize.width * 1.3 / 3, 50),
          shape: const StadiumBorder()),
      onPressed: onPressed,
      child: child,
    );
  }
}
