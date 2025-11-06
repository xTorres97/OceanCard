import 'dart:developer' as developer;

/// Niveles de log para indicar la importancia del mensaje
enum NivelLog {
  info, // Información general
  aviso, // Advertencias que podrían requerir atención
  error, // Errores que requieren atención inmediata
  depuracion, // Mensajes de depuración detallada
}

/// Registra un mensaje de log con información sobre la ubicación en el código
///
/// @param mensaje El mensaje que se desea registrar
/// @param nivel El nivel de importancia del mensaje (default: NivelLog.info)
/// @param detalles Información adicional para depuración (opcional)
/// @param stackFrameIndex Índice del frame en el stack trace a mostrar (default: 1)
void logConUbicacion(
  String mensaje, {
  NivelLog nivel = NivelLog.info,
  Map<String, dynamic>? detalles,
  int stackFrameIndex = 1, // Por defecto muestra el llamador directo
}) {
  try {
    // Verificar si la depuración está habilitada en producción
    // Comentar esta línea para permitir logs en producción
    // if (kReleaseMode) return;

    // Obtener el stack trace actual
    final stack = StackTrace.current.toString().split("\n");

    // Extraer la ubicación más relevante del stack trace
    String ubicacion = 'Ubicación desconocida';
    if (stack.length > stackFrameIndex + 1) {
      // Usamos el índice proporcionado para obtener la ubicación correcta
      ubicacion = stack[stackFrameIndex + 1]
          .replaceAll(RegExp(r'<fn>|  '), '')
          .trim();
    }

    // Determinar el icono según el nivel de log
    String icono = '📜';
    int nivelNumerico = 0;

    switch (nivel) {
      case NivelLog.info:
        icono = '📘';
        nivelNumerico = 0;
        break;
      case NivelLog.aviso:
        icono = '⚠️';
        nivelNumerico = 900;
        break;
      case NivelLog.error:
        icono = '🚨';
        nivelNumerico = 1000;
        break;
      case NivelLog.depuracion:
        icono = '🔍';
        nivelNumerico = 500;
        break;
    }

    // Construir el mensaje de log con formato mejorado
    String mensajeFormateado = '[$ubicacion] \n$mensaje';

    // Agregar detalles si se proporcionan
    if (detalles != null && detalles.isNotEmpty) {
      mensajeFormateado += '\nDetalles: $detalles';
    }

    // Registrar el log
    developer.log(mensajeFormateado, name: "LOG $icono", level: nivelNumerico);
  } catch (e) {
    // En caso de error en la función de log
    developer.log('Error al registrar log: $e', name: "LOG 🐞", level: 1000);
  }
}

// Función para compatibilidad con código existente que muestra la ubicación real
void logWithLocation(String message) {
  try {
    // Utilizamos stackFrameIndex = 2 para obtener el caller real (saltando esta función)
    logConUbicacion(message, stackFrameIndex: 2);
  } catch (e) {
    developer.log('Error en logWithLocation: $e', name: "LOG 🐞", level: 1000);
  }
}
