# Usage

For instance, you have a created a flutter project and you have put all of the assets inside the assets folder in the root of your project. Now, let us assume that you have an export directory to save all your generated files.

Based on the above example:

## Creating a single file for all the assets:

```
afg -s -a ./assets -e ./export
```

## Creating multiple file for all the assets:

The number of files created will depends on how many different directories you have.

```
afg -m -a ./assets -e ./export
```

## Allowing certain extension files:

If you need `asset_file_generator` to pick only certain file extension, then you can do that by adding `-f` argument.  

```
afg -m -a ./assets -e ./export -f png-svg-jpg-jpeg-gif-json
```

Note: For more than extensions, you must seperate the extensions using `'-'`

## Custom Class Name:

The class name will be same as the name of the respective directory. However, you can add the suffix to that name which is default to `Assets`.

