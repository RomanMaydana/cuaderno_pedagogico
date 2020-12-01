class Valoriacion {
  final int trimestre;
  final String idTema;
  final String idEstudiante;
  final List<Ponderacion> ponderacion;

  Valoriacion(
      {this.trimestre, this.idTema, this.idEstudiante, this.ponderacion});

  Valoriacion.fromMap(Map<String, dynamic> map)
      : trimestre = map['trimestre'],
        idTema = map['idTema'],
        idEstudiante = map['idEstudiante'],
        ponderacion = (map['ponderacion'] as List)
            .map((e) => Ponderacion.fromMap(e))
            .toList();

  Map<String, dynamic> toMap() {
    return {
      "trimestre": trimestre,
      "idTema": idTema,
      "idEstudiante": idEstudiante,
      "ponderacion": ponderacion.map((e) => e.toMap()).toList(),
    };
  }
}

class Ponderacion {
  final String idIdentificador;
  final String valor;

  Ponderacion({this.idIdentificador, this.valor});

  Ponderacion.fromMap(Map<String, dynamic> map)
      : this.idIdentificador = map['idIdentificador'],
        this.valor = map['valor'];

  toMap() {
    return {"idIdentificador": idIdentificador, "valor": valor};
  }
}

class ValoracionTrimestral {
  final String idEstudiante;
  final String valoracion;
  final int trimestre;

  ValoracionTrimestral({this.idEstudiante, this.valoracion, this.trimestre});

  ValoracionTrimestral.fromMap(Map<String, dynamic> map)
      : idEstudiante = map['idEstudiante'],
        valoracion = map['valoracion'],
        trimestre = map['trimestre'];

  Map<String, dynamic> toMap() {
    return {
      "idEstudiante": idEstudiante,
      "valoracion": valoracion,
      "trimestre": trimestre
    };
  }
}
