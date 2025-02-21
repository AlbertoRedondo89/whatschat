import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _nombre = "";
  static String _password = "";
  static String _idioma = "Español";
  static bool _Notificaciones = true;
  static String _imagePath = "";
  static bool _modoOscuro = false;
  

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static String get nombre {
    return _prefs.getString('nombre') ?? _nombre;
  }

  static set nombre(String nombre){
    _nombre = nombre;
    _prefs.setString('nombre', nombre);
  }

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password(String password){
    _password = password;
    _prefs.setString('password', password);
  }
  static String get idioma {
    return _prefs.getString('idioma') ?? _idioma;
  }

  static set idioma(String password){
    _idioma = idioma;
    _prefs.setString('idioma', idioma);
  }

  static bool get  Notificaciones {
    return _prefs.getBool('Notificaciones') ?? _Notificaciones;
  }

  static set Notificaciones(bool Notificaciones){
    _Notificaciones = Notificaciones;
    _prefs.setBool('DarkMode', Notificaciones);
  }

  static Future<void> setImage(File imageFile) async {
    _imagePath = imageFile.path; // Guarda la ruta de la imagen
    await _prefs.setString('imagePath', _imagePath);
  }

  static File? get image {
    String path = _prefs.getString('imagePath') ?? "";
    return path.isNotEmpty ? File(path) : null;
  }
  
  // Modo oscuro 🔹
  static bool get modoOscuro => _prefs.getBool('modoOscuro') ?? _modoOscuro;
  static set modoOscuro(bool value) {
    _modoOscuro = value;
    _prefs.setBool('modoOscuro', value);
  }

}