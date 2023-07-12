import 'package:flutter/material.dart';
import 'package:notes_test/widgets/app_bar_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        title: Text('Settings'),
        // leading: true,
      ),
    );
  }
}
