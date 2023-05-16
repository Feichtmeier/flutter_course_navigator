import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    this.child,
    this.title,
    this.url,
  });

  final Widget? child;
  final Widget? title;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Center(
        child: Column(
          children: [if (child != null) child!, if (url != null) Text(url!)],
        ),
      ),
    );
  }
}
