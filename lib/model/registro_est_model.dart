import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/string_validator.dart' as str;
import '../data/user.dart';

class RegistroEstModel extends ChangeNotifier {
  File _file;
  String _urlImage;
  String _genero;
  String userId;
  String proferorId;

  final rudeController = TextEditingController();
  final nroListaController = TextEditingController();
  final ciController = TextEditingController();
  final nombreController = TextEditingController();
  final responsableController = TextEditingController();
  final parentescoController = TextEditingController();
  final emailController = TextEditingController();
  final lugarNacController = TextEditingController();
  final fechaNacController = TextEditingController();
  final pesoInicialController = TextEditingController();
  final tallaInicialController = TextEditingController();
  final direccionController = TextEditingController();
  final telefonoController = TextEditingController();

  get genero => this._genero;

  set genero(String value) {
    this._genero = value;
    notifyListeners();
  }

  String validatorCountry(String value) {
    if (value == null) {
      return 'Please select some country';
    }
    return null;
  }

  set file(File file) {
    this._file = file;
    notifyListeners();
  }

  get file => this._file;

  void reset() {
    this.file = null;

    notifyListeners();
  }

  get urlImage => this._urlImage;
  set urlImage(String value) => this._urlImage = value;

  User get getUser => User(
        ci: ciController.text.trim(),
        direccion: direccionController.text.trim(),
        email: emailController.text.trim(),
        fechaNac: fechaNacController.text.trim(),
        genero: this.genero,
        lugarNac: lugarNacController.text.trim(),
        nombre: nombreController.text.trim(),
        nombreResp: responsableController.text.trim(),
        nroLista: nroListaController.text.trim(),
        parentesco: parentescoController.text.trim(),
        rude: rudeController.text.trim(),
        pesoInicial: pesoInicialController.text.trim(),
        tallaInicial: tallaInicialController.text.trim(),
        telefono: telefonoController.text.trim(),
        urlImage: urlImage,
        userId: userId,
        profesorId: proferorId,
      );
}
