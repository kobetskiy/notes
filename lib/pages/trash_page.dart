import 'package:flutter/material.dart';
import 'package:notes_test/widgets/app_bar_widget.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPage();
}

class _TrashPage extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        title: Text('Trash'),
        // leading: true,
      ),
    );
  }
}
