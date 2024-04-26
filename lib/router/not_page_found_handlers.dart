import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/ui/views/not_page_found_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class NotPageFoundHandlers {
  static Handler notPageFound = Handler(handlerFunc: (context, paramaters) {
    Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');
    return const NotPageFoundView();
  });
}