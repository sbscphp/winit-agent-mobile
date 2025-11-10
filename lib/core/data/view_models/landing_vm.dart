import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_asset.dart';


class LandingVm extends ChangeNotifier{

  //scroll controller
  final SwiperController _swiperController = SwiperController();
  SwiperController get swiperController => _swiperController;

  //index for swiper
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  final List<String> _images = [

  ];
  List<String> get images => _images;

  final List<String> _titles = [
    "Sell Tickets, Grow Your Earnings 🤑",
    "Earn More with Every Win 🎁",
    "Refer and Get Rewarded 🎉",
  ];
  List<String> get titles => _titles;

  final List<String> _subtitles = [
    "Easily sell tickets to customers right from the app and expand your income opportunities with every sale.",
    "Enjoy instant commissions not only when you sell tickets but also when your customers win prizes — including the grand prize!",
    "Enjoy instant commissions not only when you sell tickets but also when your customers win prizes — including the grand prize!",
  ];
  List<String> get subtitles => _subtitles;




  moveToNext(){
    _swiperController.move(_currentIndex + 1);
    notifyListeners();
  }

  moveToEnd(){
    _swiperController.move(2);
    notifyListeners();
  }

  moveToPrevious(){
    _swiperController.move(_currentIndex - 1);
    notifyListeners();
  }

  updateIndex(index){
    _currentIndex = index;
    notifyListeners();
  }



}

final landingViewModel = ChangeNotifierProvider.autoDispose<LandingVm>((ref){
  return LandingVm();
});