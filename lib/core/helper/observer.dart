import 'package:flutter/material.dart';

class AppNavigatorObserver {
  static final AppNavigatorObserver instance = AppNavigatorObserver._internal();

  AppNavigatorObserver._internal();

  final RouteObserver<PageRoute<dynamic>> _routeObserver = RouteObserver<PageRoute<dynamic>>();

  RouteObserver<PageRoute<dynamic>> get routeObserver => _routeObserver;

  void subscribe(RouteAware routeAware, ModalRoute<dynamic> route) {
    _routeObserver.subscribe(routeAware, route as PageRoute<dynamic>);
  }

  void unsubscribe(RouteAware routeAware) {
    _routeObserver.unsubscribe(routeAware);
  }
}
