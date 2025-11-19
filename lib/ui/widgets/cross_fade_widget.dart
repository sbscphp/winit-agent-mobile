import 'package:flutter/material.dart';



class CrossFadeWidget extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final ValueNotifier<bool> switchNotifier;
  const CrossFadeWidget({super.key, required this.firstChild, required this.secondChild, required this.switchNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: switchNotifier,
      builder: (_, value, __) {
        return AnimatedCrossFade(
          firstChild: firstChild,
          secondChild: secondChild,
          crossFadeState:
          value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 350),
        );
      },
    );
  }
}


