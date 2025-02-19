import 'package:flutter/material.dart';
import 'package:whatschat/theme/theme.dart';  // Importa los temas claros y oscuros

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;  // El estado inicial será el tema claro

  bool get isDarkMode => _isDarkMode;

  // Función para cambiar el tema
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();  // Notifica a los widgets escuchando este cambio
  }

  // Obtener el tema según el estado
  ThemeData get currentTheme => _isDarkMode ? appThemeDark : appThemeLight;
}
