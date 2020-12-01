import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuaderno_pedagogico/data/asistencia.dart';
import 'package:cuaderno_pedagogico/data/indicador.dart';
import 'package:cuaderno_pedagogico/data/tema.dart';
import 'package:cuaderno_pedagogico/data/valoracion.dart';

import '../data/user.dart';

final String _userCollection = 'user';
final String _indicadorCollection = 'indicador';
final String _asistenciaColletion = 'asistencia';
final String _temaColletion = 'tema';
final String _valoracionCollection = 'valoracion';
final String _valoracionTrimestralCollection = 'valoracionTrimestral';

class DataBase {
  Future<void> createUser(User user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection(_userCollection)
        .doc(user.userId)
        .set(user.toMap());
  }

  Future<User> getUser(String userId) async {
    final firestore = FirebaseFirestore.instance;

    final snapshot =
        await firestore.collection(_userCollection).doc(userId).get();
    return User.fromMap(snapshot.data());
  }

  Future<List<User>> getEstudiantes() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection(_userCollection)
        .where('rol', isEqualTo: 'estudiante')
        .orderBy('nroLista')
        .get();
    return snapshot.docs.map((e) => User.fromMap(e.data())).toList();
  }

  // Future<void> updateUser(User user, String uid) async {
  //   final firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection(_userCollection)
  //       .doc(uid)
  //       .set(user.toMapEdit(), SetOptions(merge: true));
  // }

  // Future<void> updateEmail(String email, String uid) async {
  //   final firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection(_userCollection)
  //       .doc(uid)
  //       .set({'email': email}, SetOptions(merge: true));
  // }

  Future<String> createIndicador(Indicador indicador) async {
    final firestore = FirebaseFirestore.instance;
    final result =
        await firestore.collection(_indicadorCollection).add(indicador.toMap());
    return result.id;
  }

  Future<List<Indicador>> getIndicadores() async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection(_indicadorCollection)
        .orderBy('nombre')
        .get();
    return snapshot.docs.map((e) => Indicador.fromSnapshot(e)).toList();
  }

  Future<Indicador> getIndicadorById(String id) async {
    final firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore.collection(_indicadorCollection).doc(id).get();
    return Indicador.fromSnapshot(snapshot);
  }

  Future<void> createAsistencia(Asistencia asistencia) async {
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection(_asistenciaColletion)
        .doc('${asistencia.estId}${asistencia.date}')
        .set(asistencia.toMap());
  }

  Future<List<Asistencia>> getAsistencias(String date) async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection(_asistenciaColletion)
        .where("date", isEqualTo: date)
        .get();
    return snapshot.docs.map((e) => Asistencia.fromMap(e.data())).toList();
  }

  Future<List<Tema>> getTemas() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection(_temaColletion)
        .orderBy('trimestre')
        .orderBy('create', descending: true)
        .get();
    return snapshot.docs.map((e) => Tema.fromSnapshot(e)).toList();
  }

  Future<List<Tema>> getTemasByTrimestre(int trimestre) async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection(_temaColletion)
        .where('trimestre', isEqualTo: trimestre)
        .orderBy('fechaInicio', descending: false)
        .get();
    return snapshot.docs.map((e) => Tema.fromSnapshot(e)).toList();
  }

  Future<void> createTema(Tema tema) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection(_temaColletion).add(tema.toMap());
  }

  Future<List<Valoriacion>> getValoraciones(String tema) async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection(_valoracionCollection)
        .where("tema", isEqualTo: tema)
        .get();
    return snapshot.docs.map((e) => Valoriacion.fromMap(e.data())).toList();
  }

  Future<Valoriacion> getValoranByTemaYEstudiante(
      Tema tema, String isEstudiante) async {
    final firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection(_valoracionCollection)
        .where("idEstudiante", isEqualTo: isEstudiante)
        .where("idTema", isEqualTo: tema.docSnapshot.id)
        .where("trimestre", isEqualTo: tema.trimestre)
        .get();

    if (snapshot.docs.isEmpty)
      throw 'El estudiante no fue valorado en el tema ${tema.nombre}.';
    return Valoriacion.fromMap(snapshot.docs[0].data());
  }

  Future<void> createValoracion(Valoriacion valoracion) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection(_valoracionCollection).add(valoracion.toMap());
  }

  Future<void> createValoracionTrimestral(
      ValoracionTrimestral valoracion) async {
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection(_valoracionTrimestralCollection)
        .add(valoracion.toMap());
  }

  Future<String> getValoracionTrimestralByIdYTrimestre(
      String idEstudiante, int trimestre) async {
    final firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection(_valoracionTrimestralCollection)
        .where("idEstudiante", isEqualTo: idEstudiante)
        .where("trimestre", isEqualTo: trimestre)
        .get();

    if (snapshot.docs.isEmpty) throw 'No tiene valoración.';
    return ValoracionTrimestral.fromMap(snapshot.docs[0].data()).valoracion;
  }

  Future<String> getValoracionAnualByEst(String idEstudiante) async {
    final firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection(_valoracionTrimestralCollection)
        .where("idEstudiante", isEqualTo: idEstudiante)
        .where("trimestre", isEqualTo: 4)
        .get();

    if (snapshot.docs.isEmpty) throw 'No tiene valoración.';
    return ValoracionTrimestral.fromMap(snapshot.docs[0].data()).valoracion;
  }

  Future<List<ValoracionTrimestral>> getValTrimByEstudiante(
      String idEstudiante) async {
    final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection(_valoracionTrimestralCollection)
        .where("idEstudiante", isEqualTo: idEstudiante)
        .orderBy("trimestre")
        .get();
    return snapshot.docs
        .map((e) => ValoracionTrimestral.fromMap(e.data()))
        .toList();
  }
  // Future<List<Post>> getPostByUser(String userId) async {
  //   final firestore = FirebaseFirestore.instance;
  //   QuerySnapshot snapshot = await firestore
  //       .collection(_postCollection)
  //       .where('userId', isEqualTo: userId)
  //       .orderBy('title')
  //       .get();
  //   return snapshot.docs.map((e) => Post.fromMap(e.data())).toList();
  // }

  // Future<List<Post>> getPostByCategoryAndSort(
  //     {int category, int sort, DocumentSnapshot docSnapshot, int limit}) async {
  //   final firestore = FirebaseFirestore.instance;
  //   Query query = firestore.collection(_postCollection);

  //   if (category != null) {
  //     query = query.where("category", isEqualTo: Static.categories[category]);
  //   }
  //   switch (sort) {
  //     case 0:
  //       query = query.orderBy("createDate", descending: true);
  //       break;
  //     default:
  //       query = query.orderBy("createDate", descending: true);
  //       break;
  //   }
  //   if (docSnapshot == null) {
  //     query = query.limit(limit);
  //   } else {
  //     query = query.startAfterDocument(docSnapshot).limit(limit);
  //   }
  //   QuerySnapshot snapshots = await query.get();

  //   return snapshots.docs
  //       .map((document) => Post.fromSnapshot(document))
  //       .toList();
  // }
}
