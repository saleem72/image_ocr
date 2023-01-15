//

import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class GoogleMLApis {
  GoogleMLApis._();

  static Future<String> recognizeText(File file) async {
    try {
      final inputImage = InputImage.fromFile(file);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      final text = _stringFromVisionText(recognizedText);
      return text.isEmpty ? 'No text found in image' : text;
    } catch (error) {
      return error.toString();
    }
  }

  static String _stringFromVisionText(RecognizedText visionText) {
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
