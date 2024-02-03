import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Utils {
  static void handleKeyEventGeneric(
    RawKeyEvent event,
    ScrollController scrollController, {
    double scrollArrowAmount = 70.0,
    double scrollPageAmount = 140.0,
    Duration scrollDuration = const Duration(milliseconds: 100),
    Curve scrollCurve = Curves.ease,
  }) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        scrollController.animateTo(
          scrollController.offset + scrollArrowAmount,
          duration: scrollDuration,
          curve: scrollCurve,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        scrollController.animateTo(
          scrollController.offset - scrollArrowAmount,
          duration: scrollDuration,
          curve: scrollCurve,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
        scrollController.animateTo(
          scrollController.offset + scrollPageAmount,
          duration: scrollDuration,
          curve: scrollCurve,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
        scrollController.animateTo(
          scrollController.offset - scrollPageAmount,
          duration: scrollDuration,
          curve: scrollCurve,
        );
      }
    }
  }
}
