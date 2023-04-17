import 'package:flutter/material.dart';

class AddSubject extends StatelessWidget {
  const AddSubject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Subject"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
