import '../../core/enum/roles.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String userId;
  final String email;
  final String name;
  final Roles? role;
  final bool isActive;
  final DateTime activeSince;

  const Usuario({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.isActive,
    required this.activeSince,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: Roles.values.firstWhere(
        (element) => element.value == map['role'],
        orElse: () => Roles.values.first,
      ),
      isActive: map['isActive'] ?? true,
      activeSince:
          DateTime.tryParse(map['activeSince'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'role': role?.value, // Convertir a string
      'isActive': isActive,
      'activeSince': activeSince.toIso8601String(), // Guardar como string
    };
  }

  Usuario copyWith({
    String? userId,
    String? email,
    String? name,
    Roles? role,
    bool? isActive,
    DateTime? activeSince,
  }) {
    return Usuario(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      activeSince: activeSince ?? this.activeSince,
    );
  }

  static final empty = Usuario(
    userId: '',
    email: '',
    name: '',
    isActive: true,
    activeSince: DateTime.now(),
    role: Roles.values.first,
  );

  @override
  List<Object?> get props => [userId, email, name, role, isActive, activeSince];
}
