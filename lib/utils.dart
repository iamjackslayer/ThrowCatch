import 'dart:math';

/// Randomly generates a string of five characters.
String generateRandomChars() {
  Random rn = new Random();
  String code = "";
  for (int i = 0; i < 5; i++) {
    code += new String.fromCharCode(rn.nextInt(26) + 65);
  }

  return code;
}
