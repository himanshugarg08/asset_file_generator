import 'package:args/args.dart';
import 'package:watcher/watcher.dart';
import 'src/generate_multiple_files.dart';
import 'src/generate_single_file.dart';

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
    ..addOption(
      'allowed-file-extentions',
      abbr: 'f',
      defaultsTo: 'png-svg-jpg-jpeg-gif-json',
      help: 'files that will be included',
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
      negatable: false,
      help: 'generates a single file for all the assets',
    )
    ..addFlag(
      'multiple-files',
      abbr: 'm',
      negatable: false,
      help: 'generates multiple files for all the assets based on directory',
    )
    ..addFlag(
      'watch',
      abbr: 'w',
      negatable: false,
      help: 'watch changes in the directory and re-generate the files',
    );

  final argResults = argParser.parse(arguments);

  final usage = argParser.usage;

  startGeneration(argResults, usage);

  if (argResults['watch'] as bool) {
    final watcher = DirectoryWatcher(argResults['asset-path']);
    watcher.events.listen((_) {
      startGeneration(argResults, usage);
    });
  }
}

void startGeneration(ArgResults argResults, String usage) {
  final String path = argResults['asset-path'];
  final String exportPath = argResults['export-path'];
  final String classNameSuffix = argResults['class-suffix'];
  final allowedFileExtensions =
      (argResults['allowed-file-extentions'] as String).split('-');

  if (argResults['help'] as bool) {
    print('''** HELP **\n$usage''');
  } else if (argResults['single-file'] as bool) {
    generateSingleFile(
        path, classNameSuffix, exportPath, allowedFileExtensions);
  } else if (argResults['multiple-files'] as bool) {
    generateMultipleFiles(
        path, classNameSuffix, exportPath, allowedFileExtensions);
  } else {
    print(
        'This command line tool is used to generate the file containing a class, where all the assets present in the given directory will be mapped to a unique variable name.\n');
    print('''** HELP **\n$usage''');
  }
}
