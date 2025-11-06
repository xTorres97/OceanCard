import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'bloc_providers.dart';
import 'core/configuration/tema/tema_cubit.dart';
import 'core/configuration/tema/theme.dart';
import 'core/configuration/tema/util.dart';
import 'core/firebase_options.dart';
import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  firestore.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = createAppRouter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use Barlow for both body and display to avoid rounded Poppins look
    TextTheme textTheme = createTextTheme(context, "Barlow", "Barlow");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: AppBlocProviders.getBlocProviders(),
      child: BlocBuilder<TemaCubit, bool>(
        builder: (context, state) {
          return SafeArea(
            child: MaterialApp.router(
              color: Theme.of(context).colorScheme.surface,
              title: "Ocean card",
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              themeMode: ThemeMode.light,
              theme: state ? theme.dark() : theme.light(),
              darkTheme: theme.dark(),

              localizationsDelegates: _localizationDelegates,
              supportedLocales: _supportedLocales,
            ),
          );
        },
      ),
    );
  }
}

const _supportedLocales = [Locale('en'), Locale('es')];

const _localizationDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
