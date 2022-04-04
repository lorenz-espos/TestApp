import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyID = 'ID';
  static const _keyEmail = 'email';
  static const _keyBirthday = 'birthday';

  static Future setID(String username) async =>
      await _storage.write(key: _keyID, value: username);

  static Future setEmail(String surname) async =>
      await _storage.write(key: _keyEmail, value: surname);

  static Future<String?> getID() async => await _storage.read(key: _keyID);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    await _storage.write(key: _keyBirthday, value: birthday);
  }

  static Future<DateTime?> getBirthday() async {
    final birthday = await _storage.read(key: _keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }
}
