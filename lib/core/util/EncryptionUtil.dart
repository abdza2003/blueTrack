// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'dart:convert';

// class EncryptionHelper {
//   // مفتاح التشفير (يفضل أن يكون 32 حرفًا لاستخدام AES-256)
//   static const String key =
//       'A4zaS_DOU61nSH9B87aS1D7yR9L2X0j1'; // مثال مفتاح 32 حرفًا

//   // دالة للتشفير
//   static String encryptText(String plainText) {
//     final keyBytes =
//         encrypt.Key.fromUtf8(key.substring(0, 32)); // ضبط طول المفتاح
//     final iv = encrypt.IV.fromSecureRandom(16); // إنشاء IV عشوائي

//     final encrypter =
//         encrypt.Encrypter(encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc));
//     final encrypted = encrypter.encrypt(plainText, iv: iv);

//     // إرفاق IV مع النص المشفر وفصلهما بـ `:`
//     return '${iv.base64}:${encrypted.base64}';
//   }

//   // دالة لفك التشفير
//   static String decryptText(String encryptedText) {
//     final parts = encryptedText.split(':');
//     if (parts.length != 2) {
//       throw ArgumentError('Invalid encrypted text format');
//     }

//     final iv = encrypt.IV.fromBase64(parts[0]);
//     final encryptedBase64 = parts[1];
//     final keyBytes = encrypt.Key.fromUtf8(key.substring(0, 32));

//     final encrypter =
//         encrypt.Encrypter(encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc));
//     final decrypted = encrypter.decrypt64(encryptedBase64, iv: iv);

//     return decrypted;
//   }
// }

// void main() {
//   const plainText = 'Hello, World!';

//   // التشفير
//   final encrypted = EncryptionHelper.encryptText(plainText);
//   print('Encrypted Text: $encrypted');

//   // فك التشفير
//   final decrypted = EncryptionHelper.decryptText(encrypted);
//   print('Decrypted Text: $decrypted');
// }
