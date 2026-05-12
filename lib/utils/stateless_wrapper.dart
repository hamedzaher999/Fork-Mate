import 'package:flutter/material.dart';

class MyStatelessWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onDispose;
  const MyStatelessWrapper({
    super.key,
    required this.child,
    required this.onDispose,
  });

  @override
  State<MyStatelessWrapper> createState() => _MyStatelessWrapperState();
}

class _MyStatelessWrapperState extends State<MyStatelessWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
