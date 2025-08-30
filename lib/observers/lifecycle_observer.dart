
import 'package:flutter/cupertino.dart';

class LifecycleObserver with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.paused) {
      debugPrint('The app is paused');
    }
    if(state == AppLifecycleState.resumed) {
      debugPrint('The app is resumed');
    }
  }
}