import 'dart:convert';
import 'dart:io';

abstract class LocalStorageDataSource {
  void save(
    File file,
    String filename, {
    String dirPath,
  });
  void saveWithString(
    String data,
    String filename, {
    String dirPath,
  });
  File load(
    String filename, {
    String dirPath,
  });
  String loadToString(
    String filename, {
    String dirPath,
    Encoding encoding = utf8,
  });
  void remove(
    String filename, {
    String dirPath,
  });
  void removeDir(String dirPath);
  bool isExist(
    String filename, {
    String dirPath,
  });
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  LocalStorageDataSourceImpl(this._rootPath);

  final String _rootPath;

  @override
  void save(
    File file,
    String filename, {
    String dirPath,
  }) {
    final dir = _getDir(dirPath);
    if (!dir.existsSync()) {
      dir.createSync();
    }
    final path = '${dir.path}/$filename';
    final newFile = file.copySync(path);
    if (newFile.existsSync()) {
      newFile.deleteSync();
    }
    newFile.writeAsBytesSync(file.readAsBytesSync());
  }

  @override
  void saveWithString(
    String data,
    String filename, {
    String dirPath,
  }) {
    final dir = _getDir(dirPath);
    if (!dir.existsSync()) {
      dir.createSync();
    }
    final path = '${dir.path}/$filename';
    final newFile = File(path);
    if (newFile.existsSync()) {
      newFile.deleteSync();
    }
    newFile
      ..createSync()
      ..writeAsStringSync(data);
  }

  @override
  File load(
    String filename, {
    String dirPath,
  }) {
    final file = File('${_getDir(dirPath).path}/$filename');
    return file.existsSync() ? file : null;
  }

  @override
  String loadToString(
    String filename, {
    String dirPath,
    Encoding encoding = utf8,
  }) {
    final dir = _getDir(dirPath);
    final file = File('${dir.path}/$filename');
    return file.existsSync() ? file.readAsStringSync(encoding: encoding) : null;
  }

  @override
  void remove(
    String filename, {
    String dirPath,
  }) {
    final file = File('${_getDir(dirPath).path}/$filename');
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  @override
  void removeDir(String dirPath) {
    final dir = Directory(_getDir(dirPath).path);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }

  @override
  bool isExist(
    String filename, {
    String dirPath,
  }) =>
      File('${_getDir(dirPath).path}/$filename').existsSync();

  Directory _getDir(String path) =>
      Directory(path != null ? '$_rootPath/$path' : _rootPath);
}
