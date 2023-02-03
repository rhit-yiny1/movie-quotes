import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_quotes/managers/auth_manager.dart';

class ListPageSideDrawer extends StatelessWidget {
  final Function() showAllCallback;
  final Function() showOnlyMineCallback;
  const ListPageSideDrawer({
    required this.showAllCallback,
    required this.showOnlyMineCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Movie Quotes',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            title: const Text('Show only my quotes'),
            leading: Icon(Icons.person),
            onTap: () {
              showOnlyMineCallback();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Show all quotes'),
            leading: Icon(Icons.group),
            onTap: () {
              showAllCallback();
              Navigator.of(context).pop();
            },
          ),
          Spacer(),
          ListTile(
            title: const Text('Log out'),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.of(context).pop();
              AuthManager.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
