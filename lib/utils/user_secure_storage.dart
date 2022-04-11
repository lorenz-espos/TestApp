import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//classe che mi permette di crittografare i tre campi acquisiti tramite i widgets
//nella home
class UserSecureStorage {
  static final _storage = FlutterSecureStorage();
  //dichiaro le tre key impiegate per la crittografia
  static const _keyID = 'ID';
  static const _keyEmail = 'email';
  static const _keyBirthday = 'birthday';
//ogni funzione di set impiega il dato ottenuto dall'utente tramite la key identificandolo
//come value mentre la key viene usata per l operazione di crittografia
  static Future setID(String username) async =>
      await _storage.write(key: _keyID, value: username);

  static Future setEmail(String surname) async =>
      await _storage.write(key: _keyEmail, value: surname);
//ogni funzione di get pesca il dato inserito nel database crittografato ed usa
//la key per decrittografare l'informazione e mostarla a schermo all'utente
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
