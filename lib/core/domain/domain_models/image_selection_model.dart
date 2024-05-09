import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageSelectionModel {
  ImageSelectionModel(
      {required this.id, required this.file, this.isDummy = false});
  final String id;
  final XFile? file;
  bool isDummy = false;

  static ImageSelectionModel getDummyModel() {
    return ImageSelectionModel(
        id: const Uuid().v4(), file: null, isDummy: true);
  }
}
