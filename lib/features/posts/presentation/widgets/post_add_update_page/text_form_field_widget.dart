import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final int linesNumber;
  const TextFormFieldWidget({
    super.key,
    required this.name,
    required this.controller,
    this.linesNumber = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be empty!" : null,
        decoration: InputDecoration(hintText: name),
        maxLines: linesNumber,
        minLines: linesNumber,
      ),
    );
  }
}
