import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// This class was created for logging purposes
/// we wanted to observe hits as they were coming in without sending them to a server.

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get getFile async {
    final path = await getFilePath;
    String finalPath = path + '/testfile.txt';
    return finalPath;
  }

  static Future<File> saveToFile(String data) async {
    final path = await getFile;

    ///Writes into file immediately.
    ///As it appends into the file the file will eventually fill up.
    ///there is NO safeguard in place for that as of yet.
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
