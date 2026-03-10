import 'package:flutter/material.dart';
import 'package:libreriarecursos/libreriarecursos.dart';

// ignore: camel_case_types
class recursosWidgets {
// widget de botón con icono
  static Widget botonIcono({
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
  static Widget botonTexto({
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
  static Widget botonBase({
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

// widget básico de texto
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

// widget básico de un campo de texto (para formularios)
  static Widget campoTexto<T>({
    required String etiqueta,
    required TextEditingController controlador,
    String? sugerencia,
    String? Function(String?)? validador,
    bool esContrasenya = false,
    void Function(T)? alCambiar,
    TextInputType tipoTeclado = TextInputType.text,
  }) {
    return TextFormField(
      controller: controlador,
      obscureText: esContrasenya,
      validator: validador,
      keyboardType: tipoTeclado,
      onChanged: (valor) {
        if (alCambiar != null) {
          alCambiar(valor as T);
        }
      },
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: sugerencia,
        border: const OutlineInputBorder(),
        prefixIcon: esContrasenya ? const Icon(Icons.lock_outline) : null,
      ),
    );
  }
}

// notificador para el botón
// ignore: camel_case_types
class botonNotificador extends Notificador<int> {
  // recibimos el número y lo lanzamos al padre (Notificador)
  botonNotificador(int inicial) : super(inicial);

  void incrementar() {
    value++;
  }

  void resetear() {
    value = 0;
  }
}
