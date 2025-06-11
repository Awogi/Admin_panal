import 'package:admin_panal/widget/constant_color.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth >= 800;

        return Scaffold(
          appBar: isWideScreen ? null : AppBar(title:  Text("Admin Panal",style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),),
                          backgroundColor: themegreylight,
                          ),
          drawer: isWideScreen ? null : const AppDrawer(), 
          // Drawer only for narrow screens
          backgroundColor: themegreylight,
          body: Row(
           
            children: [
              if (isWideScreen)
                const SizedBox(
                  width: 250,
                  child: AppDrawer(), // Sidebar for wide screens
                ),
               Expanded(
                child: Center(
                  child: Text("Welcome to Admin Panel",style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Ubuntu",
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ Reusable Drawer Widget
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themegrey,
      child: ListView(
        padding: EdgeInsets.zero,
        
        children: [
          const SizedBox(height: 40),
          Center(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: themeblue,
                  ),
                  child: Image.asset(
                    'assets/images/Nepal_Pharmacy_Counsil.png',
                    height: 50,
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(child: Text("Nepal Pharmacy Counsil Liscense Practice Questions",style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Ubuntu",
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.bold,
                          ),))
              ],

            ),
          ),
          const SizedBox(height: 20),
          _sectionHeader("HOME"),
          _drawerItem(context, Icons.dashboard, "Dashboard", "/admin"),
          _sectionHeader("AUTH"),
          _drawerItem(context, Icons.logout, "Logout", "/admin/logout"),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
