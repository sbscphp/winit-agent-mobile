import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/ui/pages/games/games.dart';
import 'package:winit_agent/ui/pages/home/home.dart';
import 'package:winit_agent/ui/pages/notifications/notifications.dart';
import 'package:winit_agent/ui/pages/profile/profile.dart';
import 'package:winit_agent/ui/pages/wallet/wallet.dart';




class BottomNavViewModel extends ChangeNotifier{

  //current index of the bottom nav-bar
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  setCurrentIndex(int value, {bool refreshUi = true}){
    _currentIndex = value;
    if(refreshUi){
      notifyListeners();
    }
  }


  //children of the bottom Nav
  final List<Widget>  _children = [
    Games(), //games
    Wallet(), //my wallet
    Notifications(), //notification
    Profile(), // profile
    Home(), //home
  ];
  List<Widget> get children => _children;


  //updates the current index of the bottom nav
  updateIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

}

final bottomNavViewModel = ChangeNotifierProvider.autoDispose<BottomNavViewModel>((ref){
  return BottomNavViewModel();
});