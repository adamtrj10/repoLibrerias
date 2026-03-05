import 'package:flutter/material.dart';

class recursosWidgets {
// widget de botón con icono
  Widget botonIcono({
    required IconData icono,
    required double ancho,
    required double alto,
    required Color colorIcono,
    required Color colorfondo,
    required VoidCallback accion,
  }) {
    return botonBase(
      ancho: ancho,
      alto: alto,
      colorfondo: colorfondo,
      accion: accion,
      contenido: Icon(icono, color: colorIcono),
    );
  }

// widget de botón con texto
  Widget botonTexto({
    required String texto,
    required double ancho,
    required double alto,
    required Color colortexto,
    required Color colorfondo,
    required VoidCallback accion,
  }) {
    return botonBase(
      ancho: ancho,
      alto: alto,
      colorfondo: colorfondo,
      accion: accion,
      contenido: Text(texto,
          style: TextStyle(color: colortexto, fontWeight: FontWeight.bold)),
    );
  }

// widget de botón base
  Widget botonBase({
    required Widget contenido,
    required double ancho,
    required double alto,
    required Color colorfondo,
    required VoidCallback accion,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorfondo,
        minimumSize: Size(ancho, alto),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: accion,
      child: contenido,
    );
  }

  static Widget texto({
    required String text,
    required Color color,
    required double tamanyo,
    TextAlign alineacion = TextAlign.start,
    FontWeight grosor = FontWeight.normal,
  }) {
    return Text(
      text,
      textAlign: alineacion,
      style: TextStyle(color: color, fontSize: tamanyo, fontWeight: grosor),
    );
  }

  static Widget campoTexto({
    required String etiqueta,
    required TextEditingController controlador,
    String? sugerencia,
    String? Function(String?)? validador,
    bool esContrasenya = false,
    TextInputType tipoTeclado = TextInputType.text,
  }) {
    return TextFormField(
      controller: controlador,
      obscureText: esContrasenya,
      validator: validador,
      keyboardType: tipoTeclado,
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: sugerencia,
        border: const OutlineInputBorder(),
        // Añadimos un icono de candado si es contraseña por estética
        prefixIcon: esContrasenya ? const Icon(Icons.lock_outline) : null,
      ),
    );
  }
}

// notificador para el botón
// ignore: camel_case_types
class botonNotificador extends ValueNotifier<int> {
  botonNotificador(super.valorInicial);

  void incrementar() {
    value++;
  }

  void resetear() {
    value = 0;
  }
}
