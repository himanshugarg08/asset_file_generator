import 'dart:io';
import '../utils/helper_extentions.dart';
import '../utils/helper_functions.dart';

///generates single file of all the assets

void generateSingleFile(
    String path, String classNameSuffix, String exportPath) async {
  final directory = Directory(path);

  final folderName = getDirectoryNameFromPath(path.pathInRequiredFormat());

  final fileName = '$folderName.dart';

  //create file object
  final file = File(joinPath(exportPath, fileName));

  //open file
  final sink = file.openWrite();

  sink.write('class $classNameSuffix{\n');

  final entities = await directory.list(recursive: true).toList();
  for (var entity in entities) {
    final isFile = await FileSystemEntity.isFile(entity.path);
    if (isFile) {
      final variableName = getVariableName(getAssetName(
          getDirectoryNameFromPath(entity.path.pathInRequiredFormat())));

      //write in file
      sink.write(
          "  static const String $variableName = '${entity.path.substring(2).pathInRequiredFormat()}';\n");
    }
  }
  sink.write('}\n');

  //close file
  await sink.close();
  print('$fileName generated');
}
