import 'package:flutter/material.dart';

class Sized24Container extends StatelessWidget {
  final Widget? child;
  final Decoration? decoration;

  Sized24Container({this.child, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }
}