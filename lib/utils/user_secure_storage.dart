import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'username';
  static const _keySurname = 'surname';
  static const _keyBirthday = 'birthday';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  static Future setSurname(String surname) async =>
      await _storage.write(key: _keySurname, value: surname);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUsername);

  static Future<String?> getSurname() async =>
      await _storage.read(key: _keySurname);

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    await _storage.write(key: _keyBirthday, value: birthday);
  }

  static Future<DateTime?> getBirthday() async {
    final birthday = await _storage.read(key: _keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }
}
