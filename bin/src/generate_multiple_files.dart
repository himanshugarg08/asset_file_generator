import 'dart:io';
import 'generate_asset_name_file.dart';
import '../utils/helper_extentions.dart';

///generates multiple files of all the assets based on directory

void generateMultipleFiles(
    String path, String classNameSuffix, String exportPath) async {
  final directory = Directory(path);

  final entities = await directory.list().toList();

  for (var entity in entities) {
    final isDirectory = await FileSystemEntity.isDirectory(entity.path);
    if (isDirectory) {
      generateMultipleFiles(
          entity.path.pathInRequiredFormat(), classNameSuffix, exportPath);
    }
  }
  generateAssetNameFile(
      path.pathInRequiredFormat(), classNameSuffix, exportPath);
}
