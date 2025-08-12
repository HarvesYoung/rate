

import 'package:flutter/material.dart';

class RouteObserver extends NavigatorObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint("页面 PUSH: ${route.settings.name}");
  } // didPush() end


  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint("页面 POP: ${route.settings.name}");
  } // didPop() end

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint("页面 REPLACE: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}");
  } // didReplace() end

}