import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/lga_details.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class LgaDetailsVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<LgaDetails> _lgas = [];
  List<LgaDetails> get lgas => _lgas;

  List<String> areas = [];
  List<String> get lgaNames => _lgas.map((lga) => lga.lga ?? '').toList();


  //fetch lga details
  fetchLgaDetails() async {
    setState(ViewState.busy);
    await _utilityDp.fetchLgaDetails().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _lgas = response.data ?? [];
      //print('length::::${_lgas.length}>>>>');
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


  populateAreas({required String selectedLga, bool refreshUi = true}){
    try{
      areas = _lgas.firstWhere((lga) => lga.lga?.toLowerCase() == selectedLga.toLowerCase()).wards ?? [];
    }catch(e){
      areas = [];
    }
    if(refreshUi)notifyListeners();
  }


}

final lgaDetailsViewModel = ChangeNotifierProvider<LgaDetailsVm>((ref){
  return LgaDetailsVm();
});