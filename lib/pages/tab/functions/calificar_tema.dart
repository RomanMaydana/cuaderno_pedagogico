import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/model/provider/valoraciones_provider.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/widget/item_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalificarTemaPage extends StatefulWidget {
  @override
  _CalificarTemaPageState createState() => _CalificarTemaPageState();
}

class _CalificarTemaPageState extends State<CalificarTemaPage> {
  final model = TemasModel();
  @override
  void initState() {
    model.loadingTemas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elige el tema a calificar'),
      ),
      body: AnimatedBuilder(
          animation: model,
          builder: (_, __) {
            return model.temas != null
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: model.temas.length,
                    itemBuilder: (_, index) {
                      final tema = model.temas[index];
                      return GestureDetector(
                        onTap: () {
                          // final model = ValoracionesProvider.of(context);
                          // model.loadingValoraciones(tema.nombre);
                          Navigator.pushNamed(
                              context, AppRoutes.listaEstudiantesCalificar,
                              arguments: tema);
                        },
                        child: ItemTema(
                          tema: tema,
                          options: false,
                        ),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class TemasModel extends ChangeNotifier {
  List<Tema> temas;
  final db = DataBase();

  loadingTemas() async {
    try {
      final result = await db.getTemas();
      if (temas == null) {
        temas = [];
      }
      temas.addAll(result);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addTema(Tema tema) {
    temas.insert(0, tema);
    notifyListeners();
  }
}
