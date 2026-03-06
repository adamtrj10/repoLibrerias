// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'notificador.dart';

/// Se tuvo que migrar del SDK de Flutter de la versión "3.13.9" a la "3.22.3",
/// esto a provocado el tener que actualizar el Widget [WillPopScope] porque
/// se ha quedado deprecated y en futuras versiones podría dejar de funcionar,
/// con lo cual ahora se debe de utilizar [PopScope]
///
/// Por motivos de funcionamiento, hemos creado [MyPopScope] para hacer que el
/// [PopScope] se comporte como el [WillPopScope]
///
/// **IMPRESCINDIBLE** Si utilizamos el [MyPopScope] al navegar hacia atrás
/// tenemos que utilizar el [MyPopScope.navigatorPop] no el [Navigator.pop]
/// nativo
/// Sobre el [Navegacion.pop] ya está gestionado automáticamente
///
/// * Diferencias:
///
/// - **Funcionamiento**:
///   - [WillPopScope] Detecta solo los eventos de volver atrás a través de los eventos del dispositivo,
///   como puede ser el botón de volver atrás del AppBar y el botón de volver atrás del móvil
///
///   - [PopScope] Detecta los eventos de volver atrás del dispositivo y los eventos de volver
///   con el "Navigator.pop"
///
/// - **Parámetros**:
///   - [WillPopScope]
///     - [WillPopScope.onWillPop] Con esa función gestionamos todo, retornando true o false si queremos volver
///
///   - [PopScope]
///     - [PopScope.canPop] Es el primero en procesarse, define si se puede volver atrás
///     - [PopScope.onPopInvoked] El segundo en procesarse, recibe como parámetro (bool didPop) y tiene el
///       mismo valor que tiene [PopScope.canPop]
///       <br> Aquí podemos definir las acciones que queramos, pero es una función void y no decidimos si se
///       cancela la carga de la navegación o no como en el [WillPopScope.onWillPop]
///
/// ---
///
/// * Explicación de arreglos:
///
/// Debido a la diferencia de funcionamiento entre el [WillPopScope] y el [PopScope]
/// ahora tenemos que manejar la situación que se da cuando el [PopScope] detecta
/// los [Navigator.pop], porque [WillPopScope] no lo hacía
///
/// Esto surge por lo siguiente:
///
/// - Con el [WillPopScope] cuando hacíamos un [Navigator.pop] este pasaba de detectarlo
/// en el [WillPopScope.onWillPop] y entonces en la APP solo se ejecutaba una vez el [Navigator.pop]
///
/// - Con el [PopScope] es diferente:
///
/// Cuando hacemos un [Navigator.pop], primero se ejecuta [Navigator.pop] y cuando se ha
/// completado luego salta el [PopScope.onPopInvoked]
///
/// El problema viene ahora, hemos implementado sobre el [MyPopScope] el parámetro de
/// [MyPopScope.puedoVolver] para que tenga el mismo comportamiento que el [WillPopScope.onWillPop]
///
/// Pero para poder hacerlo esto, dentro del [PopScope.onPopInvoked] del [MyPopScope] hemos
/// introducido un [Navigator.pop], pero si esto  no se controla provoca que se ejecuten
/// dos [Navigator.pop] seguidos y que la APP falle, porque esta intentando procesar un
/// segundo [Navigator.pop] antes de finalizar el primero, aparte que supone un problema
/// retroceder dos veces cuando solo se esperaba una vez
///
/// Para solucionar esto se ha introducido la variable [MyPopScope.vengoDeNavigatorPop] que se gestiona
/// de manera automática
///
/// Para que en caslab Pay Flutter funcione correctamente se ha modificado el [Navegacion.pop]
///
/// ---
///
/// * Resumen sencillo de funcionamiento:
///
/// Cada vez que se intente retroceder de página por la manera que sea se invocará
/// a la función de [MyPopScope.puedoVolver], esta decidirá si se puede volver o no
///
/// Recuerda, para navegar atrás utiliza [MyPopScope.navigatorPop] o [Navegacion.pop]
class MyPopScope extends StatefulWidget {
  const MyPopScope({
    required this.child,
    super.key,
    this.puedoVolver,
  });

  // -- Parámetros de PopScope --
  final Widget child;
  // -- Parámetros de MyPopScope --
  final bool Function()? puedoVolver;

  // -- Variables --
  /// Para evitar el bug de la doble navegación al hacer [Navigator.pop]
  static bool vengoDeNavigatorPop = false;

  /// El mismo efecto que [vengoDeNavigatorPop] pero para [Navigator.popUntil]
  static bool vengoDeNavigatorPopUntil = false;

  /// Imprescindible utilizar si se implementa [MyPopScope] para poder
  /// realizar la acción de [Navigator.pop] a excepcion de si se utiliza
  /// [Navegacion.pop] que ya lo implementa
  static void navigatorPop<T extends Object?>(
    BuildContext context, {
    T? result,
  }) {
    vengoDeNavigatorPop = true;
    Navigator.pop<T>(context, result);
    vengoDeNavigatorPop = false;
  }

  /// Actua de la misma manera que [MyPopScope.navigatorPop] pero sobre
  /// [Navigator.popUntil], de momento utilizan la misma variable
  /// [MyPopScope.vengoDeNavigatorPop] porque no se necesita nada diferente
  static void navigatorPopUntil(BuildContext context, String ruta) {
    vengoDeNavigatorPopUntil = true;
    Navigator.popUntil(
      context,
      (Route route) {
        return route.settings.name == ruta;
      },
    );
    vengoDeNavigatorPopUntil = false;
  }

  @override
  _MyPopScopeState createState() => _MyPopScopeState();
}

class _MyPopScopeState extends State<MyPopScope> {
  // -- Variables --
  /// De uso interno para gestionar el [PopScope.canPop] a través
  /// de [PopScope.onPopInvoked]
  /// Empieza a "false" para que se evalue siempre la condición
  /// de [MyPopScope.puedoVolver]
  final Notificador<bool> volver = false.ntf;

  // -- Funciones --
  /// Función necesaria para poner valor por defecto a [MyPopScope.puedoVolver]
  ///
  /// Return:
  /// - bool: Si se puede retroceder de página
  ///   <br> default: true
  bool puedoVolverDefault() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bool Function() puedoVolver =
        widget.puedoVolver ?? puedoVolverDefault;

    return PopScope(
      // El "canPop" lo gestionamos automáticamente a través
      // del resultado del "onPopInvoked"
      canPop: volver.value,
      // Ahora si que hacemos que esta función se comporte como
      // la de "WillPopScope.onWillPop()"
      onPopInvoked: (bool didPop) {
        // - Si "volver.value" ya viene a "true" significa que no tenemos
        // que procesar nada y dejarlo continuar ya que se a aprobado,
        // la opción de Navigator.pop
        // - Si el "volver.value" viene a "false" significa que es la primera
        // vez que tenemos que procesar la condición de "puedoVolver()"
        if (volver.value == false) {
          if (puedoVolver()) {
            // Si puedo volver, entonces reiniciamos este proceso a través de
            // un "Navigator.pop" para que pase por aquí de nuevo, pero esta
            // vez con "volver.value" a true para que pueda hacer el "Navigator.pop"
            volver.value = true;
            // Para evitar el bug de retroceder dos veces seguidas, para mas info
            // leer la descripción de "MyPopScope.vengoDeNavigatorPop.value"
            if (MyPopScope.vengoDeNavigatorPop == false &&
                MyPopScope.vengoDeNavigatorPopUntil == false) {
              Navigator.pop(context);
            }
          }
        }
      },
      child: widget.child,
    );
  }
}
