import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freerasp/freerasp.dart';

import '../../../locator.dart';
import '../../constants/named_routes.dart';
import 'navigation_service.dart';

class SecurityService {


  Future<void> init() async {

    if (kDebugMode) {
      print("Security Service: Debug mode detected. Skipping RASP checks.");
      return;
    }

    // 2. Configure Talsec (freeRASP)
    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'com.hopegainltd.winitagent',
        // You'll need your release signing hash (Base64) from Google Play/Keystore
        signingCertHashes: ['J6vcqAgtVLEW2LU3X5RKB6tHZhZ5v41VgSSfF9+KarI='], //debug
      ),
      iosConfig: IOSConfig(
        bundleIds: ['com.hopegainltd.winitagent'],
        teamId: 'V47PC8YVZY',
      ),
      watcherMail: 'c.keshinro@hopegainltd.com', // For security reports
      isProd: true
    );

    // 3. Define the callback
    final callback = ThreatCallback(
      onPrivilegedAccess: () => _handleThreat(),
      onHooks: () => _handleThreat(),
      onDebug: () => _handleThreat(),
      onAppIntegrity: () => _handleThreat(),
    );

    // 4. Start the engine
    try {
      await Talsec.instance.start(config);
      Talsec.instance.attachListener(callback);
    } catch (e) {
      debugPrint("Security Service Error: $e");
    }
  }

  void _handleThreat() {
    // Ensure we are on the main thread before navigating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService navigationService = locator<NavigationService>();
      if (navigationService.navigationKey.currentState != null) {
        navigationService.clearAllRoutes(
          routeName: NamedRoutes.securityPrompt,
        );
      }
    });
  }
}