import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/models/service_agent.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class ServiceAgentsVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<ServiceAgent> _posAgents = [];
  List<ServiceAgent> get posAgents => _posAgents;

  List<ServiceAgent> _financialAgents = [];
  List<ServiceAgent> get financialAgents => _financialAgents;


  List<String> get posAgentsNames => _posAgents.map((posAgent) => posAgent.name ?? '').toList();
  List<String> get financialAgentsNames => _financialAgents.map((financialAgent) => financialAgent.name ?? '').toList();


  //fetch service agents
  fetchServiceAgents() async {
    setState(ViewState.busy);
    await _utilityDp.fetchAgentProviders().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _posAgents = response.data?.posAgent ?? [];
      _financialAgents = response.data?.financialAgent ?? [];
      print('pos:::${_posAgents.length} .....  financial:${_financialAgents.length}>>>');
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


}

final serviceAgentsViewModel = ChangeNotifierProvider<ServiceAgentsVm>((ref){
  return ServiceAgentsVm();
});