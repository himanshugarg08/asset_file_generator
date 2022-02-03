import 'dart:io';
import 'helper_functions.dart';
import 'helper_extentions.dart';

void generateAssetNameFile(
    String path, String classNameSuffix, String exportPath) async {
  final directory = Directory(path);
  final folderName = getNameFromPath(path);

  //get files
  final entities = await directory.list().toList();

  //file
  final fileName = '$folderName.dart';
  final file = File(joinPath(exportPath, fileName));
  final sink = file.openWrite();
  sink.write('class ${folderName.capitalize()}$classNameSuffix{\n');

  for (var file in entities) {
    final filePath =
        joinPath(folderName, getNameFromPath(file.path.pathInRequiredFormat()));

    final variableName = getVariableName(
        getAssetName(getNameFromPath(file.path.pathInRequiredFormat())));

    //write in file
    sink.write("  static const String $variableName = '$filePath';\n");
  }
  sink.write('}\n');

  //close file
  await sink.close();
  print('$fileName generated');
}
