extension Extensiones_string on String {
  // es email?
  bool get esEmail {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}
