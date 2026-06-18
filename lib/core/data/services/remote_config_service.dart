import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../constants/env/env.dart';
import '../../constants/remote_config_constants.dart';


class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;


  static const Set<String> _securityKeys = {
    RemoteConfigConstants.allowedFingerprints,
    RemoteConfigConstants.usePinning,
  };


  //Internal list that defaults to your ENV values immediately
  List<String> _fingerprints = [
    Env.stagingFingerprint,
    Env.awsRootFingerprint,
  ];

  //Getter used by NetworkManager
  List<String> get allowedFingerprints => _fingerprints;

  //pinning
  bool _usePinning = true;
  bool get usePinning => _usePinning;


  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),

      ));

      // Setup default (using comma-separated string to match Firebase format)
      await _remoteConfig.setDefaults({
        RemoteConfigConstants.allowedFingerprints : Env.stagingFingerprint,
      });

      await _remoteConfig.fetchAndActivate();

      // await _remoteConfig.activate();
      // await _remoteConfig.fetch();

      _usePinning = _remoteConfig.getBool(RemoteConfigConstants.usePinning);
      print('pinning:::$_usePinning .... ${_remoteConfig.getBool(RemoteConfigConstants.usePinning)}');

      // Update the local list after successful fetch
      _updateLocalList();

      // 2. Listen for real-time updates while the app is running
      _remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate update) async {
        log("🔔 Real-time Remote Config update detected!");

        // 2. Check if any of the updated keys intersect with your security keys
        final hasSecurityUpdates = update.updatedKeys.intersection(_securityKeys).isNotEmpty;

        if (hasSecurityUpdates) {
          log("🔒 Security keys changed. Activating and updating local state...");

          // Bypasses the cache interval to apply changes immediately
          await _remoteConfig.activate();
          _updateLocalList();
        }
      });

      log("✅ Remote Config Initialized. Current Fingerprints: $_fingerprints");
    } catch (e) {
      log("❌ Remote Config Error (Using Env Defaults): $e");
      // If fetch fails, _fingerprints already contains Env defaults from declaration
    }
  }

  _updateLocalList() {
    final String raw = _remoteConfig.getString(RemoteConfigConstants.allowedFingerprints);
    if (raw.isNotEmpty) {
      print('raw retrieved from firebase:::$raw>>>>');
      // Split comma-separated string and add the AWS Root as a permanent safety net
      final fetchedList = raw.split(',').map((e) => e.trim()).toList();

      print("fetched list:::${fetchedList.toString()}>>>");

      if (!fetchedList.contains(Env.awsRootFingerprint)) {
        fetchedList.add(Env.awsRootFingerprint);
      }

      _fingerprints = fetchedList;
    }
  }
}