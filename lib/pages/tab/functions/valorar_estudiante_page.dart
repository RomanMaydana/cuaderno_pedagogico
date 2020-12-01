import 'package:cuaderno_pedagogico/data/indicador.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:flutter/material.dart';
import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/data/user.dart';
import '../../../services/string_validator.dart' as str;

class ValorarEstudiantePage extends StatefulWidget {
  final ValorarEstudianteArguments arguments;
  ValorarEstudiantePage({Key key, this.arguments}) : super(key: key);

  @override
  _ValorarEstudiantePageState createState() => _ValorarEstudiantePageState();
}

class _ValorarEstudiantePageState extends State<ValorarEstudiantePage> {
  List<String> valorariones;

  final _formKey = GlobalKey<FormState>();
  final dataBase = DataBase();
  @override
  void initState() {
    valorariones = List(widget.arguments.tema.identificadores.length);

    super.initState();
  }

  void _onTapDone() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(valorariones);
      final listPonderacion = <Ponderacion>[];
      for (int i = 0; i < widget.arguments.tema.identificadores.length; i++) {
        listPonderacion.add(Ponderacion(
            idIdentificador: widget.arguments.tema.identificadores[i],
            valor: valorariones[i]));
      }
      final valoracion = Valoriacion(
          idEstudiante: widget.arguments.estudiante.userId,
          idTema: widget.arguments.tema.docSnapshot.id,
          trimestre: widget.arguments.tema.trimestre,
          ponderacion: listPonderacion);

      showLoading(context);
      try {
        await dataBase.createValoracion(valoracion);
        Navigator.pop(context);
      } catch (e) {
        print(e);
      } finally {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = widget.arguments.tema;
    final identificadores = widget.arguments.tema.identificadores;
    final estudiante = widget.arguments.estudiante;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Valoración ${estudiante.genero == 'Masculino' ? 'del' : 'de la'} Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.arguments.estudiante.nombre,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Valora todos los indicadores del tema ${tema.nombre}',
                // style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 16,
              ),
              for (int i = 0; i < widget.arguments.indicadores.length; i++)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(width: 0.5, color: Colors.black)),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        widget.arguments.indicadores[i].nombre,
                        // overflow: TextOverflow.ellipsis,
                      )),
                      Container(
                        width: 90,
                        height: 40,
                        child: DropdownButtonFormField<String>(
                            disabledHint: Text(valorariones[i] ?? ''),
                            decoration: InputDecoration(
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                hintText: 'Valor',
                                labelText: 'Valor'),
                            items: Static.valoraciones
                                .map((e) => DropdownMenuItem<String>(
                                    value: e, child: Text(e)))
                                .toList(),
                            value: valorariones[i],
                            onSaved: (value) => valorariones[i] = value,
                            validator: (value) =>
                                str.validatorSelectString(value, 'Valor'),
                            // autofocus: true,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {
                              valorariones[i] = value;
                              setState(() {});
                            }),
                      )
                    ],
                  ),
                ),
              const SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.center,
                child: ButtonGreen(
                  onTap: _onTapDone,
                  title: 'Valorar!',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ValorarEstudianteArguments {
  final Tema tema;
  final User estudiante;
  final List<Indicador> indicadores;
  ValorarEstudianteArguments({this.tema, this.estudiante, this.indicadores});
}
