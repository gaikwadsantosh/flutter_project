import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mulyankan/core/utils.dart';

class CustomScrollViewWidget extends StatefulWidget {
  const CustomScrollViewWidget({
    Key? key,
    required this.child,
    required this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.physics,
  }) : super(key: key);

  final Widget child;
  final ScrollController scrollController;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  @override
  State<CustomScrollViewWidget> createState() => _CustomScrollViewWidgetState();
}

class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _productListHandleKeyEvent(RawKeyEvent event) {
    Utils.handleKeyEventGeneric(event, widget.scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (RawKeyEvent event) {
        _productListHandleKeyEvent(event);
      },
      child: Scrollbar(
        interactive: true, // Set to true to always show the scrollbar
        controller: widget.scrollController,
        thickness: 20.0, // Adjust the thickness of the scrollbar
        child: SingleChildScrollView(
          controller: widget.scrollController,
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          padding: widget.padding,
          physics: widget.physics,
          child: widget.child,
        ),
      ),
    );
  }
}
