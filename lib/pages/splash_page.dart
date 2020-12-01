import 'package:cuaderno_pedagogico/model/provider/user_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/auth.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1500), _onInit);
    super.initState();
  }

  void _onInit() async {
    // Navigator.pushReplacementNamed(context, RegPedRoutes.homeProfesor);
    // return;

    final auth = Auth();
    // await auth.reload();
    try {
      final logged = await auth.isLogged();
      if (logged) {
        final userAuth = auth.getUser();
        final dataBase = DataBase();
        final user = await dataBase.getUser(userAuth.uid);
        final model = UserProvider.of(context);
        model.user = user;
        if (user.rol == 'profesor') {
          Navigator.pushReplacementNamed(context, AppRoutes.tab);
          // add user at provider
        } else {
          // await auth.signOut();
          Navigator.pushReplacementNamed(context, AppRoutes.homeEstudiante);
        }
        return;
      }
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(height: 148, width: 148, child: FlutterLogo()

            //  Image.asset('images/logo.png')

            ),
        Text(
          'Registro Pedagógico',
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff343b4b),
              fontWeight: FontWeight.bold),
        ),
      ])),
    );
  }
}
