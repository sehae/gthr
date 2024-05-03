import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController _scrollController = ScrollController();

  CustomScrollbar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: false,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: child,
      ),
    );
  }
}