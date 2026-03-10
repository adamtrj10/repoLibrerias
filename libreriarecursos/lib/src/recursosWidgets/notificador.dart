import 'package:flutter/material.dart';

class Notificador<T> extends ChangeNotifier {
  // la clase guarda un valor, pero sin saber de qué tipo
  T _value;
  Notificador(this._value);

  T get value => _value;

  set value(T nuevoValor) {
    _value = nuevoValor;
    notifyListeners();
  }
}

extension NotificadorExtension<T> on T {
  Notificador<T> get ntf => Notificador<T>(this);
}
