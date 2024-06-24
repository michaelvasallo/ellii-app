import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class PronunciationService {
  PronunciationService();

  Future<int> call(String audioFilePath, String referenceText) async {
    final endpoint = dotenv.env['AZURE_ENDPOINT']!;

    final headers = {
      'Ocp-Apim-Subscription-Key': dotenv.env['AZURE_SUBSCRIPTION_KEY']!,
      'Content-Type': 'audio/wav',
      'Pronunciation-Assessment': _assessmentHeader(referenceText),
    };

    final file = File(audioFilePath);
    if (!await file.exists()) {
      throw Exception('Audio file does not exist: $audioFilePath');
    }
    final fileBytes = file.readAsBytesSync();

    final response = await post(
      Uri.parse(endpoint),
      body: fileBytes,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('NBest')) {
        final score = jsonResponse['NBest'][0]['AccuracyScore'];
        return score.toInt();
      } else {
        return 0;
      }
    } else {
      throw Exception(
          'Failed to assess pronunciation: ${response.statusCode}, ${response.body}');
    }
  }

  String _assessmentHeader(String referenceText) {
    final params = {'ReferenceText': referenceText};
    final paramsJson = jsonEncode(params);
    final paramsBytes = utf8.encode(paramsJson);
    return base64.encode(paramsBytes);
  }
}
