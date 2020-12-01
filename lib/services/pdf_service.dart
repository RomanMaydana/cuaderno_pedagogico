import 'dart:io';

import 'package:cuaderno_pedagogico/data/user.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';
import 'package:cuaderno_pedagogico/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final pdf = pw.Document();

_buildValoracion(int trim, List<ValoracionTrimestral> valTrim) {
  for (ValoracionTrimestral val in valTrim) {
    if (val.trimestre == trim)
      return pw.Text(val.valoracion, style: pw.TextStyle(fontSize: 10));
  }
  return pw.Text(
      trim == 4 ? 'No fue valorado.' : 'El trimestre no fue valorado aún.');
}

final List<String> trimestres = [
  '1er Trimestre',
  '2do Trimestre',
  '3er Trimestre',
  'Anual'
];

Future<void> generatePdf({@required List<User> estudiantes}) async {
  final dataBase = DataBase();
  List<pw.Widget> estContainer = <pw.Widget>[];
  List<pw.Widget> titulos = <pw.Widget>[];
  titulos.add(pw.Expanded(
      child: pw.Container(
          padding: pw.EdgeInsets.only(left: 10),
          child: pw.Text("NÚMERO Y NOMBRE",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))));
  titulos.add(pw.Container(
    color: PdfColors.black,
    width: 1,
    height: 30,
  ));
  for (int i = 0; i < 4; i++) {
    titulos.add(pw.Container(
        // decoration: pw.BoxDecoration(
        //     border: pw.BoxBorder(
        //         left: true, right: true, color: PdfColors.black)),
        padding: pw.EdgeInsets.all(8),
        width: 130,
        child: pw.Text(trimestres[i].toUpperCase(),
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    titulos.add(pw.Container(height: 30, color: PdfColors.black, width: 1));
  }
  estContainer.add(pw.Container(
      margin: pw.EdgeInsets.symmetric(horizontal: 20),
      decoration: pw.BoxDecoration(
        border: pw.BoxBorder(
            bottom: true,
            left: true,
            right: true,
            top: true,
            color: PdfColors.black),
      ),
      child: pw.Row(children: titulos)));

  for (User estudiante in estudiantes) {
    final result = await dataBase.getValTrimByEstudiante(estudiante.userId);
    final itemList = <pw.Widget>[];
    itemList.add(pw.Expanded(
        child: pw.Container(
            padding: pw.EdgeInsets.only(left: 10),
            child: pw.Text("${estudiante.nroLista}. ${estudiante.nombre}"))));
    itemList.add(pw.Container(
      color: PdfColors.black,
      width: 1,
      height: 70,
    ));
    for (int i = 1; i <= 4; i++) {
      itemList.add(pw.Container(
          // decoration: pw.BoxDecoration(
          //     border: pw.BoxBorder(
          //         left: true, right: true, color: PdfColors.black)),
          padding: pw.EdgeInsets.all(8),
          width: 130,
          child: _buildValoracion(i, result)));
      itemList.add(pw.Container(height: 70, color: PdfColors.black, width: 1));
    }
    final row = pw.Row(children: itemList);
    estContainer.add(pw.Container(
        margin: pw.EdgeInsets.symmetric(horizontal: 20),
        decoration: pw.BoxDecoration(
          border: pw.BoxBorder(
              bottom: true,
              left: true,
              right: true,
              top: true,
              color: PdfColors.black),
        ),
        child: row));
  }

  pdf.addPage(pw.Page(
      margin: pw.EdgeInsets.all(20),
      orientation: pw.PageOrientation.landscape,
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 40, bottom: 20),
            child: pw.Column(
                // crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: <pw.Widget>[
                  pw.Text('CENTRALIZADOR',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('EDUCACIÓN INICIAL EN FAMILIA COMUNITARIA',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                            child: pw.Text('Unidad \"6 de Junio\" Copacabana',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Expanded(
                            child: pw.Text('Código: 80570092',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)))
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                            child: pw.Text('Dependencia: Fiscal',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Expanded(
                          child: pw.Text('Turno: Mañana',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        )
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                          child: pw.Text('Distrito: \"B\"',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Expanded(
                            child: pw.Text('Departamento: La Paz',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                            child: pw.Text('Código Rude: 005404544',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Expanded(
                            child: pw.Text(
                                'Apellidos y Nombres: Maydana Callisaya Lidia',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                            child: pw.Text('Año: Segundo',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Expanded(
                            child: pw.Text('Gestión: 2019',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                      ]),
                ]),
          ),
          pw.Column(
              children: estContainer.length > 6
                  ? estContainer.sublist(0, 6)
                  : estContainer)
        ]);
        // return pw.Center(
        //   child: pw.Text("Hello World"),
        // ); // Center
      }));
  if (estContainer.length > 5) {
    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.all(20),
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: estContainer.sublist(6));
          // return pw.Center(
          //   child: pw.Text("Hello World"),
          // ); // Center
        }));
  }

// On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
  final output = await getExternalStorageDirectory();
  print("${output.path}/example.pdf");
  final file = File("${output.path}/centralizador.pdf");
  // final file = File("example.pdf");
  await file.writeAsBytes(pdf.save());
}
