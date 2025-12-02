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
  
  //values
  double get totalSales => double.tryParse(salesStat?.totalSales?.toString() ?? '0') ?? 0;
  double get amountAdded => double.tryParse(salesStat?.ticketsLastPeriodSoldValue?.toString() ?? '0') ?? 0;
  String get period => salesStat?.period?.toString() ?? '0';
  double get totalTicketSold => double.tryParse(salesStat?.totalTicketsSoldQuantity?.toString() ?? '0') ?? 0;
  double get bonusBalance => double.tryParse(salesStat?.bonusValue?.toString() ?? '0') ?? 0;
  double get commissionsBalance => double.tryParse(salesStat?.commissionsValue?.toString() ?? '0') ?? 0;
  double get ticketsSoldToday => double.tryParse(salesStat?.rankValue?.toString() ?? '0') ?? 0;
  int get position => int.tryParse(salesStat?.rankPosition?.toString() ?? '1') ?? 1;



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