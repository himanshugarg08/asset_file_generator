import 'dart:io';
import 'helper_extentions.dart';
import 'generate_asset_name_file.dart';
import 'package:args/args.dart';

import 'helper_functions.dart';

void main(List<String> arguments) async {
  final argParser = ArgParser()
    ..addOption(
      'asset-path',
      abbr: 'a',
      defaultsTo: '.',
      help: 'path to the directory where your assets are stored',
    )
    ..addOption(
      'export-path',
      abbr: 'e',
      defaultsTo: '.',
      help: 'path to the directory where you want to export',
    )
    ..addOption(
      'class-suffix',
      abbr: 's',
      defaultsTo: 'Asset',
      help: 'suffix added to the generated class name',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'displays help information',
    );

  final argResults = argParser.parse(arguments);

  final String path = "./bin/assets"; //argResults['asset-path'];
  final String exportPath = "./bin/export"; //argResults['export-path'];
  final String classNameSuffix = "Asset"; //argResults['class-suffix'];

  if (argResults['help'] as bool) {
    print('''** HELP **\n${argParser.usage}''');
  } else {
    gen(path.pathInRequiredFormat());

    //assetPathName.add(getDirectoryNameFromPath(path.pathInRequiredFormat()));
    //generate(path, classNameSuffix, exportPath);
    // final directory = Directory(path);
    // final entities = await directory.list().toList();

    // for (var entity in entities) {
    //   final isDirectory = await FileSystemEntity.isDirectory(entity.path);
    //   if (isDirectory) {
    //     generateAssetNameFile(
    //         entity.path.pathInRequiredFormat(), classNameSuffix, exportPath);
    //   }
    // }
    // generateAssetNameFile(
    //     path.pathInRequiredFormat(), classNameSuffix, exportPath);
  }
}

List<String> assetPathName = [];

String generateAssetPath() {
  var path = '';
  for (var value in assetPathName) {
    value != assetPathName.last ? path += value + '/' : path += value;
  }
  return path;
}

void generate(String path, String classNameSuffix, String exportPath) async {
  assetPathName.add(getDirectoryNameFromPath(path.pathInRequiredFormat()));

  final directory = Directory(path);
  final entities = await directory.list().toList();

  for (var entity in entities) {
    final isDirectory = await FileSystemEntity.isDirectory(entity.path);
    if (isDirectory) {
      generate(entity.path.pathInRequiredFormat(), classNameSuffix, exportPath);
    }
  }
  generateAssetNameFile(
      path.pathInRequiredFormat(), classNameSuffix, exportPath);
  assetPathName.removeLast();
}

void gen(String p) async {
  assetPathName.add(getDirectoryNameFromPath(p.pathInRequiredFormat()));
  final directory = Directory(p);
  final entities = await directory.list().toList();

  for (var entity in entities) {
    final isDirectory = await FileSystemEntity.isDirectory(entity.path);
    if (isDirectory) {
      gen(entity.path);
    }
    final isFile = await FileSystemEntity.isFile(entity.path);
    if (isFile) {
      // final filePath = joinPath(generateAssetPath(),
      //     getDirectoryNameFromPath(entity.path.pathInRequiredFormat()));

      print(generateAssetPath() +
          '      ' +
          getDirectoryNameFromPath(entity.path.pathInRequiredFormat()));

      // final variableName = getVariableName(getAssetName(
      //     getDirectoryNameFromPath(entity.path.pathInRequiredFormat())));

      //write in file
      //sink.write("  static const String $variableName = '$filePath';\n");
    }
  }
  assetPathName.removeLast();
  // generateAssetNameFile(
  //     path.pathInRequiredFormat(), classNameSuffix, exportPath);
}
