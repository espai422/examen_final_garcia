import 'package:flutter/material.dart';

/// Widget to show the password input
class PasswordInput extends StatelessWidget {
  PasswordInput({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Introdueix la teva contrasenya';
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: 'password',
          hintText: 'password',
          border: OutlineInputBorder()),
    );
  }
}
