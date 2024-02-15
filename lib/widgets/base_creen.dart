import 'package:examen_final_garcia/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Base screen for the app, it has a drawer and an app bar can be usefull
/// when building a new screen to save some time
class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  const BaseScreen({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: child,
    );
  }
}
