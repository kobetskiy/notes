import 'package:flutter/material.dart';

import '../config/colors.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final void Function(String)? onChanged;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

outlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: color),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: Icon(widget.icon, color: Theme.of(context).iconTheme.color),
        suffixIcon: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: Theme.of(context).iconTheme.color,
          icon: const Icon(Icons.clear),
          onPressed: () => widget.controller.clear(),
        ),
        focusedBorder: outlineInputBorder(textAndIconColor),
        border: outlineInputBorder(textAndIconColor),
      ),
    );
  }
}
