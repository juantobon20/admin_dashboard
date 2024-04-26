import 'package:flutter/material.dart';

class NavBarAvatar extends StatelessWidget {
  const NavBarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network('https://static.vecteezy.com/system/resources/thumbnails/021/548/095/small/default-profile-picture-avatar-user-avatar-icon-person-icon-head-icon-profile-picture-icons-default-anonymous-user-male-and-female-businessman-photo-placeholder-social-network-avatar-portrait-free-vector.jpg'),
      ),
    );
  }
}