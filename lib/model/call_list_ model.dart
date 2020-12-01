import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/data/asistencia.dart';
import 'package:cuaderno_pedagogico/data/user.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/material.dart';

class CallListModel extends ChangeNotifier {
  List<Asistencia> listAsistencia = [];

  final db = DataBase();
  final date = Static.format.format(DateTime.now());
  loadListAistencia() async {
    try {
      final response = await db.getAsistencias(date);
      listAsistencia = [];
      listAsistencia.addAll(response);
      notifyListeners();
    } catch (e) {
      print(e);
      listAsistencia = [];
      notifyListeners();
    }
  }

  addAsistente(Asistencia asistencia) {
    listAsistencia.add(asistencia);
    notifyListeners();
  }

  replaceAsistente(Asistencia asistencia, int index) {
    listAsistencia.removeAt(index);
    listAsistencia.insert(index, asistencia);
    notifyListeners();
  }

  Future<void> createAsistencia(String estId, String tipo, int existe) async {
    try {
      Asistencia asistencia = Asistencia(
          date: date, dateTime: DateTime.now(), estId: estId, tipo: tipo);
      await db.createAsistencia(asistencia);
      if (existe == null)
        this.addAsistente(asistencia);
      else
        this.replaceAsistente(asistencia, existe);
    } catch (e) {
      print(e);
    }
  }

  int buscarAsistencia(User user) {
    for (int i = 0; i < listAsistencia.length; i++) {
      if (user.userId == listAsistencia[i].estId) {
        return i;
      }
    }
    return null;
  }
}
