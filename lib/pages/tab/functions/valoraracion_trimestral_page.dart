import 'dart:math';

import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/data/user.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/model/provider/indicadores_provider.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValoracionTrimestralPage extends StatefulWidget {
  final ValoracionTrimestralArguments arguments;

  ValoracionTrimestralPage({Key key, this.arguments}) : super(key: key);

  @override
  _ValoracionTrimestralPageState createState() =>
      _ValoracionTrimestralPageState();
}

class _ValoracionTrimestralPageState extends State<ValoracionTrimestralPage> {
  bool valoraciones = false;
  var rng = new Random();
  final dataBase = DataBase();
  final formKey = GlobalKey<FormState>();
  final valoracionController = TextEditingController();
  @override
  void initState() {
    print(widget.arguments.temas.length);
    loadingValoraciones();
    loadignValoracionTrimestral();
    super.initState();
  }

  loadignValoracionTrimestral() async {
    try {
      final result = await dataBase.getValoracionTrimestralByIdYTrimestre(
          widget.arguments.estudiante.userId, widget.arguments.trimestre);
      valoracionController.text = result;
    } catch (e) {
      print(e);
    }
  }

  loadingValoraciones() async {
    try {
      final list = <Valoriacion>[];
      for (int i = 0; i < widget.arguments.temas.length; i++) {
        final result = await dataBase.getValoranByTemaYEstudiante(
          widget.arguments.temas[i],
          widget.arguments.estudiante.userId,
        );
        widget.arguments.temas[i].valoriacion = result;

        list.add(result);
      }
      valoraciones = true;
      setState(() {});
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) {
            return Alert(title: 'Ocurrió un error', content: e.toString());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text('Valoración Trimestral'),
      ),
      body: !valoraciones
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estudiante'),
                        Text(
                          widget.arguments.estudiante.nombre,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ...widget.arguments.temas.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tema'),
                              Expanded(
                                child: Text(
                                  e.nombre,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context).textTheme.headline6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: e.valoriacion.ponderacion.map((pond) {
                              final r = rng.nextInt(3) + 1;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    border: Border.all(
                                        width: 0.5, color: Colors.black)),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Consumer<IndicadoresProvider>(
                                          builder: (_, model, __) {
                                        return Text(
                                          '${model.getNameById(pond.idIdentificador)}',
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      }),
                                    ),
                                    Text(pond.valor)
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    }).toList(),
                    const SizedBox(
                      height: 32,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Valora al Estudiante',
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: valoracionController,
                        // initialValue:
                        //     "Demuestra el hábito del aseo personal como también práctica los  cuidados del cuerpo humano  y aprende la canción \"voy a dibujar mi cuerpo\", sin embargo;  debe fortalecer el cuidado de su cuerpo en los diferentes juegos",
                        decoration: InputDecoration(
                            hintText:
                                'Valoración del trimestre según los temas avanzados'),
                        maxLines: null,
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
                        onTap: () async {
                          if (formKey.currentState.validate()) {
                            showLoading(context);
                            try {
                              await dataBase.createValoracionTrimestral(
                                  ValoracionTrimestral(
                                      idEstudiante:
                                          widget.arguments.estudiante.userId,
                                      trimestre: widget.arguments.trimestre,
                                      valoracion:
                                          valoracionController.text.trim()));
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Alert(
                                      title: 'Registro Exitoso',
                                      content: 'La valoración fue registrada',
                                    );
                                  });
                            } catch (e) {
                              print(e);
                            } finally {
                              Navigator.pop(context);
                            }
                          }
                        },
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

class ValoracionTrimestralArguments {
  final List<Tema> temas;
  final User estudiante;
  final int trimestre;
  ValoracionTrimestralArguments({this.temas, this.estudiante, this.trimestre});
}
