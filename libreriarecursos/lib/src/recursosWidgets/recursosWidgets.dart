import 'package:flutter/material.dart';

// widget de texto
class texto extends StatelessWidget {
  final String text;
  final Color color;
  final double tamanyo;

  const texto(
      {super.key,
      required this.text,
      required this.color,
      required this.tamanyo});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: tamanyo),
    );
  }
}

// widget de botón
class boton extends StatelessWidget {
  final String texto;
  final double ancho;
  final double alto;
  final Color colortexto;
  final Color colorfondo;
  final VoidCallback accion;

  const boton({
    super.key,
    required this.texto,
    required this.ancho,
    required this.alto,
    required this.colortexto,
    required this.colorfondo,
    required this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ancho,
      height: alto,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorfondo,
          foregroundColor: colortexto,
        ),
        onPressed: accion,
        child: Text(texto),
      ),
    );
  }
}


// widget de formulario