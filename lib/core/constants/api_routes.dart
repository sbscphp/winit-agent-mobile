import 'app_constants.dart';
import 'env/env.dart';

class ApiRoutes {
  // --- Onboarding ---
  static String register = "${Env.auth}/signup";

  static String getNinValidity = "${Env.agent}/onboarding/nin-identity-verify";

  static String bvnVerification = "${Env.agent}/onboarding/bvn-basic-verify";

  static String completeOnboarding = "${Env.agent}/onboarding/complete-account";

  static String setTransactionPin = "${Env.agent}/onboarding/set-transaction-pin";

  // --- Auth ---
  static String sendRegistrationOtp = "${Env.auth}/send-otp-registration";
  static String resendRegistrationOtp = "${Env.auth}/resend-otp-registration";
  static String verifyRegistrationOtp = "${Env.auth}/verify-otp-registration";

  static String sendForgotPinOtp = "${Env.agent}/settings/forgot-transaction-pin/send-otp";
  static String resendForgotPinOtp = "${Env.agent}/settings/forgot-transaction-pin/resend-otp";
  static String verifyForgotPinOtp = "${Env.agent}/settings/forgot-transaction-pin/verify-otp";

  static String sendForgotPasswordOtp = "${Env.auth}/forgot-password/send-code";
  static String resendForgotPasswordOtp = "${Env.auth}/forgot-password/resend-code";

  static String verifyForgotPasswordOtp({required String? userId}) =>
      "${Env.auth}/forgot-password/confirm-code/$userId";

  static String sendCreateCustomerOtp = "${Env.agent}/customer/send-otp-phone";
  static String verifyCreateCustomerOtp = "${Env.agent}/customer/confirm-otp-phone";

  static String login = "${Env.auth}/login";

  static String createPassword({required String? userId}) =>
      "${Env.auth}/forgot-password/create-password/$userId";

  static String logout = "${Env.agent}/logout";

  // --- Home/Dashboard ---
  static String fetchDashboardStats = "${Env.agent}/dashboard/sales-stats";

  // --- Profile/Settings ---
  static String updateAvatar = "${Env.agent}/settings/update-avatar";
  static String updatePersonalInformation = "${Env.agent}/onboarding/update-personal-details";
  static String updateBusinessInformation = "${Env.agent}/onboarding/update-business-details";

  static String addAccountDetails({required String? filterParams}) =>
      "${Env.agent}/account/resolve-bank-account?$filterParams";

  static String deleteAccountDetails({required String? id, bool fromOnboarding = false}) =>
      fromOnboarding
          ? "${Env.agent}/onboarding/delete-bank-account/$id"
          : "${Env.agent}/account/bank-account/$id";

  static String validateTransactionPin = "${Env.agent}/settings/validate-transaction-pin";
  static String updateTransactionPin = "${Env.agent}/settings/update-transaction-pin";
  static String resetTransactionPin = "${Env.agent}/settings/forgot-transaction-pin/update-pin";

  // --- Account Closure/Deletion ---
  static String checkClosureStatus = "${Env.agent}/settings/closure/account/closure-status";
  static String closeAccount = "${Env.agent}/settings/closure/account/close";
  static String deleteAccount = "${Env.agent}/settings/delete-account";
  static String updatePassword = "${Env.agent}/settings/update-password";

  // --- Game ---
  static String fetchGames({required int? pageNumber, String? filterParams}) =>
      filterParams == null
          ? "${Env.agent}/game/all-games?limit=$paginationLimit&paginate=1&page=$pageNumber"
          : "${Env.agent}/game/all-games?limit=$paginationLimit&paginate=1&page=$pageNumber&$filterParams";

  static String createCustomer = "${Env.agent}/customer/create";

  static String searchCustomers({required String? phone}) =>
      "${Env.agent}/customer/search?phone=$phone";

  // --- Payment ---
  static String fetchPaymentSummary = "${Env.agent}/game/summary";
  static String purchaseFromAccount = "${Env.agent}/game/purchase-with-account";
  static String initiatePayStackCheckout = "${Env.agent}/game/purchase-with-checkout";

  static String fetchTicketDetails({required String? id}) =>
      "${Env.agent}/game/order/$id/tickets";

  // --- Referral ---
  static String fetchReferralHistory({required int? pageNumber}) =>
      "${Env.agent}/referral/referred-users?limit=$paginationLimit&paginate=1&page=$pageNumber";

  // --- Notification ---
  static String fetchNotifications({required int? pageNumber, String? filterParams}) =>
      filterParams == null
          ? "${Env.agent}/notification?page=$pageNumber&limit=$paginationLimit&paginate=1"
          : "${Env.agent}/notification?page=$pageNumber&limit=$paginationLimit&paginate=1&$filterParams";

