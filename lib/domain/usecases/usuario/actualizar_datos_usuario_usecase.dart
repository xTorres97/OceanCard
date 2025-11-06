// import '../../../core/log_locat.dart';
// import '../../../data/repositories/usuario_repositorio.dart';
// import '../../../data/models/usuario_model.dart';

// class ActualizarDatosUsuarioUseCase {
//   final UsuarioRepositorio usuarioRepository;

//   ActualizarDatosUsuarioUseCase(this.usuarioRepository);

//   Future<void> call(Usuario usuario, String? contrasena) async {
//     try {
//       await usuarioRepository.actualizarDatosUsuario(
//         usuario,
//         contrasena: contrasena,
//       );
//     } catch (e) {
//       logWithLocation('Error al actualizar datos del usuario: $e');
//       rethrow;
//     }
//   }
// }
