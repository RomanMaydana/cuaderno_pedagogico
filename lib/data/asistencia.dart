class Asistencia {
  final String estId;
  final DateTime dateTime;
  final String date;
  final String observacion;
  final String tipo;

  Asistencia(
      {this.estId, this.dateTime, this.date, this.observacion, this.tipo});

  Asistencia.fromMap(Map<String, dynamic> map)
      : estId = map['estId'],
        dateTime = map['dateTime'].toDate(),
        date = map['date'],
        observacion = map['observacion'],
        tipo = map['tipo'];

  Map<String, dynamic> toMap() {
    return {
      "estId": estId,
      "dateTime": dateTime,
      "date": date,
      "observacion": observacion,
      "tipo": tipo
    };
  }
}
