class FormValidationUtil {
  static bool isValidPhone(String inputString) {
    if (inputString.isEmpty) return false;

    if (inputString.length > 16 || inputString.length < 6) return false;
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool isText(String inputString) {
    if (inputString.isEmpty) return false;

    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool isValidPassword(String inputString) {
    if (inputString.isEmpty) return false;

    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool isNumeric(String inputString) {
    const pattern = r'^\d+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool username(String inputString) {
    if (inputString.length < 6 && inputString.length > 255) return false;

    // const pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d_]+$';
    const pattern = r'^[a-zA-Z0-9._-]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool password(String inputString) {
    if (inputString.length < 6 && inputString.length > 255) return false;

    // const pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d_]+$';
    const pattern = r'^[a-zA-Z0-9._-]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(inputString);
  }

  static bool phoneNumber(String inputString) {
    return isNumeric(inputString);
  }
}
