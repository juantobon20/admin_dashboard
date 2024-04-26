import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardHandlers {

  static Handler dashboard = Handler(handlerFunc: (context, paramaters) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context!);
    setCurrentPageUrl(context, Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    }
    return const LoginView();
  });

  static Handler icons = Handler(handlerFunc: (context, paramaters) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context!);
    setCurrentPageUrl(context, Flurorouter.iconsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    }
    return const LoginView();
  });

  static Handler blank = Handler(handlerFunc: (context, paramaters) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context!);
    setCurrentPageUrl(context, Flurorouter.blankRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    }
    return const LoginView();
  });

  static void setCurrentPageUrl(BuildContext context, String routeName) {
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(routeName);
  }
}