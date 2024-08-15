import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class UpFileController extends GetxController {
  late AnimationController loading;

  List<PlatformFile> files = [];
  File? file_image;

  @override
  void initState() {}
  selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);

    if (result != null) {
      print('File Name: ${result.names}');
      print('File Path: ${result.paths}');
      PlatformFile file = result.files.first;
      file_image = File(result.files.first.path!);
      files.add(file);
      update();
    }
  }

  Future<void> saveFilePermanetly(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
