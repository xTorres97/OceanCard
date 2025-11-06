import 'package:flutter/material.dart';
import 'package:ocean_card/presentation/widgets/steps.dart';
import 'package:go_router/go_router.dart';

class LoginPin extends StatefulWidget {
  const LoginPin({super.key});

  @override
  State<LoginPin> createState() => _LoginPinState();
}

class _LoginPinState extends State<LoginPin> {
  final TextEditingController _pinController = TextEditingController();

  void _onPinChanged(String value) {
    setState(() {});
    if (value.length == 4) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile =
        Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS;

    final int stepNow = _pinController.text.isEmpty
        ? -1
        : (_pinController.text.length - 1).clamp(0, 3);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your PIN',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 40),
              StepsIndicator(totalSteps: 4, stepNow: stepNow),
              const SizedBox(height: 32),
              isMobile
                  ? TextField(
                      controller: _pinController,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.transparent,
                        letterSpacing: 24,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      cursorColor: Colors.transparent,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintText: '',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onChanged: _onPinChanged,
                    )
                  : SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _pinController,
                        maxLength: 4,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.transparent,
                          letterSpacing: 24,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                        cursorColor: Colors.transparent,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: '',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onChanged: _onPinChanged,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
