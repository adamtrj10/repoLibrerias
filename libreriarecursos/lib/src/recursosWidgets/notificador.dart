import 'package:flutter/foundation.dart';

/// Gestiona un estado reactivo,
/// implementando 'ValueListenable' para que los widgets puedan escuchar sus cambios.
/// **Parámetros:** recibe un valor inicial genérico [T]
/// **Devuelve** una instancia [Notificador] que notifica a sus oyentes
class Notificador<T> extends ChangeNotifier implements ValueListenable<T> {
  Notificador(this._value);
  T _value;

  /// Actualiza el valor interno y dispara la notificación a todos los widgets que escuchan
  /// [nuevoValor] -> el nuevo dato que queremos almacenar
  /// si es el mismo valor, no notificamos
  @override
  T get value => _value;

  set value(T nuevoValor) {
    _value = nuevoValor;
    notifyListeners();
  }
}

/// Extensión para cualquier tipo de objeto en Dart para crear un [Notificador]
/// **Parámetros:** se aplica sobre cualquier instancia de tipo [T]
/// **Lo que devuelve:** objeto de tipo [Notificador<T>]
extension NotificadorExtension<T> on T {
  /// getter que convierte una variable normal en una reactiva
  ///  **Devuelve** una instancia de [Notificador] lista para ser usada con ValueListenableBuilder.
  Notificador<T> get ntf => Notificador<T>(this);
}
