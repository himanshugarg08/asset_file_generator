import 'helper_extentions.dart';

String joinPath(String first, String second) {
  return first + '/' + second;
}

String getDirectoryNameFromPath(String path) {
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

String getRelativePath(String path, String parent) {
  return path.replaceAll(parent, '').substring(1);
}
