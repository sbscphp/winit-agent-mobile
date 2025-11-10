import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:winit_agent/core/constants/secure_storage_constants.dart';
import 'package:winit_agent/core/utilities/secure_storage/secure_storage_utils.dart';


class SecureStorageInit {
  static late FlutterSecureStorage storage;
  static late bool? useBiometrics;

  static initSecureStorage() async {
    AndroidOptions androidOption() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    IOSOptions iosOptions() =>
        const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

    storage =
        FlutterSecureStorage(aOptions: androidOption(), iOptions: iosOptions());

    initAuthData();
  }

  // ///fetch user auth data
  static initAuthData() async {
    SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);
  }
}
