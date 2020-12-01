import 'package:cuaderno_pedagogico/model/provider/user_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = UserProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              model.user.nombre,
              style: Theme.of(context).textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Temas'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Filiar Estudiantes'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.registroEstudiantes);
            },
          )
        ],
      ),
    );
  }
}
