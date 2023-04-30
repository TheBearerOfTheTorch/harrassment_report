import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipe_deck/swipe_deck.dart';

import 'components.dart';

class FilesDragDrop extends StatefulWidget {
  final Function passListEmpty;
  const FilesDragDrop({Key? key, required this.passListEmpty})
      : super(key: key);

  @override
  State<FilesDragDrop> createState() => _FilesDragDropState();
}

class _FilesDragDropState extends State<FilesDragDrop> {
  final List<XFile> _list = [];
  final List<Uint8List?> _uint8list = [];

  bool _dragging = false;
  bool _onHover = false;

  Offset? offset;

  ImageUploadHelper imageHelper = ImageUploadHelper();
  Uint8List imageBytes = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    return _list.isEmpty
        ? DropTarget(
            onDragDone: (detail) async {
              setState(() {
                _list.addAll(detail.files);
              });

              debugPrint('onDragDone:');
              for (final file in detail.files) {
                debugPrint('  ${file.path} ${file.name}'
                    '  ${await file.lastModified()}'
                    '  ${await file.length()}'
                    '  ${file.mimeType}');
              }

              //passing data to parent
              widget.passListEmpty(false);
            },
            onDragUpdated: (details) {
              setState(() {
                offset = details.localPosition;
              });
            },
            onDragEntered: (detail) {
              setState(() {
                _dragging = true;
                offset = detail.localPosition;
              });
            },
            onDragExited: (detail) {
              setState(() {
                _dragging = false;
                offset = null;
              });
            },
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _onHover = value;
                });
              },
              onTap: () {
                ///calling the upload image here
                selectImage();
              },
              child: Container(
                width: 420,
                height: 310,
                decoration: BoxDecoration(
                  color: _dragging
                      ? Colors.red.withOpacity(0.4)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Stack(
                  children: [
                    if (_list.isEmpty)
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.drag_indicator,
                              size: 30,
                            ),
                          ),
                          const Text(
                            "Add Images",
                          ),
                          const Text(
                            "or drag and drop",
                          ),
                        ],
                      )),
                    //buildFiles(),
                    if (offset != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '$offset',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                  ],
                ),
              ),
            ))
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  width: 420,
                  height: 310,
                  child: SwipeDeck(
                    onSwipeLeft: () {
                      //print("you swiped left");
                    },
                    onSwipeRight: () {
                      //print("you swiped Right");
                    },

                    ///changing here
                    widgets: _list.map((file) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          file.path,
                          height: 100,
                          width: 80,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 10,
                child: Column(
                  children: [
                    Container(
                      height: 23,
                      width: 23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                          onHover: (value) {
                            setState(() {});
                          },
                          child: const Icon(Icons.cancel),
                          onTap: () {
                            setState(() {
                              _list.clear();
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 160,
                    ),
                    Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(child: Text("${_list.length}"))),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {},
                        child: customLook(
                          icon: const Icon(Icons.edit),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: customLook(
                        icon: const Icon(Icons.select_all),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }

  Widget customLook({
    icon,
  }) {
    return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(5)),
        child: icon);
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