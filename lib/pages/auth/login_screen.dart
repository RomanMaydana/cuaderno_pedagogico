import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/model/auth_model.dart';
import 'package:cuaderno_pedagogico/model/provider/user_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/auth.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/string_validator.dart' as str;

class LoginPage extends StatefulWidget {
  // final loginModel  = LoginModel();
  final int toTab;

  const LoginPage({Key key, this.toTab}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final model = AuthModel();
  final _formKey = GlobalKey<FormState>();

  void _onTapLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final email = model.email.trim();
      final password = model.password;

      final auth = Auth();
      final database = DataBase();
      model.setIsLoading();
      // showLoading(context);
      try {
        final userId = await auth.signInWithEmailAndPassword(email, password);
        final user = await database.getUser(userId);

        final userProvider = UserProvider.of(context);
        userProvider.user = user;
        if (user.rol == 'profesor') {
          Navigator.pushReplacementNamed(context, AppRoutes.splash);
          // add user at provider
        } else {
          // await auth.signOut();
          Navigator.pushReplacementNamed(context, AppRoutes.homeEstudiante);
        }
      } on FirebaseAuthException catch (e) {
        // showDialog(
        //     context: context,
        //     builder: (_) =>
        //         Alert(title: 'Failed To Login', content: e.message));
      } catch (e) {
        print(e);
        // showDialog(
        //     context: context,
        //     builder: (_) =>
        //         Alert(title: 'Failed To Login', content: e.toString()));
      } finally {
        model.setIsLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final styleTitle = TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 16,
        letterSpacing: 0.6,
        fontWeight: FontWeight.bold);

    final styleLabel = TextStyle(
        fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.blackLabel);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(11))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
              child: AnimatedBuilder(
                  animation: model,
                  builder: (_, __) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                          inputDecorationTheme: InputDecorationTheme(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: AppColors.green,
                                      width: 2,
                                      style: BorderStyle.solid)))),
                      child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Por favor inicie sesión',
                                    style: styleTitle,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 42,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: styleLabel,
                              ),
                            ),
                            TextFormField(
                              onSaved: (value) {
                                model.email = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) => str.validatorEmail(value),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.outlineColorBorder),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Password',
                                style: styleLabel,
                              ),
                            ),
                            TextFormField(
                              onSaved: (value) {
                                model.password = value;
                              },
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor),
                              validator: (value) =>
                                  str.validator(value, 'Password'),
                              obscureText: !model.showPassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.outlineColorBorder),
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: model.showPassword
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).disabledColor,
                                    ),
                                    onPressed: () => model.setShowPassword()),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Container(
                            //   alignment: Alignment.bottomRight,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.pushNamed(
                            //           context, '/forgot_your_password');
                            //     },
                            //     child: Container(
                            //       color: Colors.transparent,
                            //       child: Text(
                            //         'Forgot your password?',
                            //         textAlign: TextAlign.end,
                            //         style: TextStyle(
                            //             color: Theme.of(context).accentColor,
                            //             decoration: TextDecoration.underline),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                switchInCurve: Curves.easeIn,
                                child: !model.isLoading
                                    ? ButtonGreen(
                                        title: 'INICIAR SESIÓN',
                                        onTap: _onTapLogin,
                                      )
                                    : CircularProgressIndicator()),
                            SizedBox(
                              height: 22,
                            ),
                          ]),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
