import 'package:flutter/material.dart';

class BotonGruposProvider with ChangeNotifier {
  int _currentIndex = 0; // 🔹 Índice de la pestaña actual (0 = Chats, 1 = Grupos)

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // 🔹 Notifica a los widgets que escuchen este provider
  }
}