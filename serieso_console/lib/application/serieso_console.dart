import 'package:flutter/material.dart';
import 'package:serieso_console/application/pages/_page_dashboard.dart';

class SeriesoConsole extends StatefulWidget {
  const SeriesoConsole({super.key});

  @override
  State<SeriesoConsole> createState() => _SeriesoConsoleState();
}

class _SeriesoConsoleState extends State<SeriesoConsole> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const PageDashboard(),
    );
  }
}
