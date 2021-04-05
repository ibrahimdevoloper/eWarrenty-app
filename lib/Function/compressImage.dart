import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

// from flutter_image_compress
Future<Uint8List> testCompressFile(File file) async {
// Future<File> testCompressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    // minWidth: 2300,
    // minHeight: 1500,
    quality: 15,
    // rotate: 90,
  );
  // print("file length: ${file.lengthSync()}");
  // print("compress length: ${result.length}");
  // File compressedFile = File.fromRawPath(result);
  return result;
  // return compressedFile;
}

Future<File> testCompressAndGetFile(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, targetPath,
    quality: 40,

    // rotate: 180,
  );

  // print("file length: ${file.lengthSync()}");
  // print("result length:${result.lengthSync()}");

  return result;
}
