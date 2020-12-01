import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValoracionesProvider extends ChangeNotifier {
  List<Valoriacion> valoraciones;

  final db = DataBase();

  loadingValoraciones(String tema) async {
    try {
      final result = await db.getValoraciones(tema);
      valoraciones = [];
      valoraciones.addAll(result);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addValoracion(Valoriacion valoriacion) {
    if (valoraciones == null) {
      valoraciones = [];
    }
    valoraciones.add(valoriacion);
    notifyListeners();
  }

  bool buscarValoracion(String estId) {
    for (Valoriacion valoracion in valoraciones) {
      // if (valoracion.estId == estId) return true;
    }
    return false;
  }

  static ValoracionesProvider of(BuildContext context) =>
      Provider.of<ValoracionesProvider>(context, listen: false);
}
