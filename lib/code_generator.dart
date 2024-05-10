import 'dart:math';

String generateUniqueCode() {
  const String charset = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Random random = Random();
  String code = '';
  for (int i = 0; i < 6; i++) {
    code += charset[random.nextInt(charset.length)];
  }
  return code;
}
