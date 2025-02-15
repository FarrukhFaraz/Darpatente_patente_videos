import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unique_identifier/unique_identifier.dart';

class UniqueIdService {
  UniqueIdService._();

  static Future<String?> getUniqueId() async {
    const ioOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    const aOptions = AndroidOptions(encryptedSharedPreferences: true);
    const storage = FlutterSecureStorage(iOptions: ioOptions, aOptions: aOptions);

    String? uuid = await storage.read(key: "unique_identifier_values", iOptions: ioOptions, aOptions: aOptions);
    if (kDebugMode) {
      print('UniqueIdService.getUniqueId:::: $uuid');
    }
    if (uuid == null) {
      uuid = await UniqueIdentifier.serial;
      await storage.write(key: "unique_identifier_values", value: uuid, iOptions: ioOptions, aOptions: aOptions);
      if (kDebugMode) {
        print('UniqueIdService.getUniqueId :: new uuid ::: $uuid');
      }

      return uuid;
    }

    return uuid;
  }
}
