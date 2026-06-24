import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../locator.dart';
import '../../constants/app_constants.dart';
import '../../utilities/utilities.dart';
import '../data_provider/referral_data_provider.dart';
import '../enum/view_state.dart';
import '../models/transaction.dart';
import '../states/base_state.dart';



class ReferralVm extends BaseState{

  //referral data provider
  final ReferralDataProvider _referralDp = locator<ReferralDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;




  //referral balance
  double _referralBalance = 0;
  double get referralBalance => _referralBalance;

  //last period balance
  double _lastPeriodBalance = 0;
  double get lastPeriodBalance => _lastPeriodBalance;

  //period
  String lastPeriod = '0';


  //referral history
  List<Transaction> _referralHistory = [];
  List<Transaction> get referralHistory => _referralHistory;

  bool get hasReferralBonus => _referralBalance > 0;




  //fetch referral history
  fetchReferralHistory({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _referralDp.fetchReferralHistory(
      pageNumber: pageNumber,
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.referrals?.total ?? 0;
      if(firstCall){
        //populate list
        _referralHistory = response.data?.referrals?.data ?? [];
        _referralBalance = double.tryParse(response.data?.totalBalance?.toString() ?? '0') ?? 0;
        _lastPeriodBalance = double.tryParse(response.data?.lastPeriodBalance?.toString() ?? '0') ?? 0;
        lastPeriod = response.data?.period?.toString() ?? '0';
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _referralHistory.addAll(response.data?.referrals?.data ?? []);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }

  String shareMessage({required String referralCode, required String referralLink}){
    return '''
Hey! 👋 I just signed up to WinIt – a new Raffle platform where you Play to Own a property in Lagos State.  It’s simple, exciting, and you stand a chance to win your own home.

Use my referral code $referralCode to sign up and get N500 reward after you have played your first game. 
$referralLink

WinIt - Play to own
''';
  }



}

final referralViewModel = ChangeNotifierProvider.autoDispose<ReferralVm>((ref){
  return ReferralVm();
});