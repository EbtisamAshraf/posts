import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, this.controller, required this.hint, this.maxLines = 1}) : super(key: key);
  final TextEditingController? controller;
  final String hint;
 final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? "$hint can`t be empty " : null,
    );
  }
}
