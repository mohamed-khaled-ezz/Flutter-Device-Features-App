import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Screen that allows users to pick multiple images from the device gallery and displays them in a ListView.
class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _selectedImages = [];

  /// Opens the device gallery to select multiple images using image_picker.
  Future<void> _pickImagesFromGallery() async {
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking images: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: Column(
        children: [
          // ListView to display selected images
          Expanded(
            child: _selectedImages.isEmpty
                ? const Center(
                    child: Text(
                      'No images picked yet.\nTap "Pick Image" below to select images.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      final XFile imageFile = _selectedImages[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Image.file(
                          File(imageFile.path),
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
          // Pick Image button placed below the ListView
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _pickImagesFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pick Image', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
