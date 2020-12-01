import 'package:intl/intl.dart';

class Static {
  static final List<String> genero = ['Masculino', 'Femenino'];

  static final List<String> campos = ['Campo1', 'Campo2', 'Campo3', 'Campo4'];

  static final List<String> valoraciones = ['DP', 'DO', 'DA', 'ED'];

  static final List<String> trimestres = [
    '1er Trimestre',
    '2do Trimestre',
    '3er Trimestre'
  ];

  static final format = DateFormat('ddMMyyyy');
  static final formatP = DateFormat('dd/MM/yyyy');
}
