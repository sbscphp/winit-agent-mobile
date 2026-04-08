import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  // --- Environment Base URLs ---
  @EnviedField(varName: 'STAGING_BASE_URL')
  static final String stagingBaseUrl = _Env.stagingBaseUrl;

  @EnviedField(varName: 'QA_BASE_URL')
  static final String qaBaseUrl = _Env.qaBaseUrl;

  @EnviedField(varName: 'PROD_BASE_URL')
  static final String prodBaseUrl = _Env.prodBaseUrl;

  @EnviedField(varName: 'DEBUG_BASE_URL')
  static final String debugBaseUrl = _Env.debugBaseUrl;

  // --- Paystack Keys (Obfuscated) ---
  @EnviedField(varName: 'STAGING_PAY_STACK_KEY')
  static final String stagingPaystackKey = _Env.stagingPaystackKey;

  @EnviedField(varName: 'QA_PAY_STACK_KEY')
  static final String qaPaystackKey = _Env.qaPaystackKey;

  @EnviedField(varName: 'PROD_PAY_STACK_KEY')
  static final String prodPaystackKey = _Env.prodPaystackKey;

  @EnviedField(varName: 'DEBUG_PAY_STACK_KEY')
  static final String debugPaystackKey = _Env.debugPaystackKey;

  // --- API Routes ---
  @EnviedField(varName: 'AUTH')
  static final String auth = _Env.auth;

  @EnviedField(varName: 'UPLOAD')
  static final String upload = _Env.upload;

  @EnviedField(varName: 'GUEST')
  static final String guest = _Env.guest;

  @EnviedField(varName: 'NOTIFICATION')
  static final String notification = _Env.notification;

  @EnviedField(varName: 'SETTINGS')
  static final String settings = _Env.settings;

  @EnviedField(varName: 'REFERRAL')
  static final String referral = _Env.referral;

  @EnviedField(varName: 'GAMES')
  static final String games = _Env.games;

  @EnviedField(varName: 'CUSTOMER')
  static final String customer = _Env.customer;

  @EnviedField(varName: 'AGENT')
  static final String agent = _Env.agent;

  // --- Qcore SDK Credentials (Obfuscated) ---
  @EnviedField(varName: 'CLIENT_ID')
  static final String clientId = _Env.clientId;

  @EnviedField(varName: 'CLIENT_ID_STAGING')
  static final String clientIdStaging = _Env.clientIdStaging;

  @EnviedField(varName: 'PRODUCT_CODE')
  static final String productCode = _Env.productCode;
}