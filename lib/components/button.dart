import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onClick;

  const Button({
    super.key,
    this.child,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        child: child,
        onTap: onClick,
      ),
    );
  }
}
