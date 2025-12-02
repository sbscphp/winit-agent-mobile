
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utilities/utilities.dart';
import '../../models/user.dart';
import '../../states/base_state.dart';


class CheckoutVm extends BaseState{

  //game data provider
  //final GameDataProvider _gameDp = locator<GameDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //new customer details
  User? _newCustomer;

  initCustomerData({
    required String firstname,
    required String lastname,
    required String dob,
    required String phone,
    required String email
}){

    _newCustomer = User(
      firstname: firstname,
      lastname: lastname,
      dateOfBirth: dob,
      phoneNumber: Utilities.cleanPhoneNumber(phoneNumber: phone),
      email: email
    );

  }



}

final checkoutViewModel = ChangeNotifierProvider<CheckoutVm>((ref){
  return CheckoutVm();
});