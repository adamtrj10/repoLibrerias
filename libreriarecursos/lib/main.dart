import 'package:flutter/material.dart';
import 'package:libreriarecursos/libreriarecursos.dart';

void main() => runApp(const MaterialApp(home: PruebaRapida()));

class PruebaRapida extends StatelessWidget {
  const PruebaRapida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Recursos_widgets.botonTexto(
          texto: "PROBAR BOTÓN",
          ancho: 200,
          alto: 60,
          colortexto: Colors.white,
          colorfondo: Colors.blue,
          accion: () => debugPrint(""),
        ),
      ),
    );
  }
}
