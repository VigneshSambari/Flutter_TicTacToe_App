// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  const Responsive({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          child: child),
    );
  }
}
