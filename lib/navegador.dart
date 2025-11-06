import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ocean_card/core/configuration/tema/tema_cubit.dart';
import 'package:ocean_card/core/configuration/tema/theme.dart';

// import 'presentation/blocs/autenticacion/autenticacion_bloc.dart';

class Navegador extends StatefulWidget {
  final Widget child;
  const Navegador({super.key, required this.child});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<Navegador> {
  int _selectedIndex = 0;
  bool hoverTheme = false;
  bool hoverLogout = false;
  bool hoverNotifications = false;
  final bool _isNavigationRailExpanded = false;

  @override
  void initState() {
    super.initState();
    // Sync navigation index with current route on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = _getCurrentIndexFromRoute();
      if (index != _selectedIndex) {
        setState(() {
          _selectedIndex = index;
        });
      }
    });
  }

  int _getCurrentIndexFromRoute() {
    try {
      final location = GoRouter.of(
        context,
      ).routerDelegate.currentConfiguration.fullPath;
      final parts = location.split('/');

      if (parts.length > 1) {
        switch (parts[1]) {
          case 'home':
            return 0;
          case 'card':
            return 1;
          default:
            return 0;
        }
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/card');
        break;
    }
  }

  Widget _buildThemeButton(bool isDark) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoverTheme = true),
      onExit: (_) => setState(() => hoverTheme = false),
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 300),
        turns: hoverTheme ? 0.125 : 0.0,
        child: IconButton(
          icon: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).colorScheme.onBlack,
          ),
          onPressed: () => context.read<TemaCubit>().toggleTheme(),
        ),
      ),
    );
  }

  // Widget _buildLogoutButton() {
  //   return MouseRegion(
  //     onEnter: (_) => setState(() => hoverLogout = true),
  //     onExit: (_) => setState(() => hoverLogout = false),
  //     child: AnimatedRotation(
  //       duration: const Duration(milliseconds: 300),
  //       turns: hoverLogout ? 0.05 : 0.0,
  //       child: IconButton(
  //         icon: Icon(
  //           Icons.logout,
  //           color: Theme.of(context).colorScheme.onPrimary,
  //         ),
  //         onPressed: () {
  //           // context.read<AutenticacionBloc>().add(CerrarSesion());
  //           GoRouter.of(context).go('/login');
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProfileMenu(BuildContext context, String? username) {
    final cs = Theme.of(context).colorScheme;

    return PopupMenuButton<int>(
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              username ?? 'Usuario',
              style: TextStyle(
                color: cs.onBlack,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),

      color: cs.surface,
      offset: const Offset(0, 48), // Aparece justo debajo del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: cs.outline),
      ),
      elevation: 12,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        switch (value) {
          case 0:
            // Ver perfil
            break;
          case 1:
            // Editar perfil
            break;
          case 2:
            // Configuración de la cuenta
            break;
          case 3:
            // Preferencias
            break;
          case 4:
            // Cambiar contraseña
            break;
          case 5:
            // Notificaciones
            break;
          case 6:
            // Privacidad
            break;
          case 7:
            // Centro de ayuda / Soporte
            break;
          case 8:
            // Idioma
            break;
          case 9:
            // Cerrar sesión
            GoRouter.of(context).go('/login');
            break;
        }
      },
      itemBuilder: (context) {
        final cs = Theme.of(context).colorScheme;
        return [
          PopupMenuItem<int>(
            value: 0,
            child: ListTile(
              leading: Icon(Icons.person, color: cs.onSurfaceVariant),
              title: Text('Ver perfil', style: TextStyle(color: cs.onSurface)),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              leading: Icon(Icons.edit, color: cs.onSurfaceVariant),
              title: Text(
                'Editar perfil',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: ListTile(
              leading: Icon(Icons.settings, color: cs.onSurfaceVariant),
              title: Text(
                'Configuración de la cuenta',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: ListTile(
              leading: Icon(Icons.tune, color: cs.onSurfaceVariant),
              title: Text(
                'Preferencias',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 4,
            child: ListTile(
              leading: Icon(Icons.lock, color: cs.onSurfaceVariant),
              title: Text(
                'Cambiar contraseña',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 5,
            child: ListTile(
              leading: Icon(Icons.notifications, color: cs.onSurfaceVariant),
              title: Text(
                'Notificaciones',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 6,
            child: ListTile(
              leading: Icon(Icons.privacy_tip, color: cs.onSurfaceVariant),
              title: Text('Privacidad', style: TextStyle(color: cs.onSurface)),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 7,
            child: ListTile(
              leading: Icon(Icons.help_center, color: cs.onSurfaceVariant),
              title: Text(
                'Centro de ayuda / Soporte',
                style: TextStyle(color: cs.onSurface),
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          PopupMenuItem<int>(
            value: 8,
            child: ListTile(
              leading: Icon(Icons.language, color: cs.onSurfaceVariant),
              title: Text('Idioma', style: TextStyle(color: cs.onSurface)),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const PopupMenuDivider(height: 0),
          PopupMenuItem<int>(
            value: 9,
            child: ListTile(
              leading: Icon(Icons.logout, color: cs.error),
              title: Text('Cerrar sesión', style: TextStyle(color: cs.error)),
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ];
      },
    );
  }

  Widget _buildDesktopLayout() {
    List<NavigationRailDestination> destinations;

    destinations = const [
      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
      NavigationRailDestination(
        icon: Icon(Icons.credit_card), // Cambiado a tarjeta de crédito
        label: Text('Card'),
      ),
    ];

    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _isNavigationRailExpanded ? 180 : 90,
          child: NavigationRail(
            extended: _isNavigationRailExpanded,
            minWidth: 90,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: _isNavigationRailExpanded
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.selected,
            indicatorColor: Theme.of(
              context,
            ).colorScheme.black.withValues(alpha: 0.2),
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onBlack,
            ),
            selectedLabelTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBlack,
              fontWeight: FontWeight.bold,
            ),
            unselectedIconTheme: IconThemeData(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            unselectedLabelTextStyle: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            destinations: destinations,
          ),
        ),
        const VerticalDivider(width: 2, thickness: 1),
        Expanded(child: widget.child),
      ],
    );
  }

  Widget _buildMobileNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 15,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onBlack,
      ),
      selectedLabelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onBlack,
        fontWeight: FontWeight.bold,
      ),
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      unselectedLabelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card), // Cambiado a tarjeta de crédito
          label: 'Card',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.onBlack,
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sync navigation index with current route whenever the widget rebuilds
    final currentIndex = _getCurrentIndexFromRoute();
    if (currentIndex != _selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedIndex = currentIndex;
          });
        }
      });
    }

    return BlocBuilder<TemaCubit, bool>(
      builder: (context, isDarkTheme) {
        return Scaffold(
          appBar: AppBar(
            title: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile menu (left)
                  _buildProfileMenu(context, null),
                ],
              ),
            ),
            actions: [_buildThemeButton(isDarkTheme)],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 800
                  ? _buildDesktopLayout()
                  : widget.child;
            },
          ),
          bottomNavigationBar: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth <= 800
                  ? _buildMobileNavigation()
                  : const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
