import 'package:flutter/material.dart';
import 'package:examen_final_garcia/screens/screens.dart';

/// Side menu to navigate through the app, it has a header and a list of
/// Menu options.
class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
          MenuOption(title: 'Home', route: '/home-screen', icon: Icons.home),
          MenuOption(title: 'Maps', route: '/maps-screen', icon: Icons.map),
        ],
      ),
    );
  }
}

/// Menu option of the side menu, it an abstraction of a ListTile with a route
/// to navigate to and an icon to display in the menu
class MenuOption extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;

  const MenuOption(
      {super.key,
      required this.title,
      required this.route,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}

/// header widget of the side menu (image)
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
    );
  }
}
