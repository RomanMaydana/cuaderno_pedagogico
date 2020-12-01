import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/data/asistencia.dart';
import 'package:cuaderno_pedagogico/model/call_list_%20model.dart';
import 'package:cuaderno_pedagogico/model/provider/list_estudiantes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallListPage extends StatefulWidget {
  @override
  _CallListPageState createState() => _CallListPageState();
}

class _CallListPageState extends State<CallListPage> {
  final model = CallListModel();
  final date = Static.formatP.format(DateTime.now());
  @override
  void initState() {
    model.loadListAistencia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Asistencia ${date}'),
      ),
      body: Consumer<ListaEstudiantesProvider>(
        builder: (_, estudiantesModel, __) {
          return estudiantesModel.estudiantes != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    await estudiantesModel.loadingEstudiantes();
                    model.loadListAistencia();
                  },
                  child: AnimatedBuilder(
                      animation: model,
                      builder: (_, __) {
                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (_, index) {
                            final estudiante =
                                estudiantesModel.estudiantes[index];
                            final llamoLista =
                                model.buscarAsistencia(estudiante);
                            var tipo;
                            if (llamoLista != null)
                              tipo = model.listAsistencia[llamoLista].tipo;
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                      width: 0.5, color: Colors.black)),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${estudiante.nroLista}. ${estudiante.nombre}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  ButtonAsistencia(
                                    color: AppColors.green,
                                    letra: 'P',
                                    llamoLista: tipo == "P",
                                    onTap: () async {
                                      print('p');
                                      await model.createAsistencia(
                                          estudiante.userId, "P", llamoLista);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ButtonAsistencia(
                                    color: Colors.lightBlue,
                                    letra: 'L',
                                    llamoLista: tipo == "L",
                                    onTap: () async {
                                      await model.createAsistencia(
                                          estudiante.userId, "L", llamoLista);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ButtonAsistencia(
                                    color: Colors.orange,
                                    letra: 'A',
                                    llamoLista: tipo == "A",
                                    onTap: () async {
                                      await model.createAsistencia(
                                          estudiante.userId, "A", llamoLista);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ButtonAsistencia(
                                    color: Colors.red,
                                    letra: 'F',
                                    llamoLista: tipo == "F",
                                    onTap: () async {
                                      await model.createAsistencia(
                                          estudiante.userId, "F", llamoLista);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: estudiantesModel.estudiantes.length,
                          separatorBuilder: (_, __) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
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

class ButtonAsistencia extends StatelessWidget {
  final String letra;
  final VoidCallback onTap;
  final Color color;
  final bool llamoLista;
  const ButtonAsistencia(
      {Key key,
      @required this.letra,
      @required this.onTap,
      @required this.color,
      @required this.llamoLista})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        // width: 34,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: color.withOpacity(llamoLista ? 1 : 0.5)),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            letra,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
