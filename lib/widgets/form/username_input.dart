import 'package:examen_final_garcia/widgets/form/input_widget.dart';
import 'package:flutter/material.dart';

/// Widget to show the username input based on the input widget
class UserNameInput extends StatelessWidget {
  const UserNameInput({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return InputWidget(
        controller: _controller, label: 'Username', iconData: Icons.person);
  }
}
