import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';

class Tema {
  final String nombre;
  final String descripcion;
  final DateTime create;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final int trimestre;
  final List<String> identificadores;
  final DocumentSnapshot docSnapshot;
  Valoriacion valoriacion;
  Tema(
      {this.valoriacion,
      this.descripcion,
      this.create,
      this.fechaInicio,
      this.fechaFin,
      this.nombre,
      this.trimestre,
      this.identificadores,
      this.docSnapshot});

  Tema.fromMap(Map<String, dynamic> map, {this.docSnapshot})
      : nombre = map['nombre'],
        trimestre = map['trimestre'],
        identificadores = map['identificadores'].cast<String>().toList(),
        descripcion = map['descripcion'],
        create = map['create'].toDate(),
        fechaInicio = map['fechaInicio'].toDate(),
        fechaFin = map['fechaFin'].toDate();
  Tema.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), docSnapshot: snapshot);
  Map<String, dynamic> toMap() {
    return {
      "nombre": nombre,
      "trimestre": trimestre,
      "identificadores": identificadores,
      "descripcion": descripcion,
      "create": create,
      "fechaInicio": fechaInicio,
      "fechaFin": fechaFin
    };
  }
}
