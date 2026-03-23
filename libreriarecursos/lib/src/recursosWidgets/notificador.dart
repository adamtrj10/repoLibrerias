import 'package:flutter/foundation.dart';

class Notificador<T> extends ChangeNotifier implements ValueListenable<T> {
  T _value;
  Notificador(this._value);

  @override
  T get value => _value;

  set value(T nuevoValor) {
    _value = nuevoValor;
    notifyListeners();
  }
}

extension NotificadorExtension<T> on T {
  Notificador<T> get ntf => Notificador<T>(this);
}