  static String fetchNotificationSettings = "${Env.agent}/settings/notification/fetch";
  static String updateNotificationSettings = "${Env.agent}/settings/notification/update";

  static String markNotificationAsRead({required String? id}) =>
      "${Env.customer}/notifications/$id/read";

  // --- Wallet ---
  static String fetchWalletSummary = "${Env.agent}/account/system-generated-account-details";

  static String fetchWalletTransactions({required int? pageNumber, String? filterParams, bool paginate = true}) =>
      filterParams == null
          ? "${Env.agent}/account/all-transactions?page=$pageNumber&limit=$paginationLimit&paginate=${paginate ? "1":"0"}"
          : "${Env.agent}/account/all-transactions?page=$pageNumber&limit=$paginationLimit&paginate=${paginate ? "1":"0"}&$filterParams";

  static String withdraw = "${Env.agent}/account/withdraw";

  // --- Utility ---
  static String fetchLgaDetails = "${Env.guest}/lagos-lgas";
  static String fetchServiceAgents = "${Env.agent}/others/agent-service-providers";
  static String fetchBanks = "${Env.agent}/account/list-banks";
  static String fetchTerms = "${Env.agent}/others/terms-and-conditions";

  static String fetchHearAboutUs = "${Env.guest}/hear_about_us";
  static String fetchConfig = "${Env.guest}/get-all-configurations";
  static String fetchPaymentMethods = "${Env.guest}/payment-methods";
}






