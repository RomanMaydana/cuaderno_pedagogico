import 'package:cloud_firestore/cloud_firestore.dart';

class Indicador {
  String id;
  final String nombre;
  final String campo;
  final DocumentSnapshot docSnapshot;

  Indicador({this.id, this.nombre, this.campo, this.docSnapshot});

  Indicador.fromMap(Map map, {this.docSnapshot})
      : id = docSnapshot.id,
        nombre = map['nombre'],
        campo = map['campo'];

  Indicador.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), docSnapshot: snapshot);

  Map<String, dynamic> toMap() {
    return {"nombre": this.nombre, "campo": this.campo};
  }
}
