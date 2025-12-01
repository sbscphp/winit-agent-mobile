import 'package:get_it/get_it.dart';
import 'package:winit_agent/core/data/data_provider/auth_data_provider/auth_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/game_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/profile_data_provider/profile_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/referral_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/wallet_data_provider.dart';
import 'package:winit_agent/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'core/data/data_provider/auth_data_provider/otp_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  locator.registerLazySingleton<OtpDataProvider>(() => OtpDataProvider());
  locator.registerLazySingleton<OnboardingDataProvider>(() => OnboardingDataProvider());
  locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider());
  locator.registerLazySingleton<ProfileDataProvider>(() => ProfileDataProvider());
  locator.registerLazySingleton<WalletDataProvider>(() => WalletDataProvider());
  locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());
  locator.registerLazySingleton<ReferralDataProvider>(() => ReferralDataProvider());
  locator.registerLazySingleton<GameDataProvider>(() => GameDataProvider());




  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
