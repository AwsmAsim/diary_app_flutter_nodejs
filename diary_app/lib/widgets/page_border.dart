import 'package:flutter/material.dart';

class PageBorder extends StatelessWidget {

  Widget child;
  PageBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        child: child,
      ),
    );
  }
}