// import 'package:flutter_dotenv/flutter_dotenv.dart';
//
// import 'app_constants.dart';
//
// class ApiRoutes {
//
//   //onboarding
//   static var register =
//       "${dotenv.env['AUTH']}/signup";
//   static var getNinValidity =
//       "${dotenv.env['AGENT']}/onboarding/nin-identity-verify";
//   // static var bvnVerification =
//   //     "${dotenv.env['AGENT']}/onboarding/bvn-verify";
//   static var bvnVerification =
//       "${dotenv.env['AGENT']}/onboarding/bvn-basic-verify";
//   static var completeOnboarding =
//       "${dotenv.env['AGENT']}/onboarding/complete-account";
//   static var setTransactionPin =
//       "${dotenv.env['AGENT']}/onboarding/set-transaction-pin";
//
//
//
//   //auth
//   static var sendRegistrationOtp =
//       "${dotenv.env['AUTH']}/send-otp-registration";
//   static var resendRegistrationOtp =
//       "${dotenv.env['AUTH']}/resend-otp-registration";
//   static var verifyRegistrationOtp =
//       "${dotenv.env['AUTH']}/verify-otp-registration";
//   static var sendForgotPinOtp =
//       "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/send-otp";
//   static var resendForgotPinOtp =
//       "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/resend-otp";
//   static var verifyForgotPinOtp =
//       "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/verify-otp";
//   static var sendForgotPasswordOtp =
//       "${dotenv.env['AUTH']}/forgot-password/send-code";
//   static var resendForgotPasswordOtp =
//       "${dotenv.env['AUTH']}/forgot-password/resend-code";
//   static verifyForgotPasswordOtp({required String? userId}) =>
//       "${dotenv.env['AUTH']}/forgot-password/confirm-code/$userId";
//   static var sendCreateCustomerOtp =
//       "${dotenv.env['AGENT']}/customer/send-otp-phone";
//   static var verifyCreateCustomerOtp =
//       "${dotenv.env['AGENT']}/customer/confirm-otp-phone";
//   static var login =
//       "${dotenv.env['AUTH']}/login";
//   static createPassword({required String? userId}) =>
//       "${dotenv.env['AUTH']}/forgot-password/create-password/$userId";
//   static var logout =
//       "${dotenv.env['AGENT']}/logout";
//
//
//   //home/dashboard
//   static var fetchDashboardStats =
//       "${dotenv.env['AGENT']}/dashboard/sales-stats";
//
//
//
//   //profile/settings
//   static var updateAvatar =
//       "${dotenv.env['AGENT']}/settings/update-avatar";
//   static var updatePersonalInformation =
//       "${dotenv.env['AGENT']}/onboarding/update-personal-details";
//   static var updateBusinessInformation =
//       "${dotenv.env['AGENT']}/onboarding/update-business-details";
//   static addAccountDetails({required String? filterParams}) =>
//       "${dotenv.env['AGENT']}/account/resolve-bank-account?$filterParams";
//   static deleteAccountDetails({required String? id, bool fromOnboarding = false}) =>
//       fromOnboarding ? "${dotenv.env['AGENT']}/onboarding/delete-bank-account/$id": "${dotenv.env['AGENT']}/account/bank-account/$id";
//   static var validateTransactionPin =
//       "${dotenv.env['AGENT']}/settings/validate-transaction-pin";
//   static var updateTransactionPin =
//       "${dotenv.env['AGENT']}/settings/update-transaction-pin";
//   static var resetTransactionPin =
//       "${dotenv.env['AGENT']}/settings/forgot-transaction-pin/update-pin";
//
//   //account closure/deletion
//   static var checkClosureStatus =
//       "${dotenv.env['AGENT']}/settings/closure/account/closure-status";
//   static var closeAccount =
//       "${dotenv.env['AGENT']}/settings/closure/account/close";
//   static var deleteAccount =
//       "${dotenv.env['AGENT']}/settings/delete-account";
//   static var updatePassword =
//       "${dotenv.env['AGENT']}/settings/update-password";
//
//
//
//   //Game
//   static fetchGames({required int? pageNumber, String? filterParams}) =>
//       filterParams == null
//           ?"${dotenv.env['AGENT']}/game/all-games?limit=$paginationLimit&paginate=1&page=$pageNumber"
//           :"${dotenv.env['AGENT']}/game/all-games?limit=$paginationLimit&paginate=1&page=$pageNumber&$filterParams";
//   static var createCustomer =
//       "${dotenv.env['AGENT']}/customer/create";
//   static searchCustomers({required String? phone}) =>
//       "${dotenv.env['AGENT']}/customer/search?phone=$phone";
//   //payment
//   static var fetchPaymentSummary =
//       "${dotenv.env['AGENT']}/game/summary";
//   static var purchaseFromAccount =
//       "${dotenv.env['AGENT']}/game/purchase-with-account";
//   static var initiatePayStackCheckout =
//       "${dotenv.env['AGENT']}/game/purchase-with-checkout";
//   static fetchTicketDetails({required String? id}) =>
//       "${dotenv.env['AGENT']}/game/order/$id/tickets";
//
//
//
//
//
//
//
//
//   //referral
//   static fetchReferralHistory({required int? pageNumber}) =>
//       "${dotenv.env['AGENT']}/referral/referred-users?limit=$paginationLimit&paginate=1&page=$pageNumber";
//
//   //notification
//   static fetchNotifications({required int? pageNumber, String? filterParams}) =>
//       filterParams == null ? "${dotenv.env['AGENT']}/notification?page=$pageNumber&limit=$paginationLimit&paginate=1"
//           :"${dotenv.env['AGENT']}/notification?page=$pageNumber&limit=$paginationLimit&paginate=1&$filterParams";
//   static var fetchNotificationSettings =
//       "${dotenv.env['AGENT']}/settings/notification/fetch";
//   static var updateNotificationSettings =
//       "${dotenv.env['AGENT']}/settings/notification/update";
//   static markNotificationAsRead({required String? id}) =>
//       "${dotenv.env['CUSTOMER']}/notifications/$id/read";
//
//   //wallet
//   static var fetchWalletSummary =
//       "${dotenv.env['AGENT']}/account/system-generated-account-details";
//   static fetchWalletTransactions({required int? pageNumber, String? filterParams, bool paginate = true}) =>
//       filterParams == null ? "${dotenv.env['AGENT']}/account/all-transactions?page=$pageNumber&limit=$paginationLimit&paginate=${paginate ? "1":"0"}"
//                           :"${dotenv.env['AGENT']}/account/all-transactions?page=$pageNumber&limit=$paginationLimit&paginate=${paginate ? "1":"0"}&$filterParams";
//   static var withdraw =
//       "${dotenv.env['AGENT']}/account/withdraw";
//
//
//
//   //utility
//   static var fetchLgaDetails =
//       "${dotenv.env['GUEST']}/lagos-lgas";
//   static var fetchServiceAgents =
//       "${dotenv.env['AGENT']}/others/agent-service-providers";
//   static var fetchBanks =
//       "${dotenv.env['AGENT']}/account/list-banks";
//   static var fetchTerms =
//       "${dotenv.env['AGENT']}/others/terms-and-conditions";
//
//
//
//
//
//   static var fetchHearAboutUs =
//       "${dotenv.env['GUEST']}/hear_about_us";
//   static var fetchConfig =
//       "${dotenv.env['GUEST']}/get-all-configurations";
//   static var fetchPaymentMethods =
//       "${dotenv.env['GUEST']}/payment-methods";
//
// }
