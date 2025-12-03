
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/date_utilitites.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/game_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/user.dart';
import '../../states/base_state.dart';


class CustomerDetailsVm extends BaseState{

  //game data provider
  final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //created user
  User? createdUser;

  //create customer
  createCustomer({
    required String firstname,
    required String lastname,
    required String dob,
    required String phone,
    required String email
})async{
    setState(ViewState.busy);
    final details = {
      "new_customer": {
        "first_name": firstname,
        "last_name": lastname,
        "phone_number": phone,
        "date_of_birth": DateUtilities.reverseDate(dob),
        "email": email,
        //"referral_code": "REF123ABC",
        //"gender": "Male",
        //"heard_from": "Friend"
      }
    };
    await _gameDp.createCustomer(details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      createdUser = response.data;
      setState(ViewState.retrieved);
    }).catchError((e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }



}

final customerDetailsViewModel = ChangeNotifierProvider<CustomerDetailsVm>((ref){
  return CustomerDetailsVm();
});