import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/models/sales_stat.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../enum/view_state.dart';


class SalesStatVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //sales stat
  SalesStat? salesStat;


  //fetch sales stat
  fetchSalesStat() async {

    setState(ViewState.busy);

    await _profileDp
        .fetchSalesStat()
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      salesStat = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }







}

final salesStatViewModel = ChangeNotifierProvider<SalesStatVm>((ref){
  return SalesStatVm();
});