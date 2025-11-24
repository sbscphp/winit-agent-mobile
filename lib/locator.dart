import 'package:get_it/get_it.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'core/data/data_provider/otp_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  locator.registerLazySingleton<OtpDataProvider>(() => OtpDataProvider());
  locator.registerLazySingleton<OnboardingDataProvider>(() => OnboardingDataProvider());




  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
