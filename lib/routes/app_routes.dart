import 'package:cuaderno_pedagogico/pages/auth/login_screen.dart';
import 'package:cuaderno_pedagogico/pages/home_estudiante_page.dart';
import 'package:cuaderno_pedagogico/pages/home_profesor_page.dart';

import 'package:cuaderno_pedagogico/pages/splash_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/tab.dart';
import 'package:cuaderno_pedagogico/pages/tab/utilitarios/registro_estudiantes_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String report = '/report';
  static const String callList = '/call_list';
  static const String register = '/register';
  static const String registroEstudiantes = '/registro_estudiantes';
  static const String homeProfesor = '/home_profesor';
  static const String homeEstudiante = '/home_estudiante';

  static const String tab = '/Tab';
  static const String registroIndicador = '/registro_indicador';
  static const String listarIndicadores = '/listar_indicadores';
  static const String temas = '/temas';
  static const String addTema = '/add_tema';
  static const String calificarTema = '/calificar_tema';
  static const String listaEstudiantesCalificar =
      '/lista_estudiantes_calificar';
  static const String valorarEstudiante = '/valorar_estudiante';
  static const String trimestres = '/trimestres';
  static const String centralizador = '/centralizador';
  static const String valoracionTrimestral = '/valoracion_trimestral';
  static const String valoracionAnual = '/valoracion_anual';
  static const String valoracionAnualByEstudiante =
      '/valoracion_anual_estudiante';
  static const String cuadroEdades = '/cuadro_edades';

  static final routes = {
    splash: (_) => SplashPage(),
    login: (_) => LoginPage(),
    registroEstudiantes: (_) => RegitroEstudiantesPage(),
    tab: (_) => Tab(),
    homeProfesor: (_) => HomeProfesorPage(),
    homeEstudiante: (_) => HomeEstudiantePage(),
  };
}
