import 'package:admin_dashboard/ui/shared/side_bar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {

  final Widget child;
  
  const DashboardLayout({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEDF1F2),
      body: Row(
        children: [
          SideBar(),

          Expanded(child: child)
        ],
      ),
    );
  }
}