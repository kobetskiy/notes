import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;

  const FloatingActionButtonWidget({
    super.key,
    this.radius = 40,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF4B7BFF), Color(0xFF46D9FF)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Center(
          child: Center(
            child: Icon(
              Icons.add,
              size: Theme.of(context).iconTheme.copyWith(size: 34).size,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
