import 'package:cuaderno_pedagogico/config/static.dart';
import 'package:cuaderno_pedagogico/data/indicador.dart';
import 'package:cuaderno_pedagogico/model/provider/indicadores_provider.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/button_green.dart';
import 'package:flutter/material.dart';
import '../../../services/string_validator.dart' as str;

class RegistroIndicadorPage extends StatefulWidget {
  @override
  _RegistroIndicadorPageState createState() => _RegistroIndicadorPageState();
}

class _RegistroIndicadorPageState extends State<RegistroIndicadorPage> {
  String campo;
  int intCampo;
  final indicadorController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onTapDone() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoading(context);

      try {
        final dataBase = DataBase();
        Indicador indicador =
            Indicador(campo: campo, nombre: indicadorController.text.trim());
        String id = await dataBase.createIndicador(indicador);
        Navigator.of(context).pop();
        indicador.id = id;
        final model = IndicadoresProvider.of(context);
        model.addIndicador(indicador);
      } catch (e) {
        print(e);
        Navigator.pop(context);
      } finally {}
    }
  }

  @override
  void initState() {
    indicadorController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro Indicador')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                    disabledHint: Text(campo ?? ''),
                    decoration:
                        InputDecoration(hintText: 'Campo', labelText: 'Campo'),
                    items: [
                      for (int i = 0; i < Static.campos.length; i++)
                        DropdownMenuItem<int>(
                            value: i, child: Text(Static.campos[i]))
                    ],
                    value: intCampo,
                    onSaved: (value) {
                      setState(() {
                        campo = Static.campos[value];
                      });
                    },
                    validator: (value) => str.validatorSelect(value, 'Campo')
                    // autofocus: true,,
                    ,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      setState(() {
                        intCampo = value;
                      });
                    }),
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: indicadorController,
                  decoration: InputDecoration(labelText: 'Indicador'),
                  // onSaved: (value) {
                  //   model.phoneNumber = value;
                  // },
                  validator: (value) => str.validator(value, 'Indicador'),
                  textInputAction: TextInputAction.next,

                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 32,
                ),
                ButtonGreen(
                  onTap: _onTapDone,
                  title: 'Registrar!',
                ),
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
