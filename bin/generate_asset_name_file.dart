import 'dart:io';
import 'asset_file_generator.dart';
import 'helper_functions.dart';
import 'helper_extentions.dart';

void generateAssetNameFile(
    String path, String classNameSuffix, String exportPath) async {
  final directory = Directory(path);
  final folderName = getDirectoryNameFromPath(path);

  //get files
  final entities = await directory.list().toList();

  //file
  final fileName = '$folderName.dart';
  final file = File(joinPath(exportPath, fileName));
  final sink = file.openWrite();
  sink.write('class ${folderName.capitalize()}$classNameSuffix{\n');

  for (var file in entities) {
    final isFile = await FileSystemEntity.isFile(file.path);
    if (isFile) {
      final filePath = joinPath(generateAssetPath(),
          getDirectoryNameFromPath(file.path.pathInRequiredFormat()));

      final variableName = getVariableName(getAssetName(
          getDirectoryNameFromPath(file.path.pathInRequiredFormat())));

      //write in file
      sink.write("  static const String $variableName = '$filePath';\n");
    }
  }
  sink.write('}\n');

  //close file
  await sink.close();
  print('$fileName generated');
}
