//
/*
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_ml_vision_raw_bytes/firebase_ml_vision_raw_bytes.dart';

class FirebaseMlApis {
  static Future<String> recognizeText(File imageFile) async {
    // if (imageFile == null) {
    //   return 'No selected Image';
    // }
    try {
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(imageFile);
      final TextRecognizer textRecognizer =
          FirebaseVision.instance.textRecognizer();
      final VisionText visionText =
          await textRecognizer.processImage(visionImage);
      final text = _stringFromVisionText(visionText);
      return text.isEmpty ? 'No text found in image' : text;
    } catch (error) {
      return error.toString();
    }
  }

  static String _stringFromVisionText(VisionText visionText) {
    String text = '';
    /*

      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;
    */
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          text = '$text ${element.text}';
        }
        text = '$text\n';
      }
    }
    return text;
  }
}
*/