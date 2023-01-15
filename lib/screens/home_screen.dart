//

import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/google_ml_apis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String recognizedText = '';
  File? _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR'),
      ),
      body: (Platform.isAndroid || Platform.isIOS)
          ? _mobile(context)
          : _desktop(context),
    );
  }

  Widget _mobile(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _pickedFile == null
              ? const Icon(Icons.image)
              : Image.file(_pickedFile!),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: SelectableText(
                recognizedText,
              ),
            ),
          ),
        ),
        _buttons(context),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => _uploadImage(context),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Pick Image',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(width: 32),
          TextButton(
            onPressed:
                _pickedFile == null ? null : () => _proccessFile(context),
            style: TextButton.styleFrom(
              backgroundColor:
                  _pickedFile == null ? Colors.blue.shade200 : Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Process Image',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final imagePicker = ImagePicker();
      // imagePicker.
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedFile = File(pickedFile.path);
        });
      }
    } else {
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: <String>['jpg', 'png', 'jpeg'],
      );
      final XFile? pickedXFile =
          await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

      if (pickedXFile != null) {
        setState(() {
          _pickedFile = File(pickedXFile.path);
        });
      }
    }
  }

  _proccessFile(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    final text = await GoogleMLApis.recognizeText(_pickedFile!);
    setState(() {
      recognizedText = text;
    });
    if (mounted) {}
    Navigator.of(context).pop();
  }

  Widget _desktop(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _pickedFile == null
                    ? const Icon(Icons.image)
                    : Image.file(_pickedFile!),
              ),
              Expanded(
                child: Center(
                  child: SelectableText(
                    recognizedText,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buttons(context),
      ],
    );
  }
}
