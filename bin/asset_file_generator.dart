import 'dart:io';

String joinPath(String first, String second) {
  return first + '/' + second;
}

String getNameFromPath(String path) {
  return path.split('/').last;
}

String getAssetName(String fileName) {
  return fileName.split('.').first;
}

String getVariableName(String assetName) {
  final nameList = assetName.split('_');
  assetName = '';
  for (var i = 0; i < nameList.length; i++) {
    nameList[i] = nameList[i].toLowerCase();
    if (i != 0) nameList[i] = nameList[i].capitalize();
    assetName += nameList[i];
  }
  return assetName;
}

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

void main(List<String> arguments) async {
  final path = arguments[0];
  final exportPath = arguments[1];

  final classNameSuffix = 'Asset';

  final directory = Directory(path);

  final entities = await directory.list().toList();

  for (var entity in entities) {
    final isDirectory = await FileSystemEntity.isDirectory(entity.path);
    if (isDirectory) {
      generateAssetNameFile(
          entity.path.pathInRequiredFormat(), classNameSuffix, exportPath);
    }
  }
  generateAssetNameFile(
      path.pathInRequiredFormat(), classNameSuffix, exportPath);
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String pathInRequiredFormat() {
    return replaceAll('\\', '/');
  }
}
