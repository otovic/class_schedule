import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  final String placeholderText;
  final TextEditingController controller;
  const InputDialog(
      {required this.placeholderText, required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).backgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blueAccent),
              ),
              labelText: placeholderText,
              labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
