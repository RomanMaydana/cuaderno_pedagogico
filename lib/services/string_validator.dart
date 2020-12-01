bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em.trim());
}

String validator(String v, String title) {
  final value = v.trim();
  if (value == '') {
    return 'Porfavor ingrese $title.';
  }
  return null;
}

String validatorPassword(String v) {
  if (v.length > 5) {
    return null;
  } else
    return 'Please enter at least 6 characters';
}

String validatorEmail(String v) {
  String result = validator(v, 'Email');
  if (result == null) {
    if (isEmail(v)) {
      return null;
    } else
      return 'Please enter a valid email address';
  }
  return result;
}

String validatorSelect(int value, String title) {
  if (value == null) {
    return 'Por favor seleccione $title';
  }
  return null;
}

String validatorSelectString(String value, String title) {
  if (value == null) {
    return 'Seleccione.';
  }
  return null;
}
