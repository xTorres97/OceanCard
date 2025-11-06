// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../core/enum/roles.dart';
// import '../../../core/log_locat.dart';
// import '../../../data/models/usuario_model.dart';
// import '../../../domain/usecases/usuario/obtener_usuarios_usecase.dart';

// part 'usuario_lista_event.dart';
// part 'usuario_lista_state.dart';

// class UsuarioListaBloc extends Bloc<UsuarioListaEvent, UsuarioListaState> {
//   final Map<Roles, Stream<List<Usuario>>> _usuariosStreams = {};
//   final ObtenerUsuariosUseCase obtenerUsuariosUseCase;

//   UsuarioListaBloc({required this.obtenerUsuariosUseCase})
//     : super(const UsuariosInicial()) {
//     on<CargandoUsuariosPorRol>(_onCargandoUsuariosPorRol);
//     on<NavegarARol>(_onNavegarARol);
//     on<CargarTodosLosRoles>(_onCargarTodosLosRoles);
//     add(const CargarTodosLosRoles());
//   }

//   Future<void> _onCargandoUsuariosPorRol(
//     CargandoUsuariosPorRol event,
//     Emitter<UsuarioListaState> emit,
//   ) async {
//     emit(CargandoUsuarios());
//     try {
//       final stream = obtenerUsuariosUseCase(event.rol.value);
//       _usuariosStreams[event.rol] = stream;
//       logWithLocation('Cargando usuarios para el rol: ${event.rol}');
//       logWithLocation(
//         'Usuarios cargados para el rol: ${event.rol}, stream: $stream',
//       );

//       emit(UsuariosCargados(usuarios: stream, rol: event.rol));
//     } catch (e) {
//       emit(ErrorCargandoUsuarios('Error al cargar usuarios: $e'));
//       logWithLocation('Error al cargar usuarios: $e');
//     }
//   }

//   void _onNavegarARol(NavegarARol event, Emitter<UsuarioListaState> emit) {
//     final stream = _usuariosStreams[event.rol];
//     if (stream != null) {
//       emit(UsuariosCargados(usuarios: stream, rol: event.rol));
//     } else {
//       emit(
//         ErrorCargandoUsuarios('No se ha cargado aún la lista de ${event.rol}.'),
//       );
//     }
//   }

//   void _onCargarTodosLosRoles(
//     CargarTodosLosRoles event,
//     Emitter<UsuarioListaState> emit,
//   ) {
//     emit(CargandoUsuarios());
//     logWithLocation('Cargando todos los roles de usuarios');
//     try {
//       final todosLosRoles = Roles.values;
//       for (var rol in todosLosRoles) {
//         final stream =
//             _usuariosStreams[rol] ?? obtenerUsuariosUseCase(rol.value);
//         _usuariosStreams[rol] = stream;
//       }
//       logWithLocation(
//         'Todos los roles de usuarios cargados: $_usuariosStreams',
//       );
//       emit(TodosLosRolesCargados(_usuariosStreams));
//     } catch (e) {
//       emit(ErrorCargandoUsuarios('Error al cargar todos los roles: $e'));
//     }
//   }
// }
