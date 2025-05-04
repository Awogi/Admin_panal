import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(title: 'Dashboard', route: '/admin'),
          AdminMenuItem(title: 'Manage Quizzes', route: '/admin/quizzes'),
          AdminMenuItem(title: 'Users', route: '/admin/users'),
        ],
        selectedRoute: '/admin',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.pushNamed(context, item.route!);
          }
        },
      ),
      body: Center(child: Text("Welcome to Admin Panel")),
    );
  }
}
