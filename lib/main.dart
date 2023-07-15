import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/view.dart';
import 'models/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: '/',
        theme: theme(),
      ),
    );
  }
}
