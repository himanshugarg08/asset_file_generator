# Asset File Generator For Flutter
A simple command line tool that is used to generate the file containing a class, where all the assets present in the given directory will be mapped to a unique variable name.

## How to Use?

Run this command in your terminal to activate the package.
```
dart pub global activate asset_file_generator
```
To run a script directly from the command line, add the system cache bin directory to your PATH environment variable. After adding the path, run this command for help.

```
afg -h
```
Available arguments:

```
-a, --asset-path                 path to the directory where your assets are stored
                                 (defaults to ".")
-e, --export-path                path to the directory where you want to export
                                 (defaults to ".")
-c, --class-suffix               suffix added to the generated class name
                                 (defaults to "Assets")
-f, --allowed-file-extentions    files that will be included
                                 (defaults to "png-svg-jpg-jpeg-gif-json")
-h, --help                       displays help information
-s, --single-file                generates a single file for all the assets
-m, --multiple-files             generates multiple files for all the assets based on directory
-w, --watch                      watch changes in the directory and re-generate the files
```

## Conventions:

* The name of the file should be in lower case.
* Multiple words of assets should be joined using `'_'` or `'-'` to create separation.
* It is recommended to move all your assets under same directory and then generate the file/files.
* It is also recommended to create a separate directory for the exported file/files.

#### Contributing:

1. Fork it (<https://github.com/himanshugarg08/asset_file_generator/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
