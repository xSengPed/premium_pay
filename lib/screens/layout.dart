import 'package:flutter/material.dart';

import 'package:flutter_yt_app/components/tool_bar.dart';
import 'package:flutter_yt_app/uitls.dart';

import 'package:responsive_grid/responsive_grid.dart';

class Layout extends StatefulWidget {
  final List<ResponsiveGridCol>? children;
  final Widget? floatingActionButton;
  final double marginTop;
  final Widget? toolbar;
  const Layout(
      {super.key,
      this.children,
      this.floatingActionButton,
      this.marginTop = 75.0,
      this.toolbar});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      body: Stack(
        children: [
          Utils.getBackground(),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(maxWidth: 1720),
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    child: SizedBox(
                      height: widget.marginTop,
                    ),
                  ),
                  ...widget.children!,
                ],
              ),
            ),
          ),
          widget.toolbar ?? Toolbar(),
        ],
      ),
    );
    ;
  }
}
