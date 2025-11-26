import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/bank.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class BanksVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of banks
  List<Bank> _banks = [];
  List<Bank> get banks => _banks;

  //list of filtered banks
  List<Bank> _filteredBanks = [];
  List<Bank> get filteredBanks => _filteredBanks;

  //selected bank
  Bank? _selectedBank;
  Bank? get selectedBank => _selectedBank;
  set selectedBank(Bank? val){
    _selectedBank = val;
    notifyListeners();
  }

  List<String> get bankNames => _banks.map((bank) => bank.name ?? '').toList();


  //fetch banks
  fetchBanks() async {
    setState(ViewState.busy);
    await _utilityDp.fetchBanks().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _banks = response.data ?? [];
      _filteredBanks = List.of(_banks);
      print('bank length::::${_banks.length}>>>>');
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


  //resets the filter list to default
  defaultFilterList() {
    _filteredBanks = _banks;
    notifyListeners();
  }

  //filters filterable bank list
  filterList({required String searchWord}) {
    _filteredBanks = _banks
        .where((bank) =>
    (bank.name ?? '').toLowerCase().contains(searchWord.toLowerCase()))
        .toList();
    notifyListeners();
  }





}

final banksViewModel = ChangeNotifierProvider.autoDispose<BanksVm>((ref){
  return BanksVm();
});