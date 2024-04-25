import 'package:admin_dashboard/ui/views/not_page_found_view.dart';
import 'package:fluro/fluro.dart';

class NotPageFoundHandlers {
  static Handler notPageFound = Handler(handlerFunc: (context, paramaters) {
    return const NotPageFoundView();
  });
}