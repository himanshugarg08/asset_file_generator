import 'dart:io';
import '../utils/helper_extentions.dart';
import '../utils/helper_functions.dart';

///generates single file of all the assets

void generateSingleFile(String path, String classNameSuffix, String exportPath,
    List<String> allowedFileExtensions) async {
  final directory = Directory(path);

  final folderName = getAssetNameFromPath(path.pathInRequiredFormat());

  final fileName = '$folderName.dart';

  //create file object
  final file = File(joinPath(exportPath, fileName));

  //open file
  final sink = file.openWrite();

  sink.writeln('class $classNameSuffix{');

  final entities = await directory.list(recursive: true).toList();

  entities.sort((a, b) => getAssetName(
          getAssetNameFromPath(a.path.pathInRequiredFormat()))
      .compareTo(
          getAssetName(getAssetNameFromPath(b.path.pathInRequiredFormat()))));

  for (var entity in entities) {
    final isFile = await FileSystemEntity.isFile(entity.path);
    if (isFile) {
      final fileName = getAssetNameFromPath(entity.path.pathInRequiredFormat());

      final assetName = getAssetName(fileName);

      final assetExtension = fileName.split('.').last;

      if (!allowedFileExtensions.contains(assetExtension)) continue;
      final variableName = getVariableName(assetName.replaceAll('-', '_'));

      //write in file
      sink.writeln(
          "  static const String $variableName = '${entity.path.substring(2).pathInRequiredFormat()}';");
    }
  }
  sink.writeln('}');

  //close file
  await sink.close();
  print('$fileName generated');
}
