import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickHelper extends StatefulWidget {
  ImagePickHelper({Key? key}) : super(key: key);

  @override
  State<ImagePickHelper> createState() => _ImagePickHelperState();
}

class _ImagePickHelperState extends State<ImagePickHelper> {
  final List<XFile> _list = [];

  final List<Uint8List?> _uint8list = [];

  Uint8List imageBytes = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Column(
        children: [
          Image.memory(imageBytes),
          OutlinedButton(
            child: const Text("Select image"),
            onPressed: () {
              selectImage();
            },
          ),
        ],
      ),
    );
  }

  Future<void> selectImage() async {
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          imageBytes = f;
        });
      }
    }
  }
}