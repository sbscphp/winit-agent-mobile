

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class InactivityListenerViewModel extends ChangeNotifier{

  Timer? _timer;

  Duration? _timeDuration;
  Duration? get timeDuration => _timeDuration;
  set timeDuration(dynamic val){
    _timeDuration = val;
  }

  bool _userLoggedIn = false;
  bool get userLoggedIn => _userLoggedIn;
  set userLoggedIn(dynamic val){
    _userLoggedIn = val;
    if(_userLoggedIn) {
      onActivity();
    }
  }

  void startTimer() {
    if(_timer != null){
      _timer?.cancel();
    }
    _timer = Timer(_timeDuration!, _onIdle);
  }

  void _onIdle() async{
    debugPrint('time up::::log out!!!!!');
    /// Log out the user here
    // NavigationService navigationService = locator<NavigationService>();
    // navigationService.clearAllRoutes(
    //   routeName: NamedRoutes.login,
    // );
    ///toggle user logged in flag
    _userLoggedIn = false;
  }

  void onActivity() {
    if(_userLoggedIn){
      startTimer();
    }else{
      if(_timer != null) {
        _timer?.cancel();
      }
    }

  }

  void _onDragUpdate(DragUpdateDetails details) {
    startTimer();
  }

  resetValues(){
    _userLoggedIn = false;
    _timer = null;
  }


}

final inactivityListenerViewModel = ChangeNotifierProvider<InactivityListenerViewModel>((ref){
  return InactivityListenerViewModel();
});