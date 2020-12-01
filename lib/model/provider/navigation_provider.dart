import 'package:cuaderno_pedagogico/data/screen.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';

import 'package:cuaderno_pedagogico/pages/tab/call_list/call_list_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/add_tema_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/calificar_tema.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/centralizador_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/estadistica_talla_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/funciones_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/lista_estudiantes_calificar.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/temas_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/trimestre_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/valoracion_anual_by_estudiante_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/valoracion_anual_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/valorar_estudiante_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/valoraracion_trimestral_page.dart';

import 'package:cuaderno_pedagogico/pages/tab/utilitarios/listar_indicadores.dart';
import 'package:cuaderno_pedagogico/pages/tab/utilitarios/registro_estudiantes_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/utilitarios/registro_indicador_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/utilitarios/utilitarios_page.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

const FUNCIONES_PAGE = 0;
const CALL_LIST = 1;
const REGISTER_PAGE = 2;

class NavigationProvider extends ChangeNotifier {
  int _currentScreenIndex = FUNCIONES_PAGE;

  int get currentTabIndex => _currentScreenIndex;
  List<Screen> get screens => _screens.values.toList();
  Screen get currentScreen => _screens[_currentScreenIndex];

  void setTab(int tab) {
    if (tab == currentTabIndex) {
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  void clearNavigator() {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    currentNavigatorState.pushNamedAndRemoveUntil(
        currentScreen.initialRoute, (route) => false);
  }

  Future<bool> onWillPop() async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FUNCIONES_PAGE) {
        setTab(FUNCIONES_PAGE);
        // notifyListeners();
        return false;
      } else {
        return true;
      }
    }
  }

  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  final Map<int, Screen> _screens = {
    FUNCIONES_PAGE: Screen(
      child: FuncionesPage(),
      navigatorState: GlobalKey<NavigatorState>(),
      initialRoute: AppRoutes.report,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.temas:
            return MaterialPageRoute(builder: (_) => TemasPage());
          case AppRoutes.addTema:
            return MaterialPageRoute<Tema>(builder: (_) => AddTemaPage());
          case AppRoutes.calificarTema:
            return MaterialPageRoute(builder: (_) => CalificarTemaPage());
          case AppRoutes.valorarEstudiante:
            return MaterialPageRoute(
                builder: (_) => ValorarEstudiantePage(
                      arguments: settings.arguments,
                    ));
          case AppRoutes.listaEstudiantesCalificar:
            return MaterialPageRoute(
                builder: (_) => ListaEstudiantesCalificar(
                      tema: settings.arguments,
                    ));
          case AppRoutes.trimestres:
            return MaterialPageRoute(builder: (_) => TrimestresPage());
          case AppRoutes.centralizador:
            return MaterialPageRoute(
                builder: (_) =>
                    CentralizadorPage(argumenst: settings.arguments));
          case AppRoutes.valoracionTrimestral:
            return MaterialPageRoute(
                builder: (_) =>
                    ValoracionTrimestralPage(arguments: settings.arguments));
          case AppRoutes.cuadroEdades:
            return MaterialPageRoute(builder: (_) => CuadroEdadesPage());
          case AppRoutes.valoracionAnual:
            return MaterialPageRoute(builder: (_) => ValoracionAnualPage());
          case AppRoutes.valoracionAnualByEstudiante:
            return MaterialPageRoute(
                builder: (_) => ValoracionAnualByEstudiante(
                      estudiante: settings.arguments,
                    ));
          default:
            return MaterialPageRoute(builder: (_) => FuncionesPage());
        }
      },
    ),
    CALL_LIST: Screen(
      child: CallListPage(),
      navigatorState: GlobalKey<NavigatorState>(),
      initialRoute: AppRoutes.callList,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // case '':
          //   break;
          default:
            return MaterialPageRoute(builder: (_) => CallListPage());
        }
      },
    ),
    REGISTER_PAGE: Screen(
      child: UtilitariosPage(),
      navigatorState: GlobalKey<NavigatorState>(),
      initialRoute: AppRoutes.register,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.registroEstudiantes:
            return MaterialPageRoute(builder: (_) => RegitroEstudiantesPage());
          case AppRoutes.registroIndicador:
            return MaterialPageRoute(builder: (_) => RegistroIndicadorPage());
          case AppRoutes.listarIndicadores:
            return MaterialPageRoute(builder: (_) => ListarIndicadores());
          default:
            return MaterialPageRoute(builder: (_) => UtilitariosPage());
        }
      },
    ),
  };
}
