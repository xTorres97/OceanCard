import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaCubit extends Cubit<bool> {
  TemaCubit(BuildContext context) : super(false) {
    _loadTheme(context); // Cargar el tema al iniciar
  }
  void toggleTheme() {
    final newState = !state;
    emit(newState); // Cambia el tema
    _saveTheme(newState); // Guarda el estado actual
  }

  void lightTheme() {
    emit(false);
    _saveTheme(false);
  }

  void darkTheme() {
    emit(true);
    _saveTheme(true);
  }

  Future<void> _loadTheme(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');

    if (isDarkMode == null && context.mounted) {
      // ignore: use_build_context_synchronously
      final systemTheme =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      emit(systemTheme); // Usa el tema del sistema
    } else {
      emit(isDarkMode!); // Usa el tema guardado
    }
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
