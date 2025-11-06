// Deprecated stub: CreatePin was removed from the flow.
// Keep a minimal placeholder to avoid build errors during refactor.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef PinEntered = void Function(String pin);

class CreatePin extends StatefulWidget {
  final PinEntered onPinEntered;
  const CreatePin({super.key, required this.onPinEntered});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool _isValid = false;
  void _onChanged(String _) {
    final pin = _pinController.text.trim();
    final confirm = _confirmPinController.text.trim();
    final fourDigits = RegExp(r'^\d{4}$');
    // both must be exactly 4 digits and equal
    final pinDigits = fourDigits.hasMatch(pin);
    final confirmDigits = fourDigits.hasMatch(confirm);
    final bothMatch = pinDigits && confirmDigits && pin == confirm;
    if (bothMatch != _isValid) setState(() => _isValid = bothMatch);
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Crear PIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Elige un PIN de 4 dígitos que usarás para acceder a la app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pinController,
                  decoration: const InputDecoration(
                    labelText: 'PIN (4 dígitos)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  obscureText: true,
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmPinController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar PIN',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  obscureText: true,
                  onChanged: _onChanged,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isValid
                      ? () => widget.onPinEntered(_pinController.text)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(16),
                    elevation: 2,
                  ),
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
