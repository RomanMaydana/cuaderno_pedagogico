import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:cuaderno_pedagogico/model/provider/navigation_provider.dart';
import 'package:cuaderno_pedagogico/model/provider/user_provider.dart';
import 'package:cuaderno_pedagogico/model/provider/valoraciones_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/theme.dart';
import 'model/provider/indicadores_provider.dart';

class RegPedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
            color: AppColors.lightGrey, width: 1, style: BorderStyle.solid));
    final _borderFocus = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
            color: AppColors.green, width: 2, style: BorderStyle.solid));
    final _borderError = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide:
            BorderSide(color: Colors.red, width: 2, style: BorderStyle.solid));

    final lightTheme = ThemeData(
        accentColor: AppColors.black,
        textTheme: TextTheme(
          headline5: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.09,
            color: AppColors.black,
          ),
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.07,
            color: AppColors.black,
          ),
          subtitle1: TextStyle(
            color: AppColors.blackTextInput,
            fontSize: 16,
            letterSpacing: 0.15,
          ),
          bodyText1: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.06,
          ),
          caption: TextStyle(
            color: AppColors.lightGrey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.05,
          ),
        ),
        scaffoldBackgroundColor: AppColors.lightScaffoldColor,
        primaryColor: AppColors.green,
        // buttonTheme: ButtonThemeData(

        //     ),
        inputDecorationTheme: InputDecorationTheme(
          // enabledBorder: _border,
          // border: _border,
          // enabledBorder: _border,

          errorBorder: _borderError,
          focusedErrorBorder: _borderError,
          disabledBorder: _border,
          focusedBorder: _borderFocus,
          enabledBorder: _border,

          // labelStyle: TextStyle(fontSize: 16, letterSpacing: 0.4),
        ),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(),
            elevation: 0.0,
            color: AppColors.lightScaffoldColor));
    final indicadoreProvider = IndicadoresProvider();
    indicadoreProvider.loadingIndicadores();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => indicadoreProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => ListaEstudiantesProvider()..loadingEstudiantes(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => ValoracionesProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.splash,
        theme: lightTheme,
      ),
    );
  }
}
