import 'package:ewarrenty/Function/compressImage.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> myImagePicker() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(
    source: ImageSource.camera,
    // imageQuality: 15,
  );
  print(pickedFile.path);
  var dir = await getTemporaryDirectory();
  var tempPath = dir.path;
  File compressedFile = await testCompressAndGetFile(
      await File(pickedFile.path), "$tempPath/${DateTime.now()}.jpeg");
  return compressedFile.path;
}
