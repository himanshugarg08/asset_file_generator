import 'package:args/args.dart';
import 'generate_multiple_files.dart';
import 'generate_single_file.dart';

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
      abbr: 'c',
      defaultsTo: 'Assets',
      help: 'suffix added to the generated class name',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'displays help information',
    )
    ..addFlag(
      'single-file',
      abbr: 's',
      help: 'generates a single file for all the assets',
    )
    ..addFlag(
      'multiple-files',
      abbr: 'm',
      help: 'generates multiple files for all the assets based on directory',
    );

  final argResults = argParser.parse(arguments);

  final String path = argResults['asset-path'];
  final String exportPath = argResults['export-path'];
  final String classNameSuffix = argResults['class-suffix'];

  if (argResults['help'] as bool) {
    print('''** HELP **\n${argParser.usage}''');
  } else if (argResults['single-file'] as bool) {
    generateSingleFile(path, classNameSuffix, exportPath);
  } else if (argResults['multiple-files'] as bool) {
    generateMultipleFiles(path, classNameSuffix, exportPath);
  } else {
    print(
        'This command line tool is used to generate the file containing a class, where all the assets present in the given directory will be mapped to a unique variable name.\n');
    print('''** HELP **\n${argParser.usage}''');
  }
}
