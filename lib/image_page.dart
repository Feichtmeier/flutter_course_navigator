import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    this.child,
    this.title,
  });

  final Widget? child;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Center(
        child: child,
      ),
    );
  }
}
