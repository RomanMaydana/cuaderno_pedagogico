import 'dart:io';

import 'package:cuaderno_pedagogico/model/auth_model.dart';
import 'package:cuaderno_pedagogico/model/provider/user_provider.dart';
import 'package:cuaderno_pedagogico/model/registro_est_model.dart';
import 'package:cuaderno_pedagogico/services/auth.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:cuaderno_pedagogico/services/storage.dart';
import 'package:cuaderno_pedagogico/utils/show_loading.dart';
import 'package:cuaderno_pedagogico/widget/app_drawer.dart';
import 'package:cuaderno_pedagogico/widget/circle_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../config/static.dart';
import '../../../config/theme.dart';
import '../../../data/user.dart' as UserDB;

import '../../../services/image.dart' as image;
import '../../../services/string_validator.dart' as str;
import '../../../widget/button_green.dart';

class RegitroEstudiantesPage extends StatefulWidget {
  @override
  _RegitroEstudiantesPageState createState() => _RegitroEstudiantesPageState();
}

class _RegitroEstudiantesPageState extends State<RegitroEstudiantesPage> {
  final model = RegistroEstModel();
  final _formKey = GlobalKey<FormState>();

  void _onTapDone() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final email = model.emailController.text.trim();
      // final password = model.password;
      FocusScope.of(context).unfocus();
      final auth = Auth();
      final dataBase = DataBase();
      final storage = Storage();
      showLoading(context);
      try {
        if (model.file != null) {
          String url = await storage.addImage(model.file);
          model.urlImage = url;
        } else {
          return;
        }
        String userId = await auth.createUserWithEmailAndPassword(
            email, model.ciController.text.trim());
        model.userId = userId;

        final userModel = UserProvider.of(context);
        model.proferorId = userModel.user.userId;

        UserDB.User user = model.getUser;
        await dataBase.createUser(user);

        print('creado Correctamente');
      } on FirebaseAuthException catch (e) {
        print(e);
        // showDialog(
        //     context: context,
        //     builder: (_) =>
        //         Alert(title: 'Error Creating Account', content: e.message));
        // model.setIsLoading();
      } catch (e) {
        print(e);
        // showDialog(
        //     context: context,
        //     builder: (_) =>
        //         Alert(title: 'Error Creating Account', content: e.toString()));
        // model.setIsLoading();
      } finally {
        // model.setIsLoading();
        Navigator.pop(context);
      }
    }
  }

  void _selectImage(String tipo) async {
    try {
      File file = await image.getImage(tipo);

      if (file != null) {
        model.file = file;
        // Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  void _optionSelectImage() {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(11))),
        barrierColor: Colors.black.withOpacity(0.3),
        builder: (_) {
          return Wrap(
            children: [
              ListTile(
                onTap: () => _selectImage("camera"),
                title: Text('Camera'),
                trailing: Icon(Icons.camera),
              ),
              ListTile(
                onTap: () => _selectImage("galery"),
                title: Text('Galery'),
                trailing: Icon(Icons.photo_library_rounded),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: model,
        builder: (_, __) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Filiación de Estudiante',
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 32,
                                ),
                                CircleImage(
                                  onTap: _optionSelectImage,
                                  file: model.file,
                                  url: model.urlImage,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextFormField(
                                        controller: model.rudeController,
                                        decoration: InputDecoration(
                                          labelText: 'RUDE',
                                        ),
                                        // onSaved: (value) {
                                        //   model.fullName = value;
                                        // },
                                        validator: (value) =>
                                            str.validator(value, 'RUDE'),
                                        maxLength: 20,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: model.nroListaController,
                                        decoration: InputDecoration(
                                          labelText: 'Nro. Lista',
                                        ),
                                        // onSaved: (value) {
                                        //   model.fullName = value;
                                        // },
                                        maxLength: 2,
                                        validator: (value) =>
                                            str.validator(value, 'Nro. Lista'),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.ciController,
                                  decoration: InputDecoration(
                                    labelText: 'Cédula de Identidad',
                                  ),
                                  // onSaved: (value) {
                                  //   model.fullName = value;
                                  // },
                                  validator: (value) => str.validator(
                                      value, 'Cédula de Identidad'),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.nombreController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre',
                                  ),
                                  // onSaved: (value) {
                                  //   model.fullName = value;
                                  // },
                                  validator: (value) =>
                                      str.validator(value, 'Nombre'),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.lugarNacController,
                                  decoration: InputDecoration(
                                      labelText: 'Lugar de Nacimiento'),
                                  // onSaved: (value) {
                                  //   model.password = value;
                                  // },
                                  validator: (value) => str.validator(
                                      value, 'Lugar de Nacimiento'),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                    controller: model.fechaNacController,
                                    decoration: InputDecoration(
                                        labelText: 'Fecha de Nacimiento'),
                                    // onSaved: (value) {
                                    //   model.password = value;
                                    // },
                                    validator: (value) => str.validator(
                                        value, 'Fecha de Nacimiento'),
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
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100));
                                      if (date != null)
                                        model.fechaNacController.text =
                                            DateFormat.yMMMd()
                                                .format(date)
                                                .toString();
                                    }),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.pesoInicialController,
                                  decoration: InputDecoration(
                                      labelText: 'Peso Inicial'),
                                  // onSaved: (value) {
                                  //   model.phoneNumber = value;
                                  // },
                                  validator: (value) =>
                                      str.validator(value, 'Peso Inicial'),
                                  textInputAction: TextInputAction.next,
                                  // inputFormatters: [
                                  //   // FilteringTextInputFormatter.digitsOnly,
                                  //   // PhoneNumberTextInputFormatter()
                                  // ],

                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.tallaInicialController,
                                  decoration: InputDecoration(
                                      labelText: 'Talla Inicial'),
                                  // onSaved: (value) {
                                  //   model.phoneNumber = value;
                                  // },
                                  validator: (value) =>
                                      str.validator(value, 'Talla Inicial'),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    // FilteringTextInputFormatter.digitsOnly,
                                    // PhoneNumberTextInputFormatter()
                                  ],

                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                DropdownButtonFormField<String>(
                                    disabledHint: Text(model.genero ?? ''),
                                    decoration: InputDecoration(
                                        hintText: 'Género',
                                        labelText: 'Género'),
                                    items: Static.genero
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    value: model.genero,
                                    onSaved: (value) => model.genero = value,
                                    validator: (value) =>
                                        model.validatorCountry(value),
                                    // autofocus: true,
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (value) {
                                      model.genero = value;
                                    }),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.responsableController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre Responsable',
                                  ),
                                  // onSaved: (value) {
                                  //   model.fullName = value;
                                  // },
                                  validator: (value) => str.validator(
                                      value, 'Nombre Responsable'),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.parentescoController,
                                  decoration: InputDecoration(
                                    labelText: 'Parentesco del Estudiantes',
                                  ),
                                  // onSaved: (value) {
                                  //   model.fullName = value;
                                  // },
                                  validator: (value) => str.validator(
                                      value, 'Parentesco del Estudiantes'),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.direccionController,
                                  decoration:
                                      InputDecoration(labelText: 'Dirección'),
                                  // onSaved: (value) {
                                  //   model.phoneNumber = value;
                                  // },
                                  validator: (value) =>
                                      str.validator(value, 'Dirección'),
                                  textInputAction: TextInputAction.next,

                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.telefonoController,
                                  decoration:
                                      InputDecoration(labelText: 'Teléfono'),
                                  // onSaved: (value) {
                                  //   model.phoneNumber = value;
                                  // },
                                  validator: (value) =>
                                      str.validator(value, 'Teléfono'),
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    // PhoneNumberTextInputFormatter()
                                  ],

                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                TextFormField(
                                  controller: model.emailController,
                                  decoration:
                                      InputDecoration(labelText: 'Email'),
                                  // onSaved: (value) {
                                  //   model.email = value;
                                  // },
                                  validator: (value) =>
                                      str.validatorEmail(value),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                ButtonGreen(
                                  onTap: _onTapDone,
                                  title: 'Registrar!',
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).padding.bottom
                                    // 200,
                                    )
                              ]))),
                ),
              ),
            ],
          );
        });
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10));
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}
