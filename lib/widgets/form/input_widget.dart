import 'package:flutter/material.dart';

/// An abstraction of the input widget to be used in the forms
/// it receives the controller, the label and the icon to be used
class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required TextEditingController controller,
    required String label,
    required IconData iconData,
  })  : _controller = controller,
        _label = label,
        _iconData = iconData;

  final TextEditingController _controller;
  final String _label;
  final IconData _iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Introdueix el teu $_label';
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(_iconData),
          labelText: _label,
          hintText: _label,
          border: OutlineInputBorder()),
    );
  }
}
