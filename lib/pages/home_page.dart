import 'package:flutter/material.dart';
import 'package:touchdown/ui/ApplicationToolbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: ApplicationToolbar(),
        body: Center(
          child: Column(
            children: [Text("Home Page")],
          ),
        ));
  }
}
