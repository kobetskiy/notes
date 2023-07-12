import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.action,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      title: widget.title,
      titleTextStyle: Theme.of(context).textTheme.displaySmall,
      actions: widget.action
    );
  }
}
