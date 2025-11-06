import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/views/login/dialogs/forgot_password_dialog.dart';

class Login extends StatefulWidget {
  final VoidCallback onNext;
  const Login({super.key, required this.onNext});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título y subtítulo
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 18,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Inputs
              Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Forgot password y botón
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ForgotPasswordDialog(),
                      );
                    },
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      // shape va ser rounded pero no tan rounded
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      padding: const EdgeInsets.all(16),
                      elevation: 2,
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
