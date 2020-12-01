import 'package:cuaderno_pedagogico/data/indicador.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndicadoresProvider extends ChangeNotifier {
  List<Indicador> indicadores;
  final db = DataBase();
  void loadingIndicadores() async {
    try {
      final result = await db.getIndicadores();

      indicadores = [];

      indicadores.addAll(result);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getNameById(String id) {
    if (indicadores == null) return '';
    for (Indicador item in indicadores) {
      if (item.id == id) return item.nombre;
    }
    return 'Indicador';
  }

  void addIndicador(Indicador indicador) {
    if (indicadores == null) {
      indicadores = [];
    }
    indicadores.add(indicador);
    notifyListeners();
  }

  static IndicadoresProvider of(BuildContext context) =>
      Provider.of<IndicadoresProvider>(context, listen: false);
}
