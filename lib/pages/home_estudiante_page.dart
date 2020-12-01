import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/auth.dart';
import 'package:flutter/material.dart';

class HomeEstudiantePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeEstudiantePage'),
        actions: [
          FlatButton(
              onPressed: () {
                final auth = Auth();
                auth.signOut();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Text('Salir')),
        ],
      ),
      body: Center(
        child: Text('Aún no hay registros concluidos por el profesor'),
      ),
    );
  }
}
