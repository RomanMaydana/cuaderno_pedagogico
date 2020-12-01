import 'package:cuaderno_pedagogico/config/theme.dart';
import 'package:cuaderno_pedagogico/data/user.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/pages/tab/call_list/call_list_page.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:flutter/material.dart';

class ValoracionAnualByEstudiante extends StatefulWidget {
  final User estudiante;

  const ValoracionAnualByEstudiante({Key key, this.estudiante})
      : super(key: key);

  @override
  _ValoracionAnualByEstudianteState createState() =>
      _ValoracionAnualByEstudianteState();
}

class _ValoracionAnualByEstudianteState
    extends State<ValoracionAnualByEstudiante> {
  final formKey = GlobalKey<FormState>();
  final dataBase = DataBase();
  List<ValoracionTrimestral> valTrim;
  final anualController = TextEditingController();
  @override
  void initState() {
    loadignValoracionAnual();
    loadingValoraciones();
    super.initState();
  }

  loadignValoracionAnual() async {
    try {
      final result =
          await dataBase.getValoracionAnualByEst(widget.estudiante.userId);
      anualController.text = result;
    } catch (e) {
      print(e);
    }
  }

  loadingValoraciones() async {
    try {
      final result =
          await dataBase.getValTrimByEstudiante(widget.estudiante.userId);
      valTrim = [];
      valTrim.addAll(result);
      setState(() {});
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) {
            return Alert(title: 'Ocurrió un error', content: '');
          });
    }
  }

  Widget _buildValoracion(int trim) {
    for (ValoracionTrimestral val in valTrim) {
      if (val.trimestre == trim) return Text(val.valoracion);
    }
    return Text('El trimestre no fue valorado aún.');
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.estudiante.nombre),
      ),
      body: valTrim == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : valTrim.isEmpty
              ? Center(
                  child: Text('No tiene valoraciones'),
                )
              : Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('1er Trimestre',
                            style: Theme.of(context).textTheme.bodyText1),
                        _buildValoracion(1),
                        const SizedBox(
                          height: 32,
                        ),
                        Text('2do Trimestre',
                            style: Theme.of(context).textTheme.bodyText1),
                        _buildValoracion(2),
                        const SizedBox(
                          height: 32,
                        ),
                        Text('3er Trimestre',
                            style: Theme.of(context).textTheme.bodyText1),
                        _buildValoracion(3),
                        const SizedBox(
                          height: 32,
                        ),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: anualController,
                            decoration: InputDecoration(
                                hintText:
                                    'Regitre su valoración anual del estudiante tomando en cuenta las valoraciones trimestrales'),
                            minLines: 5,
                            maxLines: 5,
                            maxLength: 250,
                            validator: (value) {
                              if (value.trim().isEmpty)
                                return 'Debes anotar una valoración';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ButtonGreen(
                            onTap: valTrim.length > 3
                                ? () async {
                                    if (formKey.currentState.validate()) {
                                      showLoading(context);
                                      try {
                                        await dataBase
                                            .createValoracionTrimestral(
                                                ValoracionTrimestral(
                                                    idEstudiante: widget
                                                        .estudiante.userId,
                                                    valoracion: anualController
                                                        .text
                                                        .trim()));
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Alert(
                                                title: 'Registro Exitoso',
                                                content:
                                                    'La valoración fue registrada',
                                              );
                                            });
                                      } catch (e) {
                                        print(e);
                                      } finally {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                : null,
                            title: 'Valorar!',
                          ),
                        ),
                        SizedBox(
                          height: bottom,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
