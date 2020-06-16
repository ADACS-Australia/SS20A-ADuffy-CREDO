import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get getFile async {
    final path = await getFilePath;
    //print('$path/testfile.txt');
    String finalPath = path + '/testfile.txt';
    return finalPath;
  }

  static Future<File> saveToFile(String data) async {
    final path = await getFile;
    //final file = new File(path)
    return File(path).writeAsString(data, mode: FileMode.append, flush: true);
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await File(file).readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }
}
