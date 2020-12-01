class User {
  final String userId;
  final String profesorId;
  final String urlImage;
  final String nombre;
  String email;
  final int gestion;
  final String ci;
  final String fechaNac;
  final String nroLista;
  final String rude;
  final String lugarNac;
  final String genero;
  final String pesoInicial;
  final String pesoFinal;
  final String tallaInicial;
  final String tallaFinal;
  final String nombreResp;
  final String parentesco;
  final String rol;
  final String direccion;
  final String telefono;

  User(
      {this.direccion,
      this.telefono,
      this.profesorId,
      this.urlImage,
      this.userId,
      this.email,
      this.gestion = 2020,
      this.nombre,
      this.ci,
      this.fechaNac,
      this.nroLista,
      this.rude,
      this.lugarNac,
      this.genero,
      this.pesoInicial,
      this.pesoFinal,
      this.tallaInicial,
      this.tallaFinal,
      this.nombreResp,
      this.parentesco,
      this.rol = 'estudiante'});

  User.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        profesorId = map['profesorId'],
        urlImage = map['urlImage'],
        email = map['email'],
        gestion = map['gestion'],
        nombre = map['nombre'],
        ci = map['ci'],
        fechaNac = map['fechaNac'],
        nroLista = map['nroLista'],
        rude = map['rude'],
        lugarNac = map['lugarNac'],
        genero = map['genero'],
        pesoInicial = map['pesoInicial'],
        pesoFinal = map['pesoFinal'],
        tallaInicial = map['tallaInicial'],
        tallaFinal = map['tallaFinal'],
        nombreResp = map['nombreResp'],
        parentesco = map['parentesco'],
        rol = map['rol'],
        direccion = map['direccion'],
        telefono = map['telefono'];

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "urlImage": urlImage,
      "gestion": gestion,
      "nombre": nombre,
      "ci": ci,
      "fechaNac": fechaNac,
      "nroLista": nroLista,
      "rude": rude,
      "lugarNac": lugarNac,
      "genero": genero,
      "pesoInicial": pesoInicial,
      "pesoFinal": pesoFinal,
      "tallaInicial": tallaInicial,
      "tallaFinal": tallaFinal,
      "nombreResp": nombreResp,
      "parentesco": parentesco,
      "email": email,
      "rol": rol,
      "direccion": direccion,
      "telefono": telefono,
    };
  }
}
