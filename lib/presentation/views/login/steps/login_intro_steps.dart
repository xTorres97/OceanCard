import 'package:flutter/material.dart';
import 'step_item.dart';
// Fonts are provided via theme; avoid hardcoding GoogleFonts here
import 'package:flutter_svg/svg.dart';

class LoginIntroSteps extends StatefulWidget {
  final ValueChanged<int>? onStepChanged;

  const LoginIntroSteps({super.key, this.onStepChanged});

  @override
  State<LoginIntroSteps> createState() => _LoginIntroStepsState();
}

class _LoginIntroStepsState extends State<LoginIntroSteps> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final i = (_controller.page ?? 0).round().clamp(0, 3);
      if (i != _index) {
        setState(() => _index = i);
        widget.onStepChanged?.call(i);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: [
              // Step 1: logo + cards + text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _Branding(),
                  SizedBox(height: 16),
                  StepItem(
                    title: 'Tu dinero global, en una sola app 💵',
                    subtitle:
                        'Guarda, envía o utiliza tus dólares donde quieras. Abre tu cuenta en minutos y empieza a operar con OceanCard.',
                  ),
                ],
              ),
              // Step 3: tarjeta amarilla + título y descripción
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  StepItem(
                    title: 'OBTÉN UNA TARJETA 💳',
                    subtitle:
                        'Tarjeta Visa aceptada en más de 120 millones de comercios en el mundo en dólares.',
                  ),
                  SizedBox(height: 16),
                  _Step3Card(),
                ],
              ),

              // Step 2: título en bold + imagen
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  StepItem(
                    title: 'AHORRA EN DÓLARES🫰',
                    subtitle:
                        'Ahorra de manera segura con nuestra cuenta autocustodiada a la que solo tú tienes acceso.',
                  ),
                  SizedBox(height: 16),
                  _Step2Image(),
                ],
              ),

              // Step 4: countries SVG + título y descripción
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StepItem(
                    title: 'RETIRA Y ENVÍA EN TODO EL MUNDO Y LATAM 🌍',
                    subtitle:
                        'Retira tu dinero en moneda local a cuentas bancarias en +14 países de Latam a tasas competitivas.',
                  ),
                  const SizedBox(height: 16),
                  const _Step4Countries(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _Branding extends StatelessWidget {
  const _Branding();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset('assets/logo.svg', height: 30),
        const SizedBox(height: 16),
        SvgPicture.asset('assets/section-cards.svg', height: 250),
      ],
    );
  }
}

class _Step2Image extends StatelessWidget {
  const _Step2Image();

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/box.png', fit: BoxFit.contain, height: 220);
  }
}

class _Step3Card extends StatelessWidget {
  const _Step3Card();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/card_black.svg', height: 220);
  }
}

class _Step4Countries extends StatelessWidget {
  const _Step4Countries();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/countries.png',
      height: 300,
      fit: BoxFit.contain,
    );
  }
}
