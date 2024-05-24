import 'package:file_picker/file_picker.dart';

abstract class SeoFileService {
  Future<FilePickerResult?> pickUpImageFile();
}

class SeoFileServiceImpl extends SeoFileService {
  @override
  Future<FilePickerResult?> pickUpImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
    return result;
  }
}
