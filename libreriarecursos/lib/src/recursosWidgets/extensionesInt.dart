extension ExtensionesInt on int {
  // es par?
  bool get soyPar => this % 2 == 0;

  // es impar?
  bool get soyImpar => this % 2 != 0;
}
