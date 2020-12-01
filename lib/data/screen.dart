import 'package:flutter/material.dart';

class Screen {
  // final String title;
  final Widget child;
  final RouteFactory onGenerateRoute;
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorState;
  final ScrollController scrollController;
  // final String icon;
  Screen({
    // this.title,
    // this.icon,
    this.child,
    this.onGenerateRoute,
    this.initialRoute,
    this.navigatorState,
    this.scrollController,
  });
}
