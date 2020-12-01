import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/model/provider/indicadores_provider.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/alert_app.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:cuaderno_pedagogico/widget/item_row_indicador.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/string_validator.dart' as str;

class AddTemaPage extends StatefulWidget {
  @override
  _AddTemaPageState createState() => _AddTemaPageState();
}

class _AddTemaPageState extends State<AddTemaPage> {
  final nombreController = TextEditingController();
  final descripController = TextEditingController();
  final fechaInicioController = TextEditingController();
  final fechaFinController = TextEditingController();
  int trimestre;
  final _formKey = GlobalKey<FormState>();
  List<String> list = [];
  DateTime dateTimeI;
  DateTime dateTimeF;
  void _onTapDone() async {
    if (list.length == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return Alert(
            title: 'Sin indicadores',
            content: 'Elija al menos un Indicador',
          );
        },
      );
      return;
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoading(context);
      try {
        final dataBase = DataBase();
        Tema tema = Tema(
            create: DateTime.now(),
            descripcion: descripController.text.trim(),
            fechaFin: dateTimeF,
            fechaInicio: dateTimeI,
            identificadores: list,
            nombre: nombreController.text.trim(),
            trimestre: trimestre + 1);
        await dataBase.createTema(tema);
        Navigator.pop(context);
        Navigator.pop(context, tema);
      } catch (e) {
        print(e);
        Navigator.pop(context);
      } finally {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Tema'),
        actions: [
          FlatButton(
              onPressed: _onTapDone,
              child: Text(
                'Registrar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Título del Tema',
                  ),
                  // onSaved: (value) {
                  //   model.fullName = value;
                  // },
                  validator: (value) => str.validator(value, 'Título del Tema'),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descripController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  // onSaved: (value) {
                  //   model.password = value;
                  // },
                  validator: (value) => str.validator(value, 'Descripción'),
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  // textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: fechaInicioController,
                          decoration:
                              InputDecoration(labelText: 'Fecha inicio'),
                          // onSaved: (value) {
                          //   model.password = value;
                          // },
                          validator: (value) =>
                              str.validator(value, 'Fecha inicio'),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (d) {},
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2021));
                            if (date != null) {
                              fechaInicioController.text =
                                  Static.formatP.format(date).toString();
                              dateTimeI = date;
                              setState(() {});
                            }
                          }),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: fechaFinController,
                          decoration: InputDecoration(labelText: 'Fecha fin'),
                          // onSaved: (value) {
                          //   model.password = value;
                          // },
                          validator: (value) =>
                              str.validator(value, 'Fecha fin'),
                          keyboardType: TextInputType.text,
                          onChanged: (d) {},
                          onTap: () async {
                            DateTime date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2021));
                            if (date != null) {
                              fechaFinController.text =
                                  Static.formatP.format(date).toString();
                              dateTimeF = date;
                              setState(() {});
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<int>(
                    disabledHint: Text('$trimestre' ?? ''),
                    decoration: InputDecoration(
                        hintText: 'Trimestre', labelText: 'Trimestre'),
                    items: [
                      for (int i = 0; i < Static.trimestres.length; i++)
                        DropdownMenuItem<int>(
                            value: i, child: Text(Static.trimestres[i]))
                    ],
                    value: trimestre,
                    onSaved: (value) => trimestre = value,
                    validator: (value) =>
                        str.validatorSelect(value, 'Trimestre'),
                    // autofocus: true,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      trimestre = value;
                      setState(() {});
                    }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Seleccione Indicadores para el tema',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    IconButton(
                        icon: Icon(CupertinoIcons.refresh_circled),
                        onPressed: () {})
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Consumer<IndicadoresProvider>(
                  builder: (_, model, __) {
                    return model.indicadores != null
                        ? model.indicadores.length != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: model.indicadores.map((indicador) {
                                  bool contain = list.contains(indicador.id);
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: ItemRowIndicador(
                                      onTap: () {
                                        if (contain) {
                                          list.remove(indicador.id);
                                        } else {
                                          list.add(indicador.id);
                                        }
                                        setState(() {});
                                      },
                                      title: indicador.nombre,
                                      border: contain,
                                    ),
                                  );
                                }).toList())
                            : Text('Agrege al menos algun indicador')
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                // SizedBox(
                //   height: 35,
                // ),
                // ButtonGreen(
                //   onTap: _onTapDone,
                //   title: 'Registrar!',
                // ),
                SizedBox(height: MediaQuery.of(context).padding.bottom
                    // 200,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
