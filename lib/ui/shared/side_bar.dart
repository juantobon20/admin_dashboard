import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SideBar extends StatelessWidget {
  const SideBar({super.key});

  void navigateTo(String routerName) {
    SideMenuProvider.closeMenu();
    NavigationService.navigateTo(routerName);
  }

  @override
  Widget build(BuildContext context) {
    final SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),

          const SizedBox(height: 50),

          const TextSeparator(text: 'main'),

          MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            isActive: provider.currentPage == Flurorouter.dashboardRoute,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute)
          ),

          MenuItem(
            text: 'Orders',
            icon: Icons.shopping_cart_checkout_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Analytics',
            icon: Icons.show_chart_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Categories',
            icon: Icons.layers_outlined,
            isActive: provider.currentPage == Flurorouter.categoryRoute,
            onPressed: () => navigateTo(Flurorouter.categoryRoute)
          ),

          MenuItem(
            text: 'Products',
            icon: Icons.dashboard_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Discount',
            icon: Icons.attach_money_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Customers',
            icon: Icons.people_alt_outlined,
            onPressed: () {}
          ),

          const SizedBox(height: 30),

          const TextSeparator(text: 'Ui Elements'),

          MenuItem(
            text: 'Icons',
            isActive: provider.currentPage == Flurorouter.iconsRoute,
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.iconsRoute)
          ),

          MenuItem(
            text: 'Marketing',
            icon: Icons.mark_email_read_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Campaign',
            icon: Icons.note_add_outlined,
            onPressed: () {}
          ),

          MenuItem(
            text: 'Black',
            icon: Icons.post_add_outlined,
            isActive: provider.currentPage == Flurorouter.blankRoute,
            onPressed: () => navigateTo(Flurorouter.blankRoute)
          ),

          const SizedBox(height: 30),

          const TextSeparator(text: 'Exit'),

          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF092044),
        Color(0xFF092043),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10
      )
    ]
  );
}