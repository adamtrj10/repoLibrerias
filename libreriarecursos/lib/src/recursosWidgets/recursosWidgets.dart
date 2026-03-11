import 'package:flutter/material.dart';
import 'package:libreriarecursos/libreriarecursos.dart';
import 'package:camera/camera.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  //widget que muestre la cámara
  static Widget visorCamara({
    required bool estaLista,
    required CameraController? controlador,
  }) {
    if (!estaLista || controlador == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: controlador.value.aspectRatio,
      child: CameraPreview(controlador),
    );
  }

  // widget para utilizar el QR
  static Widget escanerQR({required void Function(String) alDetectar}) {
    bool detectado = false; // Este es el "cerrojo" interno

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
            ),
            onDetect: (capture) {
              if (detectado) return; // Si ya disparó, ignora todo lo demás

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? valor = barcodes.first.rawValue;
                if (valor != null) {
                  detectado = true; // Bloqueamos el widget interno
                  alDetectar(valor);
                }
              }
            },
          ),
        ),
        const Expanded(
          flex: 1,
          child: Center(child: Text("Escanea un código QR")),
        )
      ],
    );
  }

  // widget para utilizar el webview
  static Widget visorWeb({required String url}) {
    final String urlLimpia = url.trim();

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            print("Error cargando la web: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(urlLimpia));

    return WebViewWidget(controller: controller);
  }
}

// notificador para el botón
// ignore: camel_case_types
class botonNotificador extends Notificador<int> {
  // El "inicial" se lo pasamos al padre (Notificador),
  // que ahora ya es un ValueNotifier gracias al cambio anterior.
  botonNotificador(int inicial) : super(inicial);

  void incrementar() {
    // 'value' ya existe dentro de Notificador/ValueNotifier
    value++;
  }

  void resetear() {
    value = 0;
  }
}
