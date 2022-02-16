import 'dart:io';
import '../utils/helper_functions.dart';
import '../utils/helper_extentions.dart';

void generateAssetNameFile(String path, String classNameSuffix,
    String exportPath, List<String> allowedFileExtensions) async {
  final directory = Directory(path);
  final folderName = getAssetNameFromPath(path);

  //get files
  final entities = await directory.list().toList();

  entities.sort((a, b) => getAssetName(
          getAssetNameFromPath(a.path.pathInRequiredFormat()))
      .compareTo(
          getAssetName(getAssetNameFromPath(b.path.pathInRequiredFormat()))));

  //file
  final fileName = '$folderName.dart';
  final file = File(joinPath(exportPath, fileName));
  final sink = file.openWrite();
  sink.write('class ${folderName.capitalize()}$classNameSuffix{\n');

  for (var file in entities) {
    final isFile = await FileSystemEntity.isFile(file.path);
    if (isFile) {
      final fileName = getAssetNameFromPath(file.path.pathInRequiredFormat());

      final assetName = getAssetName(fileName);

      final assetExtension = fileName.split('.').last;

      if (!allowedFileExtensions.contains(assetExtension)) continue;

      final variableName = getVariableName(assetName.replaceAll('-', '_'));

      //write in file
      sink.write(
          "  static const String $variableName = '${file.path.substring(2).pathInRequiredFormat()}';\n");
    }
  }
  sink.write('}\n');

  //close file
  await sink.close();
  print('$fileName generated');
}
