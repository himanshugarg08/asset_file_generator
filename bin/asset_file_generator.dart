import 'dart:io';
import 'helper_extentions.dart';
import 'generate_asset_name_file.dart';
import 'package:args/args.dart';

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

  final String path = argResults['asset-path'];
  final String exportPath = argResults['export-path'];
  final String classNameSuffix = argResults['class-suffix'];

  if (argResults['help'] as bool) {
    print('''** HELP **\n${argParser.usage}''');
  } else {
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
}
