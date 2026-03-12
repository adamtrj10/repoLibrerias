import 'package:flutter/material.dart';

abstract class accionesBase {
  // llave única para gestionar y validar formularios de forma centralizada
  final GlobalKey<FormState> llaveForm = GlobalKey<FormState>();

  // método que define cómo liberar memoria
  void dispose();

  // utilidad para mostrar alertas
  // si [esError] es true, el fondo será rojo
  // sino, será verde
  void mostrarMensaje(BuildContext context, String mensaje,
      {bool esError = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensaje),
        backgroundColor: esError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2)));
  }

  void prueba() {
    print("prueba_accionesBase");
  }
}
