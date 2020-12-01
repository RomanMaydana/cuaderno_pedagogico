import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:flutter/material.dart';

import 'calificar_tema.dart';
import 'centralizador_page.dart';

class TrimestresPage extends StatefulWidget {
  @override
  _TrimestresPageState createState() => _TrimestresPageState();
}

class _TrimestresPageState extends State<TrimestresPage> {
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
        title: Text('Seleccione el trimestre'),
      ),
      body: model == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    final temas = model.temas
                        ?.where((element) => element.trimestre == 1)
                        ?.toList();
                    if (temas.isNotEmpty)
                      Navigator.of(context).pushNamed(AppRoutes.centralizador,
                          arguments: CentralizadorArgumenst(
                              temas: temas, trimestre: 1));
                    else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Alert(
                                title: "Error en temas",
                                content:
                                    "No se registro temas para el trimestre");
                          });
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      color: Colors.lightBlue,
                      child: Text(
                        '1er trimestre',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      final temas = model.temas
                          ?.where((element) => element.trimestre == 2)
                          ?.toList();
                      if (temas.isNotEmpty)
                        Navigator.of(context).pushNamed(AppRoutes.centralizador,
                            arguments: CentralizadorArgumenst(
                                temas: temas, trimestre: 2));
                      else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Alert(
                                  title: "Error en temas",
                                  content:
                                      "No se registro temas para el trimestre");
                            });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      color: Colors.lightGreen,
                      child: Text(
                        '2do trimestre',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      final temas = model.temas
                          ?.where((element) => element.trimestre == 3)
                          ?.toList();
                      if (temas.isNotEmpty)
                        Navigator.of(context).pushNamed(AppRoutes.centralizador,
                            arguments: CentralizadorArgumenst(
                                temas: temas, trimestre: 3));
                      else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Alert(
                                  title: "Error en temas",
                                  content:
                                      "No se registro temas para el trimestre");
                            });
                      }
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      color: Colors.amber,
                      child: Text(
                        '3er trimestre',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
