import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../constants/env/env.dart';
import '../../constants/remote_config_constants.dart';


class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;


  //Internal list that defaults to your ENV values immediately
  List<String> _fingerprints = [
    Env.stagingFingerprint,
    Env.awsRootFingerprint,
  ];

  //Getter used by NetworkManager
  List<String> get allowedFingerprints => _fingerprints;


  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),

      ));

      // Setup default (using comma-separated string to match Firebase format)
      await _remoteConfig.setDefaults({
        RemoteConfigConstants.allowedFingerprints: Env.stagingFingerprint,
      });

      await _remoteConfig.fetchAndActivate();

      // Update the local list after successful fetch
      _updateLocalList();

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

      if (!fetchedList.contains(Env.awsRootFingerprint)) {
        fetchedList.add(Env.awsRootFingerprint);
      }

      _fingerprints = fetchedList;
    }
  }
}