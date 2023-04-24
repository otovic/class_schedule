import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  final String placeholderText;
  final TextEditingController controller;
  final int maxLines;
  const InputDialog(
      {this.maxLines = 1,
      required this.placeholderText,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.start,
            maxLines: maxLines,
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
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
