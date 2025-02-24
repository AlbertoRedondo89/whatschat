import 'package:flutter/material.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/theme/theme.dart';  // Importa los temas claros y oscuros

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = Preferences.modoOscuro; 

  bool get isDarkMode => _isDarkMode;

  // Función para cambiar el tema
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();  
  }

  // Obtener el tema según el estado
  ThemeData get currentTheme => _isDarkMode ? appThemeDark : appThemeLight;
}
