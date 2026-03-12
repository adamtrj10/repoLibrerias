import 'package:flutter/material.dart';

abstract class accionesBase {
  final GlobalKey<FormState> llaveForm = GlobalKey<FormState>();

  void dispose();

  void mostrarMensaje(BuildContext context, String mensaje,
      {bool esError = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensaje),
        backgroundColor: esError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2)));
  }
}
