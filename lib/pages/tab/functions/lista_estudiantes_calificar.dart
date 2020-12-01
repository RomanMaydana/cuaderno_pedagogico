import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/data/indicador.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:cuaderno_pedagogico/model/provider/valoraciones_provider.dart';
import 'package:cuaderno_pedagogico/pages/tab/call_list/call_list_page.dart';
import 'package:cuaderno_pedagogico/pages/tab/functions/valorar_estudiante_page.dart';
import 'package:cuaderno_pedagogico/routes/app_routes.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calificar_tema.dart';

class ListaEstudiantesCalificar extends StatefulWidget {
  final Tema tema;

  const ListaEstudiantesCalificar({Key key, this.tema}) : super(key: key);

  @override
  _ListaEstudiantesCalificarState createState() =>
      _ListaEstudiantesCalificarState();
}

class _ListaEstudiantesCalificarState extends State<ListaEstudiantesCalificar> {
  final dataBase = DataBase();
  final indicadores = <Indicador>[];
  @override
  void initState() {
    loadingIndicadores();
    super.initState();
  }

  loadingIndicadores() async {
    try {
      for (String item in widget.tema.identificadores) {
        final indicador = await dataBase.getIndicadorById(item);
        indicadores.add(indicador);
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.tema.nombre}',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [],
      ),
      body: Consumer<ListaEstudiantesProvider>(
        builder: (_, estudiantesModel, __) {
          return estudiantesModel.estudiantes != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    await estudiantesModel.loadingEstudiantes();
                    loadingIndicadores();
                  },
                  child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (_, index) {
                        final estudiante = estudiantesModel.estudiantes[index];
                        // final fueValorado = valoracionesModel
                        //     .buscarValoracion(estudiante.userId);

                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border:
                                  Border.all(width: 0.5, color: Colors.black)),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${estudiante.nroLista}. ${estudiante.nombre}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              indicadores.length ==
                                      widget.tema.identificadores.length
                                  ? ButtonAsistencia(
                                      color: AppColors.green,
                                      letra: 'Valorar',
                                      llamoLista: true,
                                      onTap: () async {
                                        Navigator.pushNamed(context,
                                            AppRoutes.valorarEstudiante,
                                            arguments:
                                                ValorarEstudianteArguments(
                                                    tema: widget.tema,
                                                    estudiante: estudiante,
                                                    indicadores: indicadores));
                                      },
                                    )
                                  : Container(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator()),
                            ],
                          ),
                        );
                      },
                      itemCount: estudiantesModel.estudiantes.length,
                      separatorBuilder: (_, __) {
                        return const SizedBox(
                          height: 16,
                        );
                      }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
