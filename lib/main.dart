import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_config.dart';
import 'package:winit_agent/core/constants/app_theme/app_theme.dart';
import 'package:winit_agent/core/data/enum/environment.dart';
import 'package:winit_agent/core/data/services/navigation_service.dart';
import 'package:winit_agent/core/data/view_models/theme_selection_view_model.dart';
import 'package:winit_agent/core/data/view_models/utility/service_agents_vm.dart';
import 'package:winit_agent/core/utilities/secure_storage/secure_storage_init.dart';
import 'package:winit_agent/locator.dart';
import 'package:winit_agent/ui/pages/splash.dart';
import 'package:winit_agent/router.dart' as router;

import 'core/constants/app_constants.dart';
import 'core/data/view_models/utility/lga_details_vm.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  //await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppConfig.setEnvironment(Environment.staging);
  //await CountryUtils.readCountryJson();
  SecureStorageInit.initSecureStorage();
  setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lgaDetailsViewModel).fetchLgaDetails();
      ref.read(serviceAgentsViewModel).fetchServiceAgents();
    });

    //push notification initial set up
    //FirebaseMessagingUtils.requestPushNotificationPermission();

    //location permission
    // final locationService = locator<GeoLocatorService>();
    // locationService.requestPermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          const figmaDesignSize = Size(draftWidth, draftHeight);
          final isFoldOrTablet = maxWidth > phoneWidth;
          final designSize = isFoldOrTablet
              ? Size(maxWidth - 16, maxHeight - 32)
              : figmaDesignSize;
          return ScreenUtilInit(
            splitScreenMode: false,
            minTextAdapt: true,
            designSize: designSize,
            builder: (context, child) => Consumer(
              builder: (context, ref, child) {
                final themeVm = ref.watch(themeSelectionViewModel);
                final themeMode = themeVm.themeMode;
                return MaterialApp(
                  title: 'WinIt Agent',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeMode,
                  navigatorKey: locator<NavigationService>().navigationKey,
                  onGenerateRoute: router.generateRoute,
                  home: const Splash(),
                  builder: (context, child) {
                    final mq = MediaQuery.of(context);
                    return MediaQuery(
                      data: mq.copyWith(textScaler: TextScaler.noScaling),
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        }
    );



  }
}

