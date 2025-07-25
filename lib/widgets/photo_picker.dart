import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatefulWidget {
  final void Function(File?) onPhotoSelected;

  const PhotoPicker({super.key, required this.onPhotoSelected});

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  File? _imageFile;
  bool _isPicking = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (_isPicking) return;
    _isPicking = true;
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onPhotoSelected(_imageFile);
    }
    try {
      // код, который может вызвать ошибку
    } catch (e) {
      // обработка ошибки
    } finally {
      _isPicking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: CupertinoColors.systemGrey, width: 1),
              color: CupertinoColors.systemGrey5,
            ),
            child: _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_imageFile!, fit: BoxFit.cover),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.photo,
                          size: 40,
                          color: CupertinoColors.inactiveGray,
                        ),
                        //SizedBox(height: 8),
                        Text(
                          'Добавить',
                          style: TextStyle(
                            color: CupertinoColors.inactiveGray,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
