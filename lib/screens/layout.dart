import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/tool_bar.dart';
import 'package:flutter_yt_app/uitls.dart';

import 'package:responsive_grid/responsive_grid.dart';

class Layout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          Utils.getBackground(),
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1720),
                child: ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      child: SizedBox(
                        height: marginTop,
                      ),
                    ),
                    ...children!,
                  ],
                ),
              ),
            ),
          ),
          toolbar ?? Toolbar(),
        ],
      ),
    );
    ;
  }
}
