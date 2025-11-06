// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dart_firebase_admin/dart_firebase_admin.dart';
// import 'package:dart_firebase_admin/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

// import '../../core/log_locat.dart';
// import '../models/usuario_model.dart';

// /// Inicialización de Firebase Admin utilizando las credenciales del servicio.
// final admin = FirebaseAdminApp.initializeApp(
//   'ocean_card',
//   Credential.fromServiceAccountParams(
//     clientId: Config.clientId,
//     privateKey: Config.privateKey.replaceAll(r'\\n', '\n'),
//     email: Config.email,
//   ),
// );

// /// Objeto de autenticación para Firebase Admin.
// final authAdmin = Auth(admin);

// /// Repositorio para el manejo de operaciones relacionadas con los usuarios.
// class UsuarioRepositorio {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firestore;

//   UsuarioRepositorio({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
//     : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
//       _firestore = firestore ?? FirebaseFirestore.instance;

//   /// Stream que emite el usuario actualmente autenticado.

//   Stream<Usuario?> get usuarioActual {
//     return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
//       if (firebaseUser == null) return Usuario.empty;

//       try {
//         // Se consulta directamente al servidor, sin usar la caché.
//         DocumentSnapshot doc = await _firestore
//             .collection('users')
//             .doc(firebaseUser.uid)
//             .get(
//               GetOptions(source: Source.server),
//             ); // Siempre obtener desde el servidor

//         if (doc.exists) {
//           return Usuario.fromMap(doc.data() as Map<String, dynamic>);
//         }
//         return Usuario.empty; // Si no existen datos, devolver Usuario vacío
//       } catch (e) {
//         logWithLocation('Error al obtener los datos del usuario: $e');
//         return Usuario.empty; // En caso de error, devolver Usuario vacío
//       }
//     });
//   }

//   /// Inicia sesión utilizando correo y contraseña.
//   Future<void> iniciarSesion(String correo, String contrasena) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: correo,
//         password: contrasena,
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   /// Registra un nuevo usuario y guarda sus datos en Firestore.
//   ///
//   /// Crea el usuario con Firebase Admin y luego almacena la información en
//   /// la colección 'users'.
//   Future<Usuario> registrarUsuario(Usuario usuario, String contrasena) async {
//     logWithLocation('Registrando usuario: ${usuario.toMap()}');
//     try {
//       final userRecord = await authAdmin.createUser(
//         CreateRequest(
//           email: usuario.email,
//           password: contrasena,
//           displayName: usuario.name,
//         ),
//       );

//       final nuevoUsuario = Usuario(
//         userId: userRecord.uid,
//         email: usuario.email,
//         name: usuario.name,
//         role: usuario.role,
//         isActive: usuario.isActive,
//         activeSince: usuario.activeSince,
//       );

//       await _firestore
//           .collection('users')
//           .doc(nuevoUsuario.userId)
//           .set(nuevoUsuario.toMap());
//       return nuevoUsuario;
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   /// Cierra la sesión del usuario actualmente autenticado.
//   Future<void> cerrarSesion() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   /// Actualiza los datos del usuario en Firestore y, opcionalmente, su correo y contraseña.
//   Future<void> actualizarDatosUsuario(
//     Usuario usuario, {
//     String? contrasena,
//   }) async {
//     try {
//       // Obtener usuario actual para comparar
//       DocumentSnapshot doc = await _firestore
//           .collection('users')
//           .doc(usuario.userId)
//           .get();

//       if (doc.exists) {
//         Usuario usuarioActual = Usuario.fromMap(
//           doc.data() as Map<String, dynamic>,
//         );

//         // Verificar si cambió el correo
//         if (usuarioActual.email != usuario.email) {
//           await cambiarCorreo(usuario.userId, usuario.email);
//         }

//         // Verificar si se proporcionó una nueva contraseña
//         if (contrasena != null && contrasena.isNotEmpty) {
//           await cambiarContrasena(usuario.userId, contrasena);
//         }
//       }

//       // Actualizar datos en Firestore
//       await _firestore
//           .collection('users')
//           .doc(usuario.userId)
//           .update(usuario.toMap());
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   /// Cambia el correo electrónico del usuario utilizando Firebase Admin.
//   Future<void> cambiarCorreo(String uid, String correo) async {
//     try {
//       await authAdmin.updateUser(uid, UpdateRequest(email: correo));
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   /// Cambia la contraseña del usuario utilizando Firebase Admin.
//   Future<void> cambiarContrasena(String uid, String contrasena) async {
//     try {
//       await authAdmin.updateUser(uid, UpdateRequest(password: contrasena));
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   Stream<List<Usuario>> obtenerUsuarios(String role) {
//     return _firestore
//         .collection('users')
//         .where('role', isEqualTo: role) // Filtrar por perteneceA
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs
//               .map((doc) => Usuario.fromMap(doc.data()))
//               .toList();
//         });
//   }

//   /// Elimina un usuario de Firestore y de Firebase Auth.
//   Future<void> eliminarUsuario(String userId) async {
//     try {
//       await _firestore.collection('users').doc(userId).delete();
//       await authAdmin.deleteUser(userId);
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   /// Envía un correo electrónico para la recuperación de contraseña.
//   Future<void> recuperarContrasena(String correo) async {
//     try {
//       await _firebaseAuth.sendPasswordResetEmail(email: correo);
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }
// }
