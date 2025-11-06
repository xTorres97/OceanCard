import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/configuration/tema/tema_cubit.dart';

class AppBlocProviders {
  static List<BlocProvider> getBlocProviders() {
    // final usuarioRepositorio = UsuarioRepositorio();

    return [
      BlocProvider<TemaCubit>(
        create: (context) => TemaCubit(context),
        lazy: false,
      ),
      // BlocProvider<AutenticacionBloc>(
      //   create: (context) => AutenticacionBloc(
      //     obtenerUsuarioActualUseCase: ObtenerUsuarioActualUseCase(
      //       usuarioRepositorio,
      //     ),
      //     cerrarSesionUsuarioUseCase: CerrarSesionUsuarioUseCase(
      //       usuarioRepositorio,
      //     ),
      //     iniciarSesionUsuarioUseCase: IniciarSesionUsuarioUseCase(
      //       usuarioRepositorio,
      //     ),
      //   ),
      //   lazy: false,
      // ),
      // BlocProvider<UsuarioListaBloc>(
      //   create: (context) => UsuarioListaBloc(
      //     obtenerUsuariosUseCase: ObtenerUsuariosUseCase(usuarioRepositorio),
      //   ),
      //   lazy: false,
      // ),
      // BlocProvider<UsuarioOperacionesBloc>(
      //   create: (context) => UsuarioOperacionesBloc(
      //     registrarUsuarioUseCase: RegistrarUsuarioUseCase(usuarioRepositorio),
      //     actualizarDatosUsuarioUseCase: ActualizarDatosUsuarioUseCase(
      //       usuarioRepositorio,
      //     ),
      //     eliminarUsuarioUseCase: EliminarUsuarioUseCase(usuarioRepositorio),
      //   ),
      //   lazy: false,
      // ),
    ];
  }
}
