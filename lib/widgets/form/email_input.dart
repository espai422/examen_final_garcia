import 'package:examen_final_garcia/widgets/form/input_widget.dart';
import 'package:flutter/material.dart';

/// Widget to show the email input based on the input widget
class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required TextEditingController emailController,
  }) : _controller = emailController;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return InputWidget(
        controller: _controller, label: 'Email', iconData: Icons.email);
  }
}
