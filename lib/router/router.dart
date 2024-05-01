import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/not_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {

  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/#';

  //Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //Dashboard
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String categoryRoute = '/dashboard/categories';
  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';

  static void configureRoutes() {
    //Auth Routes
    defineRoute(name: rootRoute, handler: AdminHandlers.login);
    defineRoute(name: loginRoute, handler: AdminHandlers.login);
    defineRoute(name: registerRoute, handler: AdminHandlers.register);

    //Dashboard
    defineRoute(name: dashboardRoute, handler: DashboardHandlers.dashboard);
    defineRoute(name: iconsRoute, handler: DashboardHandlers.icons);
    defineRoute(name: blankRoute, handler: DashboardHandlers.blank);
    defineRoute(name: categoryRoute, handler: DashboardHandlers.category);
    defineRoute(name: usersRoute, handler: DashboardHandlers.users);
    defineRoute(name: userRoute, handler: DashboardHandlers.user);

    //404
    router.notFoundHandler = NotPageFoundHandlers.notPageFound;
  }

  static void defineRoute({
    required String name, 
    required Handler handler, 
    TransitionType transitionType = TransitionType.none
  }) {
    router.define(name, handler: handler, transitionType: transitionType);
  }
}