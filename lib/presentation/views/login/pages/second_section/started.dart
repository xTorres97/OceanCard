// Started: phone input screen
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Started extends StatefulWidget {
  final ValueChanged<String> onNext;
  final VoidCallback? onSignIn;
  const Started({super.key, required this.onNext, this.onSignIn});

  @override
  State<Started> createState() => _StartedState();
}

class _StartedState extends State<Started> {
  final TextEditingController _phoneController = TextEditingController();
  String _fullNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
              // Steps arriba y título
              Column(
                children: [
                  // If you want a graphical steps indicator here, pass values from the parent
                  Text(
                    'Paso 2 de 3',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Número de teléfono',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              IntlPhoneField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  _fullNumber = phone.completeNumber;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _fullNumber.isNotEmpty
                      ? () => widget.onNext(_fullNumber)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: widget.onSignIn,
                child: Text(
                  '¿Ya tienes una cuenta? Iniciar sesión',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
