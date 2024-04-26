import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';


class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {}
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
            onPressed: () {}
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
            icon: Icons.list_alt_outlined,
            onPressed: () {}
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
            onPressed: () {}
          ),

          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () {}
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