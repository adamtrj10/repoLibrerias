import 'package:flutter/material.dart';

// ignore: camel_case_types
abstract class accionesBase with WidgetsBindingObserver {
  // variable genérica que nos permite navegar entre pantallas
  bool puedoNavegar = true;
  // llave única para gestionar y validar formularios de forma centralizada
  final GlobalKey<FormState> llaveForm = GlobalKey<FormState>();

  // al instanciar cualquier clase hija, se activa la escucha del ciclo de vida
  accionesBase() {
    WidgetsBinding.instance.addObserver(this);
  }

  // método para limpiar recursos
  @mustCallSuper
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  // método que detecta si la app se pausa (paused) o se resume (resumed)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // si el ciclo de vida está pausado, quitamos el teclado automáticamente al minimizar
    if (state == AppLifecycleState.paused) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

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
