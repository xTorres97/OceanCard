import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_card/core/configuration/tema/tema_cubit.dart';

import 'pages/second_section/personal_information.dart';
import 'pages/second_section/create_pin.dart';
// 'started.dart' removed from flow
import 'pages/first_section/login.dart';
import 'pages/first_section/login_pin.dart';
import 'steps/steps_indicator.dart';
import 'steps/login_intro_steps.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  int _introStep = 0;

  void _goToPage(int index) {
    if ((index - _pageController.page!.round()).abs() > 1) {
      _pageController.jumpToPage(index);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<TemaCubit>().lightTheme();
    // Page changes are handled via PageView.onPageChanged to avoid
    // relying on the controller's page value during init.
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentStep = index),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 64, 20, 20),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                            maxHeight: 800,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: LoginIntroSteps(
                                  onStepChanged: (i) =>
                                      setState(() => _introStep = i),
                                ),
                              ),

                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _goToPage(1),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                      elevation: 2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Abrir cuenta',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                    onPressed: () => _goToPage(3),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: colorScheme.primary,
                                      ),
                                      foregroundColor: colorScheme.primary,
                                      minimumSize: const Size(
                                        double.infinity,
                                        50,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Página 1: PersonalInformation (registration start after intro)
                    PersonalInformation(
                      onNext: (data) {
                        // data collected, proceed to create PIN (page index 2)
                        _goToPage(2);
                      },
                    ),

                    // Página 2: CreatePin - user enters desired 4-digit PIN
                    CreatePin(
                      onPinEntered: (pin) {
                        // when PIN entered and confirmed locally in CreatePin,
                        // go directly to the Login page (next page index after removal)
                        _goToPage(3);
                      },
                    ),

                    // Página 3: Login
                    Login(onNext: () => _goToPage(4)),
                    // Página 5: LoginPin
                    const LoginPin(),
                  ],
                ),

                // Fixed thin ticks at top. Only show during the intro (page 0)
                if (_currentStep == 0)
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: StepsIndicator(
                        currentIndex: _introStep,
                        primaryColor: colorScheme.primary,
                        onSurface: colorScheme.onSurface,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
