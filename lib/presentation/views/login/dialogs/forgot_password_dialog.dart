import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/widgets/shared/app_dialog.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return AppDialog(
      title: 'Recuperar contraseña',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Introduce tu correo electrónico para recibir instrucciones.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Aquí iría la lógica para enviar el email de recuperación
            Navigator.of(context).pop();
          },
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
