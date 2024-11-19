import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart' as file_selector;
import 'package:universal_platform/universal_platform.dart';

// --- Pick Existing Directory

Future<String?> pickExistingDirectory() async {
  if (UniversalPlatform.isDesktop) {
    return _pickExistingDirectoryDesktop();
  } else {
    return _pickExistingDirectoryMobile();
  }
}

Future<String?> _pickExistingDirectoryDesktop() {
  return file_selector.getDirectoryPath();
}

Future<String?> _pickExistingDirectoryMobile() {
  return FilePicker.platform.getDirectoryPath();
}

// --- Pick Existing Files

Future<List<file_selector.XFile>?> pickExistingFiles({
  List<String>? extensions,
}) async {
  if (UniversalPlatform.isDesktop) {
    return _pickExistingFilesDesktop(extensions);
  } else {
    return _pickExistingFilesMobile(extensions);
  }
}

Future<List<file_selector.XFile>?> _pickExistingFilesDesktop(
  List<String>? extensions,
) async {
  final typeGroup = file_selector.XTypeGroup(
    label: 'Files',
    extensions: extensions,
  );
  return file_selector.openFiles(
    acceptedTypeGroups: [typeGroup],
  );
}

Future<List<file_selector.XFile>?> _pickExistingFilesMobile(
  List<String>? extensions,
) async {
  final result = await FilePicker.platform.pickFiles(
    type: _fileType(extensions),
    allowedExtensions: extensions,
    allowMultiple: true,
  );
  return result?.files.map((file) => file.xFile).toList();
}

// --- Pick New File

Future<String?> pickNewFile({
  required String fileName,
  List<String>? extensions,
}) async {
  if (UniversalPlatform.isDesktop) {
    return _pickNewFileDesktop(fileName, extensions);
  } else {
    return _pickNewFileMobile(fileName, extensions);
  }
}

Future<String?> _pickNewFileDesktop(
  String fileName,
  List<String>? extensions,
) async {
  final typeGroup = file_selector.XTypeGroup(
    label: 'Files',
    extensions: extensions,
  );
  final saveLocation = await file_selector.getSaveLocation(
    suggestedName: fileName,
    acceptedTypeGroups: [typeGroup],
  );
  return saveLocation?.path;
}

Future<String?> _pickNewFileMobile(String fileName, List<String>? extensions) {
  return FilePicker.platform.saveFile(
    fileName: fileName,
    type: _fileType(extensions),
    allowedExtensions: extensions,
  );
}

// --- Helpers

FileType _fileType(List<String>? extensions) {
  return extensions == null //
      ? FileType.any
      : FileType.custom;
}
