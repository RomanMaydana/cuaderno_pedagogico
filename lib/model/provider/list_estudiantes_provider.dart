import 'package:cuaderno_pedagogico/data/user.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaEstudiantesProvider extends ChangeNotifier {
  List<User> estudiantes;
  final db = DataBase();

  Future<void> loadingEstudiantes() async {
    try {
      final result = await db.getEstudiantes();
      estudiantes = [];
      estudiantes.addAll(result);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  static ListaEstudiantesProvider of(BuildContext context) =>
      Provider.of(context, listen: false);
}
