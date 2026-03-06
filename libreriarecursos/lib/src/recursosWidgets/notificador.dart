class Notificador<T> {
  T value;
  Notificador(this.value);

  Notificador<T> get ntf => this;
}

extension NotificadorExtension<T> on T {
  Notificador<T> get ntf => Notificador<T>(this);
}
