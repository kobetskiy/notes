import 'package:flutter/material.dart';
import '../config/view.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    this.width = 150,
    this.height = 200,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}
