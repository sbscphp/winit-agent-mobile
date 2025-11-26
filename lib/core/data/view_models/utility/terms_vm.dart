import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/bank.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class TermsVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //terms
  String _terms = '';
  String get terms => _terms;


  //fetch terms
  fetchTerms() async {
    setState(ViewState.busy);
    await _utilityDp.fetchTerms().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _terms = response.data ?? '';
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

}

final termsViewModel = ChangeNotifierProvider.autoDispose<TermsVm>((ref){
  return TermsVm();
});