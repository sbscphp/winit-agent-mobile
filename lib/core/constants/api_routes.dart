import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_constants.dart';

class ApiRoutes {

  //onboarding
  static var register =
      "${dotenv.env['AUTH']}/signup";
  static var completeNinLivenessCheck =
      "${dotenv.env['AGENT']}/onboarding/nin-verify";
  // static var bvnVerification =
  //     "${dotenv.env['AGENT']}/onboarding/bvn-verify";
  static var bvnVerification =
      "${dotenv.env['AGENT']}/onboarding/bvn-basic-verify";
  static var completeOnboarding =
      "${dotenv.env['AGENT']}/onboarding/complete-account";
  static var setTransactionPin =
      "${dotenv.env['AGENT']}/onboarding/set-transaction-pin";



  //auth
  static var sendRegistrationOtp =
      "${dotenv.env['AUTH']}/send-otp-registration";
  static var resendRegistrationOtp =
      "${dotenv.env['AUTH']}/resend-otp-registration";
  static var verifyRegistrationOtp =
      "${dotenv.env['AUTH']}/verify-otp-registration";
  static var sendForgotPinOtp =
      "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/send-otp";
  static var resendForgotPinOtp =
      "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/resend-otp";
  static var verifyForgotPinOtp =
      "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/verify-otp";
  static var sendForgotPasswordOtp =
      "${dotenv.env['AUTH']}/forgot-password/send-code";
  static var resendForgotPasswordOtp =
      "${dotenv.env['AUTH']}/forgot-password/resend-code";
  static verifyForgotPasswordOtp({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/confirm-code/$userId";
  static var login =
      "${dotenv.env['AUTH']}/login";
  static createPassword({required String? userId}) =>
      "${dotenv.env['AUTH']}/forgot-password/create-password/$userId";


  





  //profile/settings
  static var updateAvatar =
      "${dotenv.env['AGENT']}/settings/update-avatar";
  static var updatePersonalInformation =
      "${dotenv.env['AGENT']}/onboarding/update-personal-details";
  static var updateBusinessInformation =
      "${dotenv.env['AGENT']}/onboarding/update-business-details";
  static addAccountDetails({required String? filterParams}) =>
      "${dotenv.env['AGENT']}/account/resolve-bank-account?$filterParams";
  static deleteAccountDetails({required String? id, bool fromOnboarding = false}) =>
      fromOnboarding ? "${dotenv.env['AGENT']}/onboarding/delete-bank-account/$id": "${dotenv.env['AGENT']}/account/bank-account/$id";
  static var validateTransactionPin =
      "${dotenv.env['AGENT']}/settings/validate-transaction-pin";
  static var updateTransactionPin =
      "${dotenv.env['AGENT']}/settings/update-transaction-pin";
  static var resetTransactionPin =
      "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/update-pin";




  static var fetchProfile =
      "${dotenv.env['SETTINGS']}/profile/check_profile";
  static var updateProfile =
      "${dotenv.env['SETTINGS']}/profile/update_profile";
  static var updatePassword =
      "${dotenv.env['SETTINGS']}/security/update/password";
  static var updateSpendLimit =
      "${dotenv.env['SETTINGS']}/spend_limit/update";
  static var updateSelfExclusion =
      "${dotenv.env['SETTINGS']}/self_exclusion/update";

  //Game
  static fetchGames({required int? pageNumber}) =>
      "${dotenv.env['GUEST']}/all-featured-games?page=$pageNumber";
  static fetchSingleGame({required String? gameId}) =>
      "${dotenv.env['GUEST']}/game/$gameId";
  static getTicketsByOrderId({required String? orderId}) =>
      "${dotenv.env['GAMES']}/order/$orderId/tickets";
  static fetchMyGames({required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/by_orders?page=$pageNumber";
  static fetchGameTicketStatus({required String? id, required int? pageNumber}) =>
      "${dotenv.env['GAMES']}/order/$id/ticket_status?page=$pageNumber";

  //payment
  static var fetchPaymentBreakdown =
      "${dotenv.env['GAMES']}/checkout/summary";
  static var initiateCheckout =
      "${dotenv.env['GAMES']}/checkout";




  //referral
  static fetchReferralHistory({required int? pageNumber}) =>
      "${dotenv.env['AGENT']}/referral/referred-users?limit=$paginationLimit&paginate=1&page=$pageNumber";

  //notification
  static var updateNotificationSettings =
      "${dotenv.env['NOTIFICATION']}/update";
  static fetchNotifications({required int? pageNumber}) =>
      "${dotenv.env['CUSTOMER']}/notifications?page=$pageNumber";
  static markNotificationAsRead({required String? id}) =>
      "${dotenv.env['CUSTOMER']}/notifications/$id/read";

  //wallet
  static var fetchWalletSummary =
      "${dotenv.env['AGENT']}/account/system-generated-account-details";
  static fetchWalletTransactions({required int? pageNumber, required String? id, String? filterParams}) =>
      filterParams == null ? "${dotenv.env['AGENT']}/account/bank-account/$id/transactions?page=$pageNumber&limit=$paginationLimit&paginate=1"
                          :"${dotenv.env['AGENT']}/account/bank-account/$id/transactions?page=$pageNumber&limit=$paginationLimit&paginate=1&$filterParams";



  //utility
  static var fetchLgaDetails =
      "${dotenv.env['GUEST']}/lagos-lgas";
  static var fetchServiceAgents =
      "${dotenv.env['AGENT']}/others/agent-service-providers";
  static var fetchBanks =
      "${dotenv.env['AGENT']}/account/list-banks";
  static var fetchTerms =
      "${dotenv.env['AGENT']}/others/terms-and-conditions";





  static var fetchHearAboutUs =
      "${dotenv.env['GUEST']}/hear_about_us";
  static var fetchConfig =
      "${dotenv.env['GUEST']}/get-all-configurations";
  static var fetchPaymentMethods =
      "${dotenv.env['GUEST']}/payment-methods";

}
