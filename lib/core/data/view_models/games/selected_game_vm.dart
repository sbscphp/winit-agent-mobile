import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../locator.dart';
import '../../../constants/color_path.dart';
import '../../data_provider/game_data_provider.dart';
import '../../models/draw.dart';
import '../../models/game.dart';
import '../../models/remaining_time.dart';
import '../../models/sponsor.dart';
import '../../models/ticket.dart';
import '../../models/tier.dart';
import '../../states/base_state.dart';


class SelectedGameVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //game
  Game? game;

  //selected ticket
  Ticket? selectedTicket;

  //game end date
  DateTime? _gameEndDate;
  DateTime get gameEndDate => _gameEndDate ?? DateTime.now();

  //total price
  double _amount = 0;
  double get amount => _amount;

  //quantity
  int _quantity = 1;
  int get quantity => _quantity;
  set quantity(int val){
    _quantity = val;
  }



  bool _mainDrawEnded = false;
  bool get mainDrawEnded => _mainDrawEnded;
  set mainDrawEnded(bool val){
    _mainDrawEnded = val;
    notifyListeners();
  }

  String get name => game?.categoryName ?? 'N/A';
  String get gameId => game?.uuid ?? '';
  bool get hasEarlyBirdDraw => game?.prizes?.earlyDraw != null;
  Draw get mainDraw => game?.prizes?.mainDraw ?? Draw();
  Draw get earlyBirdDraw => game?.prizes?.earlyDraw ?? Draw();
  String get mainDrawOverview => mainDraw.overview ?? 'N/A';
  String get earlyBirdDrawOverview => earlyBirdDraw.overview ?? 'N/A';
  String get mainDrawOtherDetails => mainDraw.otherDetails ?? 'N/A';
  String get earlyBirdDrawOtherDetails => earlyBirdDraw.otherDetails ?? 'N/A';
  String get ctaText => game?.ctaText ?? 'Play Now';
  List<Sponsor> get gameSponsors => game?.sponsors ?? [];
  List<Ticket> get tickets => game?.tickets ?? [];
  String get discountType => game?.discount?.type ?? '';
  double get maxPurchaseAmount => double.tryParse(game?.maximumTicketAmountPurchase?.toString() ?? '0') ?? 0;
  double get ticketPrice => double.tryParse(game?.ticketPrice?.toString() ?? '0') ?? 0;
  int get maxCount => _calculateMaxCount();
  bool get usePromoCode => game?.usePromoCode?.toLowerCase() == 'true';
  bool get useReferralBonus => game?.useReferralAmount?.toLowerCase() == 'true';
  List<Tier> get bandTiers => game?.discount?.tiers ?? [];
  String get ticketTip => game?.ticketTip ?? '';
  double get discountedPrice => double.tryParse(selectedTicket?.discountPrice?.toString() ?? '0') ?? 0;


  //card color theme
  //Game Details Card
  Color get cardBgColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardPrimaryColor,
      ColorPath.lasGreen
  );
  Color get titleAndCountdownContainerColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardSecondaryColor,
      Colors.black.withAlpha((255 * 0.7).toInt())
  );
  Color get titleAndCountdownTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardSecondaryTextColor,
      Colors.white
  );
  Color get timeLeftTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardTimeLeftColor,
      ColorPath.ribbonRed
  );
  Color get prizeListTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardTextColor,
      ColorPath.stratosBlue
  );
  Color get prizeStatusTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardStatusTextColor,
      ColorPath.fetaGreen
  );
  Color get prizeStatusContainerColor => ColorPath.dynamicColor(
      game?.colorThemes?.bigGameCardStatusBackgroundColor,
      ColorPath.chillGreen
  );

  //Ticket
  Color get ticketBorderColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketOutlineColor,
      ColorPath.athensGrey2
  );
  // Color get ticketPriceAndQuantityColor => ColorPath.dynamicColor(
  //     game?.colorThemes?.gameTicketHeaderTextColor,
  //     ColorPath.stratosBlue
  // );
  Color get ticketPriceColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketPrizeTextColor,
      ColorPath.stratosBlue
  );
  Color get ticketUnitColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketUnitColor,
      ColorPath.stratosBlue
  );
  Color get ticketButtonColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketButtonBackgroundColor,
      ColorPath.stratosBlue
  );
  Color get ticketButtonTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketButtonTextColor,
      Colors.white
  );
  Color get bestValueContainerColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketTagButtonColor,
      ColorPath.turquoiseGreen
  );
  Color get bestValueTextColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketTagTextColor,
      ColorPath.stratosBlue
  );
  Color get ticketIconColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketIconColor,
      ColorPath.stratosBlue
  );
  Color get ticketBgColor => ColorPath.dynamicColor(
      game?.colorThemes?.gameTicketBackgroundColor,
      ColorPath.stratosBlue
  );



  setSelectedGame(Game val){
    game = val;
    selectedTicket = tickets.isNotEmpty ? tickets[0]:null;
    _gameEndDate = game?.endDate ?? DateTime.now();
    notifyListeners();
  }

  int _calculateMaxCount(){
    if (ticketPrice > 0 && maxPurchaseAmount > 0) {
      final division = maxPurchaseAmount / ticketPrice;
      //Check for NaN or Infinity
      if (division.isFinite && !division.isNaN) {
        return division.toInt();
      } else {
        return 100;
      }
    } else {
      return 100;
    }
  }

  initPriceAndQuantity(){
    _quantity = selectedTicket?.number ?? 1;
    _amount = double.tryParse(selectedTicket?.discountPrice?.toString() ?? '0') ?? 0;
    log('selected game:::${game?.toJson().toString()}>>>');
  }

  //calculates price based on quantity selected by user
  calculatePrice(){

    //final refTicket = tickets.firstWhere((ticket) => ticket.number == 1);
    final refTicket = tickets[0];
    double unitPrice = double.tryParse(refTicket.originalPrice?.toString() ?? '0') ?? 0;

    //check discount type
    if(discountType.toLowerCase() == 'straight_line' || discountType.isEmpty){
      double value = double.tryParse(game?.discount?.value?.toString() ?? '0') ?? 0;
      _amount = _returnNewAmount(
          value: value,
          quantity: _quantity,
           unitPrice: unitPrice
      );
    }
    else if(discountType.toLowerCase() == 'band'){
      final selectedTier = _returnSelectedTier(quantity: quantity);
      _amount = _returnNewAmount(
          value:double.tryParse(selectedTier?.value?.toString() ?? '0') ?? 0,
          quantity: _quantity,
          unitPrice: unitPrice
      );
    }

    notifyListeners();
  }

  //returns the tier whose min–max range includes the given quantity.
  Tier? _returnSelectedTier({required int quantity}) {
    for (final tier in bandTiers) {
      if (tier.min != null && tier.max != null) {
        if (quantity >= tier.min! && quantity <= tier.max!) {
          return tier;
        }
      }
    }
    return null;
  }

  //returns new amount based on discount percentage(value), quantity and unit price.
  double _returnNewAmount({required double value, required int quantity, required double unitPrice}) {

    double amount = 0;

    if(value == 0){
      //discount value is zero, return quantity selected * unit price
      amount = quantity * unitPrice;
    }else{
      final multiplier = unitPrice - ((value/100) * unitPrice);
      amount = multiplier * quantity;
    }
    return amount;
  }

  //checks when a user crosses the purchase amount threshold for a game
  bool purchaseAmountLimitExceed({required double amount}){
    return amount > maxPurchaseAmount;
  }

  //Checks if main draw has ended
  Future<bool> isMainDrawEnded()async{
    final endDate = mainDraw.endDate ?? DateTime.now();
    //final endDate = sampleEndDate ?? DateTime.now(); //todo: update later ... VERY IMPORTANT
    final diff = endDate.difference(DateTime.now());
    RemainingTime t =  diff.isNegative
        ? RemainingTime.zero
        : RemainingTime.fromDuration(diff);
    return _isZero(t);
  }

  //checks if time remains
  bool _isZero(RemainingTime t) =>
      t.days == 0 && t.hours == 0 && t.minutes == 0 && t.seconds == 0;

}

final selectedGameViewModel = ChangeNotifierProvider<SelectedGameVm>((ref){
  return SelectedGameVm();
});